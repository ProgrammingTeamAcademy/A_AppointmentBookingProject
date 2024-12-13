<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Appointments;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AppointmentsController extends Controller
{

    public function __construct(){
        $this->middleware('auth:sanctum');
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $appointment = Appointments::with(['doctorClinic.doctor','doctorClinic.clinic'])->where('user_id',Auth::user()->id)->get();

        return Response()->json([
            'appointments' => $appointment
        ],200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validate = $request->validate([
            'doctor_clinic_id' => 'required',
            'appointment_date' => 'required',
            'day' => 'required',
            'time'=> 'required',
        ]);

        Appointments::create([
            'user_id' => Auth::user()->id,
            'doctor_clinic_id' => $validate['doctor_clinic_id'],
            'appointment_date' => $validate['appointment_date'],
            'day' => $validate['day'],
            'time' => $validate['time'],
            'status' => 'upcoming'
        ]);


        return Response()->json([
            'message' => 'Appointment taked successfully'
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $appointment)
    {
        $appointment = Appointments::where('user_id',Auth::user()->id)
            ->where('id',$appointment)->first();

        return Response()->json([
            'appointment' => $appointment
        ],200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $appointment)
    {

        $appointment = Appointments::where('user_id',Auth::user()->id)
            ->where('id',$appointment)->first();


        $appointment->update([
            'user_id' => Auth::user()->id,
            'doctor_clinic_id' => $request['doctor_clinic_id'] ?? $appointment['doctor_clinic_id'],
            'appointment_date' => $request['appointment_date']?? $appointment['appointment_date'],
            'day' => $request['day']?? $appointment['day'],
            'time' => $request['time']?? $appointment['time'],
            'status' => $request['status']?? $appointment['status']
        ]);


        return Response()->json([
            'message' => 'Appointment updated successfully'
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $appointment)
    {
        Appointments::where('user_id',Auth::user()->id)
             ->where('id',$appointment)->delete();

        return Response()->json([
            'meesage' => 'your appointment deleted successfully'
        ],200);
    }
}
