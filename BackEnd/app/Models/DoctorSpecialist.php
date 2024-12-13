<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DoctorSpecialist extends Model
{
    use HasFactory;

    protected $fillable = ['doctor_id','specialist_id'];

    public function doctor(){
        return $this->belongsTo(doctor::class);
    }

    public function specialist(){
        return $this->belongsTo(Specialist::class);
    }
}
