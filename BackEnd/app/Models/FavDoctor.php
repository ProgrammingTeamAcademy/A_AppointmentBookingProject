<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FavDoctor extends Model
{
    use HasFactory;

    protected $fillable = ['user_id','doctor_id'];

    public function Doctor(){
        return $this->belongsTo(doctor::class);
    }

    public function User(){
        return $this->belongsTo(User::class);
    }
}
