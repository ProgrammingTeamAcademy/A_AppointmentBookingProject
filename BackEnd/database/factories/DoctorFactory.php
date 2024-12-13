<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Doctor>
 */
class DoctorFactory extends Factory
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
            'name' => 'Mosa Amed',
            'user_name' => 'mosaahmed',
            'status' => 'yes',
            'email' => 'mosaahmed@gmail.com',
            'image'=>'',
            'about_doctor' => 'vvvvvvvvvvvvvvsddddddd svsdvsdvdvbddf xcvxcvdfbdfb',
            'short_description' => 'cdssdbsdhbvsdjhsdjkf sdnjsdkvbsdv skvbskvsdklv',
            'password' => static::$password ??= Hash::make('password'),
        ];
    }
}
