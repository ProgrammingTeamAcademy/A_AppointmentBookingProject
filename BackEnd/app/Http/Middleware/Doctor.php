<?php

namespace App\Http\Middleware;

use App\Http\Controllers\Auth\doctorAuth;
use App\Models\doctor as ModelsDoctor;
use Closure;

use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Response;

class Doctor
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $rules = [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
            // Add more rules as necessary
        ];

        $validator =
            Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()->all(),
            ], 422);
        }


        $user = ModelsDoctor::where('email', $request->email)->first();
        if (!$user) {
            return response()->json(['message' => 'لايوجد حساب '], 403);
        }
        if (
            !Hash::check($request->password, $user->password)
        ) {
            return response()->json(['message' => 'كلمة السر غلط'], 403);
            // throw new AuthenticationException("لايوجد اسم نستخدم");
        }

        if ($user->status == 'req') {
            return response()->json(['message' => 'بانتظار موافقة المشرف',],);
        }
        if ($user->status == 'no') {
            return response()->json(['message' => 'تم رفض الطلب من قبل الادمن',],);
        }
        if ($user->status == 'delete') {
            return response()->json(['message' => 'تم فصلك',],);
        }
        return $next($request);

        return response()->json(['message' => 'Unauthorized', 's' => $user->status], 403);
    }
}
