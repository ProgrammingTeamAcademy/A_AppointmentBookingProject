<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\doctor;
use App\Models\User;
use GuzzleHttp\Psr7\Response;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\PersonalAccessToken;

class doctorAuth extends Controller
{
    public function login_email(Request $request)
    {

        $user = doctor::where('email', $request->input);

        // else if (!auth()->attempt($request->only('email,password'))) {
        //     throw new AuthenticationException("كلمة المرور غير صحيحة");
        // }
        $user = $user->first();
        $token = $user->createToken('web');

        return [
            'token' => $token->plainTextToken,


        ];
    }
    public function login_name(Request $request)
    {

        $user = doctor::where('user_name', $request->user_name);

        $doctor = $user->first();


        // else if (!auth()->attempt($request->only('email,password'))) {
        //     throw new AuthenticationException("كلمة المرور غير صحيحة");
        // }
        $user = $user->first();
        $token = $user->createToken('web');


        return  response()->json([
            'token' => $token->plainTextToken,


        ]);
    }


    public function nameEx(Request $request)
    {
        if (doctor::where('user_name', $request->user_name)->exists()) {
            return  response()->json([
                "name_ex" => true,
            ]);
        } else {
            return  response()->json([
                "name_ex" => false,
            ]);
        }
    }
    public function register(Request $request)
    {
        $this->validate($request, [
            'user_name' => 'required|string',
            'email' => 'required|email',

            'password' => 'required',
            'phone' => 'required|numeric|digits_between:10,15',        //'user_name' => 'required')
        ]);
        $user = doctor::where('email', $request->email);

        if ($user->exists()) {
            return Response()->json([


                'massge' => 'الايميل لديه حساب بل فعل',
            ], 200);
        }

        $doctor = doctor::create([
            'user_name' => $request->user_name,
            'email' => $request->email,
            'name' => $request->name,
            'password' => bcrypt($request->password),
            'phone' => $request->phone,

            // Add other doctor fields here
        ]);
        // $token = $doctor->createToken('token-name')->plainTextToken;

        return response()->json(['massges' => 'تم تنشاء حساب بانتظار موافقة المشرف']);
    }
    public function acconts(Request $request)
    {
        $request->validate([
            'tokens' => 'required|string',
        ]);

        $identifier = $request->input('tokens');

        $doctor = Doctor::where('email', $identifier)
            ->orWhere('user_name', $identifier)
            ->first();

        if ($doctor) {

            $tokens = PersonalAccessToken::where('tokenable_id', $doctor->id)
                ->where('tokenable_type', 'App\Models\Doctor')
                ->get();

            $tokensList = $tokens->map(function ($token) {
                return [
                    'name' => $token->name,
                    'token' => $token->token,
                    'created_at' => $token->created_at,
                    'last_used_at' => $token->last_used_at,
                ];
            });

            return response()->json([
                'status' => 'success',
                'tokens' => $tokensList,
            ]);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'لا يوجد طبيب بهذا المعرف',
            ], 404);
        }
    }

    public function delete(Request $request)
    {
        doctor::where('id', $request->user()->id)->delete();
        // return "dddd";
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
