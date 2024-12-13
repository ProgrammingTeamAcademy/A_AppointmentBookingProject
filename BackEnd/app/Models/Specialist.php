<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Specialist extends Model
{
    use HasFactory;

    protected $fillable = ['name','description'];

    public function doctorSpecialists(){
        return $this->hasMany(DoctorSpecialist::class);
    }

    public function doctor(){
        return $this->belongsTo(doctor::class);
    }
}
