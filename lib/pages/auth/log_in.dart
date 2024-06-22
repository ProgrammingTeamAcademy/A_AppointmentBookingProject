import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:appointment_booking/components/text_form_field.dart';

class LoginPage extends StatelessWidget {
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  LoginPage({super.key,
    required this.passwordController,
    required this.phoneController,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //phone
        TextFormFieldC(controller: phoneController,iconData: Icons.phone_android_rounded,hintText: 'Phone number',textInputType: TextInputType.number,),
        //password
        SizedBox(height: config.height10,),
        TextFormFieldC(controller: passwordController,iconData: Icons.password_rounded,hintText: 'Password',obscure: true),
      ],
    );
  }
}
