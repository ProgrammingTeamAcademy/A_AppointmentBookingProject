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

  void clearToekn(){
     sharedPreferences.remove('token');
     return print('token is ${sharedPreferences.getString('token')}');
  }

  bool isRegistered = false;
  Future Register(String name, String password, String phone) async{
    isLoading = true;
    update();

    data = {'name':name,'password':password,'phone':phone,};
    Response response = await apiClient.postData('api/User/auth/register', data);

    if(response.statusCode == 200){
      apiClient.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString('token', response.body['token']);
      Get.to(()=> HomePage());
      isLoading = false;
      update();
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
  bool isLogined = false;
  Future login(String phone, String password) async{
    isLoading = true;
    update();
    
    data = {'phone':phone,'password':password};
    Response response = await apiClient.postData('api/User/auth/login', data);

    if(response.statusCode == 200){
      apiClient.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString('token', response.body['token']);
      Get.to(()=> HomePage());
      isLoading = false;
      update();
      print('logged in successful');
      return isLogined = true;
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      return isLogined = false;
    }
  }

  Future logout() async{
    sharedPreferences.remove('token');

    Get.to(()=> AuthPage());
  }
}