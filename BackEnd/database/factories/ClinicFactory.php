<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Clinic>
 */
class ClinicFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected static ?string $password;

    public function definition(): array
    {
        return [
            'phone' => '0123456789',
            'name' => 'Super Clinic',
            'address' => 'sdfsdfdsfsdf vsdv12316 ssd',
            'province_id' => 2,
            'image'=>'clinic/ozgWqIUq5QtTEUqi/yXrhHOCPqR3F9OPPxYGbB3rSgtteICs13W1badQt.jpg',
            'about' => 'vvvvvvvvvvvvvvsddddddd svsdvsdvdvbddf xcvxcvdfbdfb',
            'password' => static::$password ??= Hash::make('password'),
        ];
    }
}
