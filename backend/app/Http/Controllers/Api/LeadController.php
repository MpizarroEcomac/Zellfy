<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class LeadController extends Controller
{
    /**
     * Store a new lead from contact form
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        // Log incoming request
        Log::info('New lead submission', ['ip' => $request->ip()]);

        // Validación
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'required|string|max:20',
            'company' => 'nullable|string|max:255',
            'message' => 'nullable|string|max:1000',
            'source' => 'nullable|string|max:50'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Por favor verifica los datos del formulario',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Insertar en base de datos
            $leadId = DB::table('leads')->insertGetId([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'company' => $request->company ?? null,
                'notes' => $request->message ?? null,
                'source' => $request->source ?? 'website',
                'status' => 'new',
                'created_at' => now(),
                'updated_at' => now()
            ]);

            Log::info('Lead created successfully', ['lead_id' => $leadId, 'email' => $request->email]);

            // TODO: Enviar email de notificación (implementar después)
            // Mail::to('ventas@zellfy.ai')->send(new NewLeadNotification($lead));

            return response()->json([
                'success' => true,
                'message' => '¡Gracias por tu interés! Te contactaremos pronto.',
                'lead_id' => $leadId
            ], 201);

        } catch (\Exception $e) {
            Log::error('Error creating lead', [
                'error' => $e->getMessage(),
                'email' => $request->email
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error al procesar tu solicitud. Intenta nuevamente o contáctanos directamente.'
            ], 500);
        }
    }

    /**
     * Get lead statistics (for admin dashboard - opcional)
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function stats()
    {
        try {
            $stats = [
                'total' => DB::table('leads')->count(),
                'new' => DB::table('leads')->where('status', 'new')->count(),
                'today' => DB::table('leads')
                    ->whereDate('created_at', today())
                    ->count(),
                'this_month' => DB::table('leads')
                    ->whereMonth('created_at', now()->month)
                    ->whereYear('created_at', now()->year)
                    ->count(),
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener estadísticas'
            ], 500);
        }
    }
}
