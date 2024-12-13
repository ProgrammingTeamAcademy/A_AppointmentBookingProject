<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Middleware\Doctor;
use App\Models\doctor as ModelsDoctor;
use App\Models\DoctorSpecialist;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;

class DoctorController extends Controller
{

    public function __construct(){
        $this->middleware('auth:sanctum');
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $doctors = ModelsDoctor::with(['doctorClinics'])->get();

        return Response()->json([
            'doctors' => $doctors
        ],200);
    }


    /**
     * Display the specified resource.
     */
    public function show(string $doctor)
    {
        $doc = ModelsDoctor::where('id',$doctor)->with(['doctorClinics'])->first();

        return Response()->json([
            'doctor' => $doc,
            'message' => 'Doctor called successfully'
        ], 200);
    }
}
