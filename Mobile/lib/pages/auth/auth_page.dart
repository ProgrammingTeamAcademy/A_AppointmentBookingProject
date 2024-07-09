import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/bigtext.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:appointment_booking/components/text_form_field.dart';
import 'package:appointment_booking/components/smalltext.dart';
import 'package:appointment_booking/pages/auth/log_in.dart';
import 'package:appointment_booking/pages/auth/sign_up.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController errorText = TextEditingController();

  void fieldRegisterCheck(){
    var name = nameController.text.trim();
    var password = passwordController.text.trim();
    var phone = phoneController.text.trim();
    var authController = Get.find<AuthController>();
    if(name.isEmpty){
      errorText.text = 'Name can\'t be empty';
    }else if(phone.isEmpty){
      errorText.text = 'Phone can\'t be empty';
    }else if(password.isEmpty){
      errorText.text = 'Password can\'t be empty';
    }else if(password.length<6){
      errorText.text = 'Password shouldn\'t be less than 6 characters';
    }else{
      print('Well done');
      authController.Register(name, password, phone);
      if(authController.isRegistered == false){
        errorText.text = 'Phone number already exist';
      }
    }
  }

  void fieldLoginCheck(){
    var phone = phoneController.text.trim();
    var password = passwordController.text.trim();
    var authController = Get.find<AuthController>();
    if(phone.isEmpty){
      errorText.text = 'Phone can\'t be empty';
    }else if(password.isEmpty){
      errorText.text = 'Password can\'t be empty';
    }else{
      print('Logged in');
      authController.login(phone, password);
      if(authController.isLogined == false){
        errorText.text = 'Check your information';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: config.height10*4,bottom: config.height10*2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo
              Container(
                height: config.height45*5,
                width: config.height45*4,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/338.jpg'),fit: BoxFit.cover)
                ),
              ),
              //if login page
              _isLogin?
              Column(
                children: [
                  SizedBox(height: config.height20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: config.width20),
                    child: Row(
                      children: [
                        Text('Welcome again',style: TextStyle(
                            color: Colors.black54,fontSize: config.font20*1.5,fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: config.width20*9),
                  //   child: Row(
                  //     children: [
                  //       Text('back',style: TextStyle(
                  //           color: AppColors.paraColor,fontSize: config.font20*2.5,fontWeight: FontWeight.w600
                  //       ),),
                  //     ],
                  //   ),
                  // ),
                ],
              ):
              Container(),
              //body
              _isLogin?
              SizedBox(height: config.height20*2,)
                  :SizedBox(height: config.height20,),
              _isLogin?
              LoginPage(passwordController: passwordController, phoneController: phoneController)
                  :SignupPage(nameController: nameController,passwordController: passwordController,phoneController: phoneController,),
              //button
              errorText.text.isNotEmpty? SizedBox(height: config.height20,):Container(),
              errorText.text.isNotEmpty? Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: config.width10*5),
                child: SmallText(text: errorText.text.trim(),
                color: Colors.redAccent,size: config.font14,),
              ):Container(),
              SizedBox(height: config.height20,),
              GestureDetector(
                onTap: (){
                  setState((){
                    errorText.clear();
                  });
                  _isLogin? fieldLoginCheck(): fieldRegisterCheck();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height10),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(config.radius20)
                  ),
                  child: BigText(
                    text:_isLogin?'Log in':'Sign up',color: Colors.white,
                  )
                ),
              ),
              //have account or not
              SizedBox(height: config.height10,),
              InkWell(
                onTap: (){
                  setState((){
                    errorText.clear();
                    _isLogin = !_isLogin;
                  });
                },
                child: SmallText(text: _isLogin?
                'Don\'t have an account!' :
                'Already have an account!',color: AppColors.paraColor,),
              ),
            ],
          ),
        ),
      )
    );
  }
}
