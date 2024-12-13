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

class AdminSessionController extends Controller
{

    public function __construct(){
        $this->middleware('guest:admin', ['except' => ['destroy']]);
    }
    /**
     * Display the login view.
     */
    public function create(): Response
    {
        return Inertia('Admin/Auth', [
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(Request $request): RedirectResponse
    {
        // $request->validate([
        //     'email' => 'required|email',
        //     'password' => 'required'
        // ]);

        $credentials = $request->only(['email','password']);
        // // $pass = $request->password;
        // // $user = admin::create([
        // //     'email' => $request->email,
        // //     'password' => Hash::make($pass),
        // // ]);
        // // dump([$request->email , $pass]);
        // // dd($user);

        // // $user = admin::where('email', $request->email)->first();
        // // if (!$user) {
        // //     throw ValidationException::withMessages([
        // //         'email' => trans('auth.failed'),
        // //     ]);
        // // }

        // // if (
        // //     !Hash::check($request->password, $user->password)
        // // ) {
        // //     throw ValidationException::withMessages([
        // //         'email' => trans('auth.failed'),
        // //     ]);
        // // }


        if(Auth::guard('admin')->attempt($request->only('email', 'password'), false)){
            $request->session()->regenerate();

        return redirect()->intended(default: route('admin.index'));
        }
        throw ValidationException::withMessages([
            'email' => trans('auth.failed'),
        ]);

        // $request->authenticate();


        // return to_route('admin.index');

    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('admin')->logout();

        // $request->session()->invalidate();

        // $request->session()->regenerateToken();


        return redirect()->intended(default: route('admin.login'));
        // return to_route('admin.login');
    }
}
