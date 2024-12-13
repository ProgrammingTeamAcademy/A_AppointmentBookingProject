<?php

namespace App\Http\Controllers;

use App\Http\Resources\AdminResource;
use App\Http\Resources\ClinicsResource;
use App\Http\Resources\DoctorsResource;
use App\Models\admin;
use App\Models\Clinic;
use App\Models\doctor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Psy\Readline\Hoa\Console;

class AdminController extends Controller
{

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $doctors = doctor::inRandomOrder()->get();
        $clinics = Clinic::inRandomOrder()->get();
        return Inertia('Admin/Index',[
            'doctors' => DoctorsResource::collection($doctors),
            'clinics' => ClinicsResource::collection($clinics)
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // return Inertia('Admin/Auth', [
        //     'status' => session('status'),
        // ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // $request->validate([
        //     'email' => 'required|email',
        //     'password' => 'required'
        // ]);

        // $credentials = $request->only(['email','password']);
        // // $pass = $request->password;
        // // $user = admin::create([
        // //     'email' => $request->email,
        // //     'password' => Hash::make($pass),
        // // ]);
        // // dump([$request->email , $pass]);
        // // dd($user);

        // $user = admin::where('email', $request->email)->first();
        // if (!$user) {
        //     throw ValidationException::withMessages([
        //         'email' => trans('auth.failed'),
        //     ]);
        // }

        // if (
        //     !Hash::check($request->password, $user->password)
        // ) {
        //     throw ValidationException::withMessages([
        //         'email' => trans('auth.failed'),
        //     ]);
        // }
        //     return to_route('admin.index');

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
    public function destroy(string $id)
    {
        //
    }
}
