<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\DoctorClinic;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;

class DoctorClinicController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $DC = DoctorClinic::with(['doctor','clinic'])->get();

        return Response()->json([
            'avalible' => $DC
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $doctor_clinic)
    {
        $DC = DoctorClinic::where('id',$doctor_clinic)->with(['doctor','clinic'])->get()->first();

        return Response()->json([
            'avalible' => $DC
        ], 200);
    }

}
