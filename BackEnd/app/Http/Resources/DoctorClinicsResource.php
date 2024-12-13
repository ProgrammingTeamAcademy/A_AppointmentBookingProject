<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DoctorClinicsResource extends JsonResource
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
            'price' => $this->price,
            'times' => $this->times,
            'doctor_id' => $this->doctor_id,
            'clinic_id' => $this->clinic_id,
            'created_at' => (new Carbon($this->created_at))->format('Y-m-d'),
        ];
    }
}
