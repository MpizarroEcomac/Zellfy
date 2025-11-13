<?php

use App\Http\Controllers\Api\ContactController;
use App\Http\Controllers\Api\LeadController;
use Illuminate\Support\Facades\Route;

Route::post('/contact', [ContactController::class, 'store']);

// Lead management endpoints
Route::post('/leads', [LeadController::class, 'store']);
Route::get('/leads/stats', [LeadController::class, 'stats']);
