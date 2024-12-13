<?php

use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->string('appointment_date');
            $table->string('time');
            $table->string('day');
            $table->string('status');
            $table->foreignIdFor(User::class)->constrained();
            $table->unsignedBigInteger('doctor_clinic_id');
            $table->foreign('doctor_clinic_id')->references('id')->on('doctor_clinics');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('appointments');
    }
};
