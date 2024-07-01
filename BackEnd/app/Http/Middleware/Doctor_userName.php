<?php

namespace App\Http\Middleware;

use App\Models\doctor;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Response;

class Doctor_userName
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $rules = [
            'user_name' => 'required|string',
            'password' => 'required|string|min:6',
            // Add more rules as necessary
        ];
        $messages = [
            'user_name.required' => 'حقل اسم المستخدم مطلوب',
            'password.required' => 'حقل كلمة المرور مطلوب',
            'password.min' => 'يجب أن تكون كلمة المرور على الأقل :min أحرف',
        ];

        $validator =
            Validator::make($request->all(), $rules, $messages);
        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }


        $user = doctor::where('user_name', $request->user_name)->first();
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
            return response()->json(['message' => 'تم فصلك ',],);
        }
        return $next($request);

        return response()->json(['message' => 'Unauthorized', 's' => $user->status], 403);
    }
}
