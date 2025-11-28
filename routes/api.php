<?php

use App\Http\Controllers\Api\MessageController;
use Illuminate\Support\Facades\Route;

Route::post('/messages', [MessageController::class, 'store']);
Route::get('/messages', [MessageController::class, 'index']);