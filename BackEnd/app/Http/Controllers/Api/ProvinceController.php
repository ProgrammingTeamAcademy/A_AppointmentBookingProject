<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Country;
use App\Models\Province;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;

class ProvinceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function show(string $country)
    {
        $provinces = Province::where('country_id',$country)->get();

        return Response()->json([
            'provinces' => $provinces
        ], 200);
    }

    public function index()
    {
        $provinces = Province::get();

        return Response()->json([
            'provinces' => $provinces
        ], 200);
    }

}
