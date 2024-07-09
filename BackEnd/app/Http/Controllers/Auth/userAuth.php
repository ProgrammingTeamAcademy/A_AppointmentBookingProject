<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\PersonalAccessToken;

class userAuth extends Controller
{
    public function login(Request $request)
    {
        $this->validate($request, [
            'phone' => 'required|numeric',
            'password' => 'required',
            //'user_name' => 'required'
        ]);
        $user = User::where('phone', $request->phone);
        if (!$user->exists()) {
            return Response()->json([
                'massge' => 'There is no account',
            ], 201);
        }

        if (!auth()->attempt($request->only('phone', 'password'))) {
            throw new AuthenticationException("كلمة السر غلط");
        }
        // else if (!auth()->attempt($request->only('email,password'))) {
        //     throw new AuthenticationException("كلمة المرور غير صحيحة");
        // }
        $user = $user->first();
        $token = $user->createToken('web');

        return [
            'token' => $token->plainTextToken,


        ];
    }
    public function register(Request $request)
    {
        $this->validate($request, [

            // 'email' => 'required|email',

            'password' => 'required|min:6',
            'phone' => 'required|numeric|digits_between:9,15',
            'name' => 'required'      //'user_name' => 'required')
        ]);
        $doctor = User::create([

            'phone' => $request->phone,
            'name' => $request->name,
            'password' => bcrypt($request->password),

            // Add other doctor fields here
        ]);
        $token = $doctor->createToken('token-name')->plainTextToken;

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


        // $plainTextToken = ;



    }
}
