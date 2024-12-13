<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use App\Http\Requests\DoctorRequest;
use App\Http\Resources\DoctorsResource;
use App\Http\Resources\SpecialistResource;
use App\Models\Clinic;
use App\Models\doctor;
use App\Models\DoctorClinic;
use App\Models\DoctorSpecialist;
use App\Models\Specialist;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ClinicDoctorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $sort_by = request('sort_by', 'created_at');
        $sort_dir = request('sort_dir' , 'desc');
        $clinic = Auth::user();
        $Doctors = doctor::orderBy($sort_by,$sort_dir)
        ->whereHas('doctorClinics', function($q) use ($clinic) {
            $q->where('clinic_id', $clinic['id']);
        })
        ->with('doctorClinics')->get();

        return inertia('Clinic/Doctor/Index',[
            'doctors' => DoctorsResource::collection($Doctors)
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $specialist = Specialist::orderBy('name', 'asc')->get();
        return inertia('Clinic/Doctor/Create',[
            'specialist' => SpecialistResource::collection($specialist)
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(DoctorRequest $request)
    {
        $data = $request->validated();
        $clinic = Auth::user();
        // new doctor
        if($request['about'] == null){
            $data['short_description'] = '';
        }else{$data['short_description'] = $request['about'];}
        $data['password'] = Hash::make('password');
        $data['status'] = 'no';
        $data['user_name'] = str_replace(" ","",$request['name']);
        $image = $request['image'] ?? null ;
        if($image){
            $data['image'] = $image->store('doctor/' . Str::random(), 'public');
        }else{$data['image'] = '';}
        doctor::create($data);
        //new doctor clinic
        $doctor = doctor::where('phone',$data['phone'])->where('name',$data['name'])->get();
        $doctor_id = $doctor[0]['id'];
        $DCdata['clinic_id'] = $clinic['id'];
        $DCdata['doctor_id'] =  $doctor_id;
        DoctorClinic::create($DCdata);
        //new doctor specialist
        $DSdata['doctor_id'] = $doctor_id;
        $DSdata['specialist_id'] = $data['specialist'];
        DoctorSpecialist::create($DSdata);

        return to_route('cdoctor.index')->with('success','Clinic add successfully');

    }

    /**
     * Display the specified resource.
     */
    public function show(doctor $doctor)
    {


        return inertia('Clinic/Doctor/Show',[
            'doctor' => new DoctorsResource($doctor)
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
    public function destroy(doctor $doctor)
    {
        // DoctorSpecialist::where('doctor_id',$doctor['id'])->delete();
        DoctorClinic::where('doctor_id',$doctor['id'])->delete();
        // $doctor->delete();
        // if($doctor->image){
        //     Storage::disk('public')->deleteDirectory(dirname($doctor->image));
        // }

        return to_route('cdoctor.index')->with('success','Doctor was deleted');

    }


    public function activeDoctor(doctor $doctor){
        if($doctor['status'] == 'yes'){
            $doctor['status'] = 'no';
        }else{ $doctor['status'] = 'yes';}
        $doctor->update(['status' => $doctor['status']]);

        return to_route('cdoctor.show',['doctor' => new DoctorsResource($doctor)])->with('success','Doctor was activated');

    }
}
