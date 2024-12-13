<?php

namespace App\Http\Controllers;

use App\Http\Resources\DoctorsResource;
use App\Models\doctor;
use Illuminate\Http\Request;

class DoctorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $sort_by = request('sort_by', 'created_at');
        $sort_dir = request('sort_dir' , 'desc');


        $doctors = doctor::orderBy($sort_by,$sort_dir)->paginate(10)->onEachSide(1)->all();
        return inertia('Admin/Doctors/Index',[
            'doctors' => DoctorsResource::collection($doctors),
            'queryParams' => request()->query() ?:null,
            'success' => session('success')
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(doctor $doctor)
    {

        return inertia('Admin/Doctors/Show',[
            'Doctor' => new DoctorsResource($doctor)
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(doctor $doctor)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, doctor $doctor)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(doctor $doctor)
    {
        //
    }
}
