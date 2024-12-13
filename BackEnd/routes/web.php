<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\Auth\AdminSessionController;
use App\Http\Controllers\Auth\ClinicSessionController;
use App\Http\Controllers\Clinic\ClinicAppointmentController;
use App\Http\Controllers\Clinic\ClinicController;
use App\Http\Controllers\Clinic\ClinicDoctorController;
use App\Http\Controllers\Clinic\ClinicProfileController;
use App\Http\Controllers\ClinicsController;
use App\Http\Controllers\Doctor\DoctorController as DoctorDoctorController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\StateController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::redirect('/', 'login');
// // Route::redirect('/admin', 'admin.index');

// // Route::get('/dashboard', function () {
// //     return Inertia::render('Dashboard');
// // })->middleware(['auth', 'verified'])->name('dashboard');

// // Route::get('/admin', function () {
// //     return Inertia::render('Admin/Auth');
// // })->name('admin');

Route::middleware(['auth','verified'])->group(function(){
    Route::get('/dashboard', fn()=> Inertia::render('Dashboard'))->name('dashboard');


});




Route::get('admin/login', [AdminSessionController::class, 'create'])->name('admin.login');
Route::post('admin/login', [AdminSessionController::class, 'store'])->name('admin.store');

// Route::get('login', [ClinicSessionController::class, 'create'])->name('clinic.login');
// Route::post('login', [ClinicSessionController::class, 'store'])->name('clinic.store');

Route::middleware('auth:admin')->group(function(){
    Route::get('admin', [AdminController::class, 'index'])
                ->name('admin.index');
    Route::post('admin/logout', [AdminSessionController::class, 'destroy'])
                ->name('admin.logout');
    Route::resource('admin/clinics', ClinicsController::class)->only(['index','show','create','store','destroy']);
    Route::resource('admin/doctors', DoctorController::class)->only(['index','show']);
    Route::resource('admin/states', StateController::class)->only(['index']);
});

Route::middleware('auth:clinic')->group(function(){
    //doctor
    Route::get('clinic', [ClinicController::class, 'index'])
                ->name('clinic.dashboard');
    Route::get('clinic/doctors', [ClinicDoctorController::class,'index'])
    ->name('cdoctor.index');
    Route::get('clinic/doctors/create', [ClinicDoctorController::class,'create'])
    ->name('cdoctor.create');
    Route::post('clinic/doctors/create', [ClinicDoctorController::class,'store'])
    ->name('cdoctor.store');
    Route::put('clinic/doctors/actinc/{doctor}', [ClinicDoctorController::class,'activeDoctor'])
    ->name('cdoctor.activeDoctor');
    Route::get('clinic/doctors/{doctor}', [ClinicDoctorController::class,'show'])
    ->name('cdoctor.show');
    Route::delete('clinic/doctors/{doctor}', [ClinicDoctorController::class,'destroy'])
    ->name('cdoctor.delete');

    //appointments
    Route::get('clinic/appointment', [ClinicAppointmentController::class,'index'])
    ->name('cappointment.index');

    //profile
    Route::get('profile', [ClinicController::class,'edit'])
    ->name('profile.edit');
    Route::put('profile/{clinic}', [ClinicController::class,'update'])
    ->name('profile.update');

});

Route::middleware('auth:doctor')->group(function(){
    Route::get('doctor', [DoctorDoctorController::class, 'index'])
                ->name('doctor.dashboard');
    // Route::post('logout', [ClinicSessionController::class, 'destroy'])
    //             ->name('clinic.logout');

});

require __DIR__.'/auth.php';
