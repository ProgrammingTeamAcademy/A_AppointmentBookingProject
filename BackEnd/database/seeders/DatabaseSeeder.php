<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\admin;
use App\Models\Clinic;
use App\Models\doctor;
use App\Models\Specialist;
use Database\Factories\AdminFactory;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        //  $this->call([CountrySeeder::class,ProvinceSeeder::class]);



        doctor::factory()->create();

    }
}
