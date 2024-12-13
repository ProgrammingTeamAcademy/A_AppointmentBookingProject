import 'dart:convert';

import 'package:appointment_booking/model/user_model.dart';
import 'package:appointment_booking/pages/auth/auth_page.dart';
import 'package:appointment_booking/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiclint.dart';

class AuthController extends GetxController implements GetxService{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthController({required this.apiClient, required this.sharedPreferences});
  Map<String,dynamic> data = {};
  bool isLoading = false;
  UserModel? userModel;

  void clearToekn(){
     sharedPreferences.remove('token');
     return print('token is ${sharedPreferences.getString('token')}');
  }

  bool? isRegistered;
  Future Register(String name, String password, String phone) async{


    data = {'name':name,'password':password,'phone':phone,};
    Response response = await apiClient.postData('api/User/auth/register', data);

    if(response.statusCode == 200){
      isLoading = true;
      update();
      apiClient.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString('token', response.body['token']);
      Get.find<AuthController>().getUser();
      await Future.delayed(const Duration(seconds: 2));
      isLoading = false;
      update();
      Get.to(()=> HomePage());
      print(response.statusText);
      return isRegistered = true;
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      if(response.statusText == 'Forbidden') {
        return print('Phone number already exist');
      }else{
        return isRegistered = false;
      }
    }
  }
  bool? isLogined;
  Future login(String phone, String password) async{
    data = {'phone':phone,'password':password};
    Response response = await apiClient.postData('api/User/auth/login', data);

    if(response.statusCode == 200){
      isLoading = true;
      update();
      apiClient.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString('token', response.body['token']);
      Get.find<AuthController>().getUser();
      await Future.delayed(const Duration(seconds: 2));
      isLoading = false;
      update();
      Get.to(()=> HomePage());
      isLoading = false;
      update();
      print('logged in successful');
      return isLogined = true;
    }else{
      isLoading = true;
      // update();
      print(response.statusText);
      isLogined = false;
      isLoading = false;
      update();
      return isLogined = false;
    }
  }

  Future logout(context) async{
    sharedPreferences.remove('token');

    Get.offAll(AuthPage());
  }

  Future updateUser({String? phone, int? provinceID}) async{
    isLoading = true;
    update();
    Response response = await apiClient.putData("api/User/update", {
      'phone' : phone ?? userModel!.phone , 'province_id' : provinceID ?? userModel!.provinceID
    });

    if(response.statusCode == 200){
      print('user info updated successfully');
      getUser();
      return true;
    }else{
      print(response.statusText);
      return false;
    }
  }

  Future getUser() async{
    isLoading = true;
    update();

    final token = sharedPreferences.getString('token')??'';
    if(token.isNotEmpty && token != ''){
      Response response = await apiClient.getData("api/User/get_info");
      if(response.statusCode == 200){
        userModel = UserModel.fromJson(response.body['info']);
        sharedPreferences.setString('userInfo', json.encode(response.body['info']));
        print('user details got successful');
        print('${sharedPreferences.getString('userInfo')}');
        // isLoading = false;
        // update();

        // return print('Output is ' + response.statusText!);
      }else{
        isLoading = false;
        update();

        return print('Error is ' + response.statusText! + ' status is ' + response.statusCode.toString());
      }
    }
  }
}