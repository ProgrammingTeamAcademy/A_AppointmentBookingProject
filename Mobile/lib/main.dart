import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/pages/auth/auth_page.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
    );
  }
}

