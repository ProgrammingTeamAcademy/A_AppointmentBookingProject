<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use App\Http\Requests\ClinicsRequest;
use App\Http\Requests\ClinicsUpdateRequest;
use App\Http\Resources\ClinicsResource;
use App\Http\Resources\CountryResource;
use App\Http\Resources\ProvinceResource;
use App\Models\Clinic;
use App\Models\Country;
use App\Models\Province;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ClinicController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return inertia('Clinic/Dashboard');
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
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit()
    {
        $countries = Country::orderBy('country_name','asc')->get();
        $provinces = Province::orderBy('province_name','asc')->get();
        $clinic = Auth::user();
        return Inertia('Clinic/Profile/Profile', [
            'c' => new ClinicsResource($clinic),
            'provinces' => ProvinceResource::collection($provinces),
            'countries' => CountryResource::collection($countries)
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ClinicsUpdateRequest $request, Clinic $clinic)
    {
        $data = $request->validated();
        $image = $data['image'] ?? null;
        $province_id = $data['province_id'] ?? null;
        if($image){
            if($clinic->image){
                Storage::disk('public')->deleteDirectory(dirname($clinic->image));
            }
            $data['image'] = $image->store('clinic/' . Str::random() , 'public');
        }else{
            $data['image'] = $clinic->image;
        }

        if($province_id == null){
            $data['province_id'] = $clinic->province_id;
        }
        $clinic->update($data);

        return to_route('profile.edit');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
