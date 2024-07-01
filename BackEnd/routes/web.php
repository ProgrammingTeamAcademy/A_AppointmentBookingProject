<?php

use App\Mail\firstmail;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('email', function () {
    $details = [
        'subject' => 'Test Mailgun Email',
        'body' => 'This is a test email to check Mailgun settings.'
    ];

    Mail::raw($details['body'], function ($message) use ($details) {
        $message->from(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'));
        $message->to('halwadev@gmail.com'); // Replace with your recipient email
        $message->subject($details['subject']);
    });

    return 'Test email sent';
    // $data = [
    //     'title' => 'Hi student I hope you like the course',
    //     'content' => 'This laravel course was created with a lot of love and dedication for you'
    // ];
    // Mail::to('leith5102000@gmail.com')->send(new firstmail($data));
    // return Response()->json([
    //     's' => 'dane',
    // ]);
    // Mail::send(new firstmail($data), function ($message) {
    //     $message->to('leith5102000@gmai.com')->subject('Hello student how are you?');
    // });
});
    
//});
