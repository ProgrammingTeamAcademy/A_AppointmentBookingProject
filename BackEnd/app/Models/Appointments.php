<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appointments extends Model
{
    use HasFactory;

    protected $fillable = ['appointment_date','day','time','status','user_id','doctor_clinic_id'];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function doctorClinic(){
        return $this->belongsTo(DoctorClinic::class);
    }
}
