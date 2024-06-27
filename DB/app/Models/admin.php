<?php

namespace App\Models;

use Attribute;
use Illuminate\Database\Eloquent\Casts\Attribute as CastsAttribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;

class admin extends Model
{
    use HasApiTokens, HasFactory, Notifiable;
    protected $fillable = [
        'name',

        'password',


    ];
    protected $hidden = [
        'password',
        'remember_token',
    ];
    protected function password(): CastsAttribute
    {
        return CastsAttribute::make(
            set: fn (string $value) =>
            Hash::make($value),
        );
    }
}
