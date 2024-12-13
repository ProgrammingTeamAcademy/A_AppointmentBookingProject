<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Province extends Model
{
    use HasFactory;

    protected  $fillable = ['country_id','province_name'];

    protected $hidden = ['created_at','updated_at','country_id'];

    protected $appends = ['country'];

    public function country(){
        return $this->belongsTo(Country::class);
    }

    public function users(){
        return $this->hasMany(User::class);
    }

    public function clinics(){
        return $this->hasMany(Clinic::class);
    }

    public function getCountryAttribute(){
        return $this->country()->where('id', $this->country_id)->first()->country_name;
    }
}
