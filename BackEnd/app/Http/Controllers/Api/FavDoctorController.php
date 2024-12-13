<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\doctor;
use App\Models\FavDoctor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FavDoctorController extends Controller
{

    public function __construct(){
        $this->middleware('auth:sanctum');
    }

    public function index()
    {
        $favDoctors = FavDoctor::where('user_id',Auth::user()->id)->get();

        return Response()->json(
             $favDoctors
        ,200);
    }

    public function store(doctor $doctor,Request $request)
    {
        $doc = doctor::where('id', $doctor->id)->first();

        if(!$doc){
            return response()->json([
                'message' => 'doctor not found!'
            ]);
        }

        $unFavDoc = FavDoctor::where('user_id',Auth::user()->id)->where('doctor_id',$doctor->id)->delete();

        if($unFavDoc){
            return response()->json([
                'message' => 'unFavDoc'
            ]);
        }
        $FavDoc = FavDoctor::create([
            'user_id' => Auth::user()->id,
            'doctor_id' => $doctor->id
        ]);
        if($FavDoc){
            return response()->json([
                'message' => 'FavDoc'
            ]);
        }
    }
}
