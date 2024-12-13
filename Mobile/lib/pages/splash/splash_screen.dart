import 'dart:async';
import 'package:appointment_booking/components/config.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/pages/auth/auth_page.dart';
import 'package:appointment_booking/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController animationController;
  late SharedPreferences sharedPreferences;
  String? token;
  bool? getPage;

  Future getToken() async{
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    print('Token : $token');
    if(token == null || token == ''){
      getPage = false;
    }else{
      getPage = true;
      Get.find<AuthController>().getUser();
    }
  }

  //  get getPage {
  //   if(token == null || token == ''){
  //     return false;
  //   }else{
  //     return true;
  //   }
  // }
  @override
  void initState(){
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear);
    getToken();

    Timer(
      Duration(seconds: 3),
      () => Get.to(()=> getPage! ? HomePage():AuthPage() ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: config.pageView,
          child: Center(
            child: Image.asset('assets/images/338.jpg'),
          ),
        ),
      ),
    );
  }
}