<?php

use App\Http\Controllers\Api\MessageController;
use App\Http\Controllers\Api\BookingController;
use Illuminate\Support\Facades\Route;

// Contact messages
Route::post('/messages', [MessageController::class, 'store']);
Route::get('/messages', [MessageController::class, 'index']);

// Booking routes
Route::post('/bookings', [BookingController::class, 'store']);
Route::get('/bookings', [BookingController::class, 'index']);
Route::get('/bookings/{photoshoot}', [BookingController::class, 'show']);
Route::get('/bookings/available-slots', [BookingController::class, 'availableSlots']);
