<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DoctorClinic extends Model
{
    use HasFactory;

    protected $fillable = ['price','times','doctor_id','clinic_id'];
    public function appointments(){
        return $this->hasMany(Appointments::class);
    }

    public function clinic(){
        return $this->belongsTo(Clinic::class);
    }

    public function doctor(){
        return $this->belongsTo(doctor::class);
    }


}
