<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage;

class DoctorsResource extends JsonResource
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
            'name' => $this->name,
            'about_doctor' => $this->about_doctor,
            'phone' => $this->phone,
            'short_description' => $this->short_description,
            'createdAt' => (new Carbon($this->created_at))->format('Y-m-d'),
            'email' => $this->email,
            'specialist' => $this->specialist,
            'clinic'=>$this->clinic,
            'status' => $this->status,
            'image'=> $this->image ? Storage::url( $this->image) :'',
            'doctorClinics' => new DoctorClinicsResource($this->doctorClinics)
        ];
    }
}
