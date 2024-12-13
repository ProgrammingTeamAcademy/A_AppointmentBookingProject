<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    use HasFactory;

    protected  $fillable = ['country_name'];

    protected $hidden = ['id','created_at','updated_at'];

    public function provincies(){
        return $this->hasMany(Province::class);
    }
}
