<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        //        \App\Models\User::factory(1)->create();

        \App\Models\User::factory()->create([
            'name' => 'halwa1', 'email' => 'halwadev@gmail.com',
            'user_name' => 'halwa'
        ]);
    }
}
