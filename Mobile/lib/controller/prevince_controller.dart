import 'dart:convert';

import 'package:appointment_booking/controller/apiclint.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProvinceController extends GetxController{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;

  ProvinceController({required this.apiClient, required this.sharedPreferences});
  List provinces = [];
  Future getProvinces() async{
    Response response =await apiClient.getData('api/province');

    if(response.statusCode == 200){
      provinces = [];
      for(var x in response.body['provinces']){
        provinces.add(x['province_name']);
      }
      sharedPreferences.setString('province', json.encode(response.body['provinces']));
      return response.body['provinces'];
    }else{
      return response.statusText;
    }
  }

  List countries = [];
  Future getCountreis() async{
    Response response =await apiClient.getData('api/country');

    if(response.statusCode == 200){
      countries = [];
      for(var x in response.body['country']){
        countries.add(x['country_name']);
      }
      sharedPreferences.setString('country', json.encode(countries));
      print(countries);
      return response.body['country'];
    }else{
      return response.statusText;
    }
  }
}