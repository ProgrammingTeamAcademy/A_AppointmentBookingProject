<?php

namespace App\Http\Middleware;

use App\Providers\RouteServiceProvider;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RedirectIfAuthenticated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, string ...$guards): Response
    {
        $guards = empty($guards) ? [null] : $guards;

        foreach ($guards as $guard) {
            switch ($guard) {
                case 'clinic':
                    if (Auth::guard($guard)->check()) {
                        return redirect(route('clinic.dashboard'));
                    }
                    break;
                case 'admin':
                    if (Auth::guard($guard)->check()) {
                        return redirect(route('admin.index'));
                    }
                    break;

                default:
                if (Auth::guard($guard)->check()) {
                    return redirect(route('doctor.dashboard'));
                }
                    break;
            }
            // if (Auth::guard($guard)->check()) {
            //     return redirect(RouteServiceProvider::HOME);
            // }
            // elseif (Auth::guard('admin')->check()) {
            //     return redirect(route('admin.index'));
            // }
        }

        return $next($request);
    }
}
