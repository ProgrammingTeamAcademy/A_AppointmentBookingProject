<?php

use App\Http\Controllers\Auth\adminAuth;
use App\Http\Controllers\Auth\doctorAuth;
use App\Http\Controllers\Auth\userAuth;
use App\Mail\firstmail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Route;
use Symfony\Component\HttpFoundation\Response;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/







Route::controller(doctorAuth::class,)->prefix("Doctor")
    ->group(
        function () {
            Route::middleware('auth:doctor')->post(
                '/doctor',
                'get_detals'
                // function (Request $request) {

                // }
            );
            Route::middleware('auth:doctor')->post('/logout', function (Request $request) {

                $request->user()->currentAccessToken()->delete();

                return response()->json(['message' => 'Logged out successfully.'], 200);
            });
            Route::middleware('auth:doctor')->post('/logout_all', function (Request $request) {

                $request->user()->tokens()->delete();

                return response()->json(['message' => 'Logged out successfully.'], 200);
            });

            Route::middleware('Doctor')->post('auth/login_email',  'login_email');
            Route::middleware('Doctor_userName')->post('auth/login_name',  'login_name');
            Route::post('auth/isUserNameEx',  'nameEx');
            Route::post('auth/register',  'register');


            Route::post('auth/acconts', 'acconts');
            Route::middleware('auth:doctor')->delete('auth/delete', 'delete');
            Route::post('auth/get_detals', 'get_detals2');
        }
    );
Route::controller(userAuth::class,)->prefix("User")->group(
    function () {
        Route::post('auth/login',  'login');
        Route::post('auth/register',  'register');
        Route::middleware('auth:sanctum')->get(
            '/get_info',
            'get_detals'
            // function (Request $request) {
            //return $request->user();
            // }
        );
        Route::middleware('auth:sanctum')->post('/logout', function (Request $request) {
            $request->user()->currentAccessToken()->delete();
            return response()->json(['message' => ' تم نسجيل الخروج'], 200);
        });

        Route::middleware('auth:sanctum')->post('/logout_all', function (Request $request) {
            $request->user()->tokens()->delete();
            return response()->json(['message' => 'تم تسجيل الخروج من جميع الحسابات'], 200);
        });
    }



);

Route::controller(adminAuth::class)->prefix('admin')->group(
    function () {
        Route::post('auth/register',  'register');
        Route::middleware('auth:admin')->post(
            '/admin',
            'get_detals'
            // function (Request $request) {

            // }
        );
        Route::get('email', function () {
            // Mail::to('leith5102000@gmail.com')->send(new firstmail);
            // return Response()->json([
            //     's' => 'dane',
            // ]);
        });
        Route::middleware('admin_login')->post('auth/login',  'login');
        Route::get('acccept_doctor', 'acccept');
    },
    Route::post(
        'email',
        function () {
            $details = [
                'subject' => 'Test Mailgun Email',
                'body' => 'This is a test email to check Mailgun settings.'
            ];

            Mail::raw($details['body'], function ($message) use ($details) {
                $message->from(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'));
                $message->to('halwadev@gmail.com'); // Replace with your recipient email
                $message->subject($details['subject']);
            });
        },
    ),
);
