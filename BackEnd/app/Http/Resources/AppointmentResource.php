<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AppointmentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'appointment_date' => $this->appointment_date,
            'day' => $this->day,
            'time' => $this->time,
            'status' => $this->status,
            'doctor_clinic' =>new DoctorClinicsResource($this->doctorClinic),
            'doctor' => new DoctorsResource($this->doctorClinic->doctor),
            'patient' => new PatientResource($this->user),
            'appointmentDate' => (new Carbon($this->appointment_date))->format('Y-m-d'),
        ];
    }
}
