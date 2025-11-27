<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class MessageController extends Controller
{
    /**
     * Store a new contact message.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'email' => 'nullable|email',
            'msg' => 'required|string|max:5000',
        ]);

        $message = Message::create($validated);

        return response()->json([
            'ok' => true,
            'id' => $message->id,
        ], 201);
    }

    /**
     * Retrieve all messages.
     */
    public function index(): JsonResponse
    {
        $messages = Message::orderBy('created_at', 'desc')->get();

        return response()->json([
            'ok' => true,
            'data' => $messages,
        ]);
    }
}
