import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:appointment_booking/components/text_form_field.dart';

class SignupPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  SignupPage({super.key, required this.emailController,
    required this.passwordController,required this.nameController,required this.phoneController,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //name
        TextFormFieldC(controller: nameController,iconData: Icons.person_sharp,hintText: 'Name',),
        //phone
        SizedBox(height: config.height10,),
        TextFormFieldC(controller: phoneController,iconData: Icons.phone_android_rounded,hintText: 'Phone number',textInputType: TextInputType.number,),
        //password
        SizedBox(height: config.height10,),
        TextFormFieldC(controller: passwordController,iconData: Icons.password_rounded,hintText: 'Password',obscure: true),
        ],
    );
  }
}
