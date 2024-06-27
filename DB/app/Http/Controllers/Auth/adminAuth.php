<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\admin;
use App\Models\doctor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Laravel\Sanctum\PersonalAccessToken;

class adminAuth extends Controller
{
    public function register(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'password' => 'required|string|min:3'
        ]);
        $admin = admin::create([
            'name' => $request->name,
            'password' => $request->password,

        ]);
        $token = $admin->createToken('token-name')->plainTextToken;

        return response()->json(['token' => $token]);
    }
    public function get_detals(Request $request)
    {
        $mytoken = $request->bearerToken();
        $tokenId = explode('|', $mytoken, 2)[0];
        $hashedToken = explode('|', $mytoken, 2)[1];
        $token = PersonalAccessToken::where('id', $tokenId)->first();

        // // الحصول على التوكن من قاعدة البيانات
        $t = $token->token;


        if (
            //!$token
            //|| 
            Hash::check(
                $hashedToken,
                $t

            )
        ) {
            return response()->json(['message' => 'التكون غير صالح'], 401);
        }

        // التوكن صالح
        // return response()->json(['message' => 'Token is valid', 'token' => $token]);



        return Response()->json([
            'info' => $request->user(),
            'my_name' => $token->name,


            //'now_name'=>

        ]);
    }
    public function acccept(Request $request)
    {
        $user = doctor::where('user_name', $request->user_name);




        if (!$user->exists()) {
            return  response()->json([
                "error" => 'لايوجد طبيب بهذا المعرف',
            ]);
        }
        doctor::where('user_name', $request->user_name)->update([
            'status' => $request->status

        ]);
        $doctor = $user->first();


        return  response()->json([
            "staues" => $doctor->status,
        ]);
    }
    public function   login(Request $request)
    {
        $rules = [
            'user_name' => 'required|string',
            'password' => 'required|string|min:3',
            // Add more rules as necessary
        ];
        $validator =
            Validator::make($request->all(), $rules,);
        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }
        $user = admin::where('name', $request->user_name)->first();
        if (!$user) {
            return response()->json(['message' => 'لايوجد حساب '], 403);
        }
        if (
            !Hash::check($request->password, $user->password)
        ) {
            return response()->json(['message' => 'كلمة السر غلط'], 403);
            // throw new AuthenticationException("لايوجد اسم نستخدم");
        }
        $token = $user->createToken('web');

        return [
            'token' => $token->plainTextToken,


        ];
    }
}
