<?php

namespace App\Models;

use Attribute;
use Illuminate\Database\Eloquent\Casts\Attribute as CastsAttribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Foundation\Auth\User as Authenticatable;
class admin extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $guard = 'admin';
    protected $fillable = [
        'email',
        'password'


    ];
    protected $hidden = [
        'password',
        'remember_token',
    ];
    // protected function password(): CastsAttribute
    // {
    //     return CastsAttribute::make(
    //         set: fn (string $value) =>
    //         Hash::make($value),
    //     );
    // }
}
