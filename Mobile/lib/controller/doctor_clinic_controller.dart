
import 'dart:convert';

import 'package:appointment_booking/controller/apiclint.dart';
import 'package:appointment_booking/model/clinic_model.dart';
import 'package:appointment_booking/model/doctor_clinic_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:get/get.dart';

class DoctorClinicController extends GetxController{

  final ApiClient apiClient;

  DoctorClinicController({required this.apiClient});

  bool isLoading = false;
  List DoctorClinics =[];
  DoctorClinicModel? doctorClinicModel;
  Future getDocClinics() async{
    isLoading = true;
    update();
    Response response = await apiClient.getData('api/doctor_clinic');
    if(response.statusCode == 200){
      DoctorClinics =[];
      print(response.body['avalible'].length);
      for(int i =0; i<response.body['avalible'].length; i++){
        // print(DoctorClinicModel.fromJson(response.body['avalible'][i]).doctor!.name);
        doctorClinicModel = DoctorClinicModel.fromJson(response.body['avalible'][i]);
        // print(doctorClinicModel!.id);
        DoctorClinics.add(doctorClinicModel);
      }
      // Doctors.addAll(DoctorModel.fromJson(response.body));
      // print("D_Clinics ${DoctorClinics}");

      print('d_clinics got');
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      print('didn\'t get d_clinics');
    }
  }

}