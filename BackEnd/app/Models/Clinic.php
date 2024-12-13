<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
class Clinic extends Authenticatable
{
    use HasFactory;

    protected $fillable = ['name','phone','address','about','image','province_id'];

    protected $appends = ['province'];

    public function province(){
        return $this->belongsTo(Province::class);
    }

    public function doctorClinics(){
        return $this->hasMany(DoctorClinic::class);
    }

    public function getProvinceAttribute(){
        return $this->province()->where('id',$this->province_id)->first()->province_name ?? '';
    }
}
