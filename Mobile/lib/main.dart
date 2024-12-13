import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/controller/clinic_controller.dart';
import 'package:appointment_booking/controller/doctor_clinic_controller.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/controller/fav_doctors_controller.dart';
import 'package:appointment_booking/controller/prevince_controller.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/pages/auth/auth_page.dart';
import 'package:appointment_booking/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:get/get.dart';
import 'model/dependencies.dart' as dependencies;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    Get.find<DoctorController>();
    Get.find<DoctorClinicController>();
    Get.find<DoctorClinicController>().getDocClinics();
    Get.find<ClinicController>();
    Get.find<ClinicController>().getClinics();
    Get.find<DoctorController>().getDoctors();
    Get.find<AppointmentController>();
    Get.find<FavDoctorsController>();
    Get.find<ProvinceController>();
    Get.find<ProvinceController>().getCountreis();
    Get.find<ProvinceController>().getProvinces();
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

