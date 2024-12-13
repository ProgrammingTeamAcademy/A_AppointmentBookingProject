import 'package:appointment_booking/controller/apiclint.dart';
import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/controller/clinic_controller.dart';
import 'package:appointment_booking/controller/doctor_clinic_controller.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/controller/fav_doctors_controller.dart';
import 'package:appointment_booking/controller/prevince_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async{
  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(() => ApiClient(appBaseUrl: "http://192.168.1.112:8080/",sharedPreferences: sharedPreferences));

  Get.lazyPut(() => AuthController(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => DoctorController(apiClient: Get.find()));
  Get.lazyPut(() => AppointmentController(apiClient: Get.find(),sharedPreferences: sharedPreferences));
  Get.lazyPut(() => ProvinceController(apiClient: Get.find(),sharedPreferences: sharedPreferences));
  Get.lazyPut(() => ClinicController(apiClient: Get.find()));
  Get.lazyPut(() => DoctorClinicController(apiClient: Get.find()));
  Get.lazyPut(() => FavDoctorsController(apiClient: Get.find(), sharedPreferences: sharedPreferences));
}