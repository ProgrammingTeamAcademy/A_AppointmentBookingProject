<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Clinic;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;

class ClinicController extends Controller
{

    public function __construct(){
        $this->middleware('auth:sanctum');
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $clinics = Clinic::get()->sortBy('name');

        return Response()->json([
            'clinic' => $clinics
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $clinic)
    {
        $c = Clinic::where('id',$clinic)->first();

        return Response()->json([
            'clinic' => $c,
            'message' => 'got it successfully'
        ], 200);
    }

}
