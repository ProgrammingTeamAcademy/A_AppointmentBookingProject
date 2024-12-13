
import 'dart:convert';

import 'package:appointment_booking/controller/apiclint.dart';
import 'package:appointment_booking/model/clinic_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController{

  final ApiClient apiClient;

  ClinicController({required this.apiClient});

  bool isLoading = false;
  List Clinics =[];
  ClinicModel? clinicModel;
  Future getClinics() async{
    isLoading = true;
    update();
    Response response = await apiClient.getData('api/clinic');
    if(response.statusCode == 200){
      Clinics =[];
      print(response.body['clinic'].length);
      for(int i =0; i<response.body['clinic'].length; i++){
        print(ClinicModel.fromJson(response.body['clinic'][i]).name);
        clinicModel = ClinicModel.fromJson(response.body['clinic'][i]);
        print(clinicModel!.id);
        Clinics.add(clinicModel);
      }
      // Doctors.addAll(DoctorModel.fromJson(response.body));
      print("Clinics ${Clinics}");

      print('clinics got');
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      print('didn\'t get clinics');
    }
  }

}