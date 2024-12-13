<?php

namespace App\Models;

use App\Enums\Status;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use NunoMaduro\Collision\Adapters\Phpunit\State;
use StatusDoctor as GlobalStatusDoctor;
use Illuminate\Foundation\Auth\User as Authenticatable;

class doctor extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'user_name',
        'name',
        'phone',
        'image',
        'short_description',
        'about_doctor'
    ];


    protected $appends = ['specialist','clinic'];
    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'status' => Status::class,

    ];
    protected $attributes = [
        'status' => Status::REQ,
    ];

    public function doctorClinics(){
        return $this->hasOne(DoctorClinic::class);
    }

    public function doctorSpecialists(){
        return $this->hasOne(DoctorSpecialist::class);
    }

    public function specialist(){
        return $this->hasOne(Specialist::class);
    }

    public function getSpecialistAttribute(){
        return $this->doctorSpecialists()->where('doctor_id',$this->id)->first()->specialist->name ?? '';
    }

    public function favDoctors(){
        return $this->hasMany(FavDoctor::class);
    }

    public function getClinicAttribute(){
        return $this->doctorClinics()->where('doctor_id',$this->id)->first()->clinic->name ?? '';
    }
}
