<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Specialist>
 */
class SpecialistFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $sp = ['General','Dentist','Surgery','Nerves','Cardiologist'];

        return [
            'name' => fake()->randomElement($sp),
            'description' => fake()->paragraph(2 , true)
        ];
    }
}
