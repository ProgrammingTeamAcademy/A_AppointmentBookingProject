
import 'dart:convert';

import 'package:appointment_booking/controller/apiclint.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentController extends GetxController{

  final ApiClient apiClient;
  final SharedPreferences? sharedPreferences;
  AppointmentController({required this.apiClient,required this.sharedPreferences});

  bool isLoading = false;
  List Appointments =[];
  AppointmentModel? appointmentModel;
  Future getAppointment() async{
    isLoading = true;
    update();
    Response response = await apiClient.getData('api/appointment');
    if(response.statusCode == 200){
      Appointments =[];
      print(response.body['appointments'].length);
      response.body['appointments'].map((app){
        Appointments.add(AppointmentModel.fromJson(app));
      }).toList();
      // response.body['appointments'].forEach((element){
      //   Appointments.add(element);
      // });
      sharedPreferences!.remove('appointments');
      sharedPreferences!.setString('appointments',json.encode(Appointments));

      // for(int i =0; i<response.body['appointments'].length; i++){
      //   print(AppointmentModel.fromJson(response.body['appointments'][i]).status);
      //   appointmentModel = AppointmentModel.fromJson(response.body['appointments'][i]);
      //   Appointments.add(appointmentModel);
      // }
      // Doctors.addAll(DoctorModel.fromJson(response.body));
      // print("Appointments ${json.encode(response.body['appointments'])}");

      print('Appointments got');

    }else{
      isLoading = false;
      update();
      print(response.statusText);
      print('didn\'t get Appointments');
    }
  }

  Future bookAppointment(int doc_cli,String date,String day,String time) async{
    Response response = await apiClient.postData("api/appointment", {
      'doctor_clinic_id' : doc_cli, 'appointment_date' : date, 'day':day, 'time' : time
    });

    if(response.statusCode == 200){
      print('appointment taken successfully');
      getAppointment();
      return true;
    }else{
      print(response.statusText);
      return false;
    }
  }

  Future updateAppointment(int appointmentID,int doc_cli,String date,String day,String time) async{
    Response response = await apiClient.putData("api/appointment/${appointmentID}", {
      'doctor_clinic_id' : doc_cli, 'appointment_date' : date, 'day':day, 'time' : time
    });

    if(response.statusCode == 200){
      print('appointment updated successfully');
      getAppointment();
      return true;
    }else{
      print(response.statusText);
      return false;
    }
  }

  Future cancelAppointment(int appointmentID) async{
    Response response = await apiClient.putData("api/appointment/${appointmentID}", {
      'status' : 'cancel'
    });

    if(response.statusCode == 200){
      print('appointment canceled successfully');
      getAppointment();
      return true;
    }else{
      print(response.statusText);
      return false;
    }
  }

  Future completeAppointment(int appointmentID) async{
    Response response = await apiClient.putData("api/appointment/${appointmentID}", {
      'status' : 'complete'
    });

    if(response.statusCode == 200){
      print('appointment is been completed');
      getAppointment();
      return true;
    }else{
      print(response.statusText);
      return false;
    }
  }
}