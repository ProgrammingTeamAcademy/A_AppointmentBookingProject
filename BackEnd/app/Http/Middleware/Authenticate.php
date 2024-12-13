<?php

namespace App\Http\Middleware;

use Illuminate\Auth\AuthenticationException;
use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Request;

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     */
    protected function redirectTo(Request $request, $guards): ?string
    {
        $guard = $guards[0];

        switch ($guard) {

            case 'clinic':
                $login = 'login';
                break;
            case 'doctor':
                $login = 'login';
                break;
            case 'admin':
                $login = 'admin.login';
                break;
            default:
                $login = 'login';
                break;
        }
        return $request->expectsJson() ? null : route($login);

    }
}
