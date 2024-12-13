<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Api\DoctorController;
use App\Http\Requests\ClinicsRequest;
use App\Http\Resources\ClinicsResource;
use App\Http\Resources\CountryResource;
use App\Http\Resources\DoctorsResource;
use App\Http\Resources\ProvinceResource;
use App\Models\Clinic;
use App\Models\Country;
use App\Models\doctor;
use App\Models\Province;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ClinicsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $sort_by = request('sort_by', 'created_at');
        $sort_dir = request('sort_dir' , 'desc');


        $clinics = Clinic::orderBy($sort_by,$sort_dir)->paginate(10)->onEachSide(1)->all();
        return inertia('Admin/Clinics/Index',[
            'clinics' => ClinicsResource::collection($clinics),
            'queryParams' => request()->query() ?:null,
            'success' => session('success')
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $countries = Country::orderBy('country_name','asc')->get();
        $provinces = Province::orderBy('province_name','asc')->get();
        return inertia('Admin/Clinics/Create',[
            'provinces' => ProvinceResource::collection($provinces),
            'countries' => CountryResource::collection($countries)
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ClinicsRequest $request)
    {
        $data = $request->validated();
        if($request['about'] == null){
            $data['about'] = '';
        }

        $image = $request['image'] ?? null;
        if($image){
            $data['image']= $image->store('clinic/' . Str::random() , 'public');
        }

        Clinic::create($data);

        return to_route('clinics.index')->with('success','Clinic add successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(Clinic $clinic)
    {
        $sort_by = request('sort_by', 'created_at');
        $sort_dir = request('sort_dir' , 'desc');

        $doctors = doctor::orderBy($sort_by,$sort_dir)->with(['doctorClinics'])
                    ->paginate(10)->onEachSide(1)->all();
        return inertia('Admin/Clinics/Show',[
            'Clinic' => new ClinicsResource($clinic),
            'queryParams' => request()->query() ?:null,
            'doctors' => DoctorsResource::collection($doctors)
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Clinic $clinic)
    {
        $clinic->delete();
        if($clinic->image){
            Storage::disk('public')->deleteDirectory(dirname($clinic->image));
        }

        return to_route('clinics.index')->with('success','Clinic was deleted');
    }
}
