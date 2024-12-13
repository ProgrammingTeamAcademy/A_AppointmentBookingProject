<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage;

class ClinicsResource extends JsonResource
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
            'about' => $this->about,
            'phone' => $this->phone,
            'address' => $this->address,
            'createdAt' => (new Carbon($this->created_at))->format('Y-m-d'),
            'province' => $this->province,
            'province_id' => $this->province_id,
            'image'=> $this->image ? Storage::url( $this->image) :''
        ];
    }
}
