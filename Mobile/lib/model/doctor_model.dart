

import 'package:appointment_booking/model/doctor_clinic_model.dart';

class DoctorModel {
  int? id;
  String? userName;
  String? status;
  String? email;
  String? name;
  String? phone;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? specialist;
  String? clinic;
  String? shortDescription;
  String? aboutDoctor;
  DoctorClinicModel? doctorClinicModel;

  DoctorModel(
      {this.id,
        this.userName,
        this.status,
        this.email,
        this.name,
        this.phone,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.clinic,
        this.shortDescription,
        this.aboutDoctor,
        this.doctorClinicModel,
        this.specialist});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    status = json['status'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    specialist = json['specialist'];
    clinic = json['clinic'];
    shortDescription = json['short_description'];
    aboutDoctor = json['about_doctor'];
    doctorClinicModel =
    json['doctor_clinics'] != null ? new DoctorClinicModel.fromJson(json['doctor_clinics']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['status'] = this.status;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['specialist'] = this.specialist;
    data['clinic'] = this.clinic;
    data['short_description'] = this.shortDescription;
    data['about_doctor'] = this.aboutDoctor;
    if (this.doctorClinicModel != null) {
      data['doctor_clinics'] = this.doctorClinicModel!.toJson();
    }
    return data;
  }
}