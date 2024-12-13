import 'dart:convert';
import 'package:appointment_booking/controller/apiclint.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavDoctorsController extends GetxController{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  FavDoctorsController({required this.apiClient,required this.sharedPreferences});

  bool isLoading = false;
  List FavDoctors = [];

  Future getFavDoctors() async{
    Response response = await apiClient.getData('api/fav');
    if(response.statusCode == 200){
      FavDoctors = [];
      print('got favDoctos');
      response.body.forEach((element){
        FavDoctors.add(element['doctor_id']);
      });
      sharedPreferences.remove('favDoc');
      sharedPreferences.setString('favDoc',json.encode(FavDoctors));
      // print(sharedPreferences.getString('favDoc'));
      return json.encode(response.body);
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      print('didn\'t get favDoctors');
      return 'error';
    }
  }

  Future storeFavDoctor(int doctorID) async{
    Response response = await apiClient.postData("api/doctor/${doctorID}/fav",{});

    if(response.statusCode == 200){
      print('fav or unfav DONE');
      return response.statusText;
    }else{
      return response.statusText;
    }
  }
}