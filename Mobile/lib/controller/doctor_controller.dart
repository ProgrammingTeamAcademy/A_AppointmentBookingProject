
import 'dart:convert';

import 'package:appointment_booking/controller/apiclint.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController{

  final ApiClient apiClient;

  DoctorController({required this.apiClient});

  bool isLoading = false;
  List Doctors =[];
  DoctorModel? doctorModel;
  Future getDoctors() async{
    isLoading = true;
    update();
    Response response = await apiClient.getData('api/doctor');
    if(response.statusCode == 200){
      Doctors =[];
      print(response.body['doctors'].length);
      for(int i =0; i<response.body['doctors'].length; i++){
        print(DoctorModel.fromJson(response.body['doctors'][i]).name);
        doctorModel = DoctorModel.fromJson(response.body['doctors'][i]);
        print(doctorModel!.id);
        Doctors.add(doctorModel);
      }
      // Doctors.addAll(DoctorModel.fromJson(response.body));
      print("Doctors ${Doctors[0].name}");

      print('doctors got');

    }else{
      isLoading = false;
      update();
      print(response.statusText);
      print(response.statusCode);
      print(response.unauthorized);
      print('didn\'t get doctors');
    }
  }

}