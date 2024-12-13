<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\AdminLoginRequest;
use App\Models\admin;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response;

class ClinicSessionController extends Controller
{

    public function __construct(){
        $this->middleware('guest:clinic', ['except' => ['destroy']]);
    }
    /**
     * Display the login view.
     */
    public function create(): Response
    {
        return Inertia('Auth/Login', [
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(Request $request): RedirectResponse
    {
        if(Auth::guard('clinic')->attempt($request->only('phone', 'password'), false)){
            $request->session()->regenerate();

        return redirect()->intended(default: route('clinic.dashboard'));
        }
        throw ValidationException::withMessages([
            'phone' => trans('auth.failed'),
        ]);

        // $request->authenticate();


        // return to_route('admin.index');

    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('clinic')->logout();

        // $request->session()->invalidate();

        // $request->session()->regenerateToken();


        return redirect()->intended(default: route('clinic.login'));
        // return to_route('admin.login');
    }
}
