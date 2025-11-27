<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use App\Models\Photoshoot;
use App\Models\Appointment;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Carbon;

class BookingController extends Controller
{
    /**
     * Create a new booking (customer + photoshoot + appointment)
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'customer.name' => 'required|string|max:255',
            'customer.email' => 'required|email',
            'customer.phone' => 'nullable|string|max:20',
            'customer.notes' => 'nullable|string',
            'photoshoot.type' => 'required|string|in:portrait,wedding,event,product,other',
            'photoshoot.description' => 'nullable|string',
            'photoshoot.duration_minutes' => 'required|integer|min:30|max:480',
            'photoshoot.price' => 'nullable|numeric|min:0',
            'appointment.scheduled_at' => 'required|date|after:now',
            'appointment.location' => 'nullable|string|max:255',
            'appointment.notes' => 'nullable|string',
        ]);

        // Create customer
        $customer = Customer::create($validated['customer']);

        // Create photoshoot
        $photoshoot = $customer->photoshoots()->create($validated['photoshoot']);

        // Create appointment
        $appointment = $photoshoot->appointments()->create($validated['appointment']);

        return response()->json([
            'ok' => true,
            'booking_id' => $photoshoot->id,
            'message' => 'Booking created successfully',
            'data' => [
                'customer' => $customer,
                'photoshoot' => $photoshoot,
                'appointment' => $appointment,
            ]
        ], 201);
    }

    /**
     * Get available time slots for a given date
     */
    public function availableSlots(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'date' => 'required|date_format:Y-m-d',
        ]);

        $date = Carbon::parse($validated['date']);
        $startOfDay = $date->copy()->startOfDay();
        $endOfDay = $date->copy()->endOfDay();

        // Get booked appointments for the day
        $bookedAppointments = Appointment::whereBetween('scheduled_at', [$startOfDay, $endOfDay])
            ->whereIn('status', ['scheduled', 'confirmed'])
            ->get();

        // Generate available slots (every 30 minutes from 9 AM to 5 PM)
        $availableSlots = [];
        $startTime = $date->copy()->setTime(9, 0); // 9:00 AM
        $endTime = $date->copy()->setTime(17, 0); // 5:00 PM

        while ($startTime <= $endTime) {
            $slotEnd = $startTime->copy()->addMinutes(30);
            
            // Check if slot is available (no overlapping appointments)
            $isAvailable = !$bookedAppointments->contains(function ($appointment) use ($startTime, $slotEnd) {
                $appointmentStart = Carbon::parse($appointment->scheduled_at);
                $appointmentEnd = $appointmentStart->copy()->addMinutes($appointment->photoshoot->duration_minutes);
                
                return $startTime < $appointmentEnd && $slotEnd > $appointmentStart;
            });

            if ($isAvailable) {
                $availableSlots[] = [
                    'start' => $startTime->format('H:i'),
                    'end' => $slotEnd->format('H:i'),
                    'datetime' => $startTime->format('Y-m-d H:i:s'),
                ];
            }

            $startTime->addMinutes(30);
        }

        return response()->json([
            'ok' => true,
            'date' => $date->format('Y-m-d'),
            'available_slots' => $availableSlots,
        ]);
    }

    /**
     * Get all bookings (for admin dashboard)
     */
    public function index(): JsonResponse
    {
        $bookings = Photoshoot::with(['customer', 'appointments'])
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'ok' => true,
            'data' => $bookings,
        ]);
    }

    /**
     * Get a specific booking
     */
    public function show(Photoshoot $photoshoot): JsonResponse
    {
        $photoshoot->load(['customer', 'appointments']);

        return response()->json([
            'ok' => true,
            'data' => $photoshoot,
        ]);
    }
}