<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response;

class AuthenticatedSessionController extends Controller
{


    public function __construct(){
        $this->middleware(['guest:clinic,doctor'], ['except' => ['destroy']]);
    }
    /**
     * Display the login view.
     */
    public function create(): Response
    {

        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(Request $request): RedirectResponse
    {
        // dd($request);
        if($request->type == 'clinic' && Auth::guard('clinic')->attempt($request->only('phone', 'password'), false)){
            $request->session()->regenerate();

        return redirect()->intended(default: route('clinic.dashboard'));
        }elseif($request->type == 'doctor' && Auth::guard('doctor')->attempt($request->only('phone', 'password'), false)){
            $request->session()->regenerate();

        return redirect()->intended(default: route('doctor.dashboard'));
        }
        throw ValidationException::withMessages([
            'phone' => trans('auth.failed'),
        ]);
        // $request->authenticate();

        // $request->session()->regenerate();

        // return redirect()->intended(RouteServiceProvider::HOME);
    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::logout();
        return redirect()->intended(default: route('login'));
        // $request->session()->invalidate();

        // $request->session()->regenerateToken();

        // return redirect('/');
    }
}
