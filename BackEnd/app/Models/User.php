<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'phone',
        'email',
        'province_id',
    ];
    protected $appends = ['province','country_name'];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'email',
        'remember_token',
        'email_verified_at'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function Province(){
        return $this->belongsTo(Province::class);
    }

    public function appointments(){
        return $this->hasMany(Appointments::class);
    }

    public function favDoctors(){
        return $this->hasMany(FavDoctor::class);
    }

    public function getProvinceAttribute(){
        return $this->Province()->where('id',$this->province_id)->first()->province_name ?? '';
    }

    public function getCountryNameAttribute(){
        return $this->Province()->where('id',$this->province_id)->first()->country ?? '';
    }
}
