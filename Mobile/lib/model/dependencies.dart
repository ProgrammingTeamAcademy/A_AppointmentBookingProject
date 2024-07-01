import 'package:appointment_booking/controller/api.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async{
  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(() => Apis(appBaseUrl: "http://10.0.2.2:8000/",sharedPreferences: sharedPreferences));

  Get.lazyPut(() => AuthController(apis: Get.find(),sharedPreferences: sharedPreferences));
}