import 'package:appointment_booking/model/clinic_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';

class DoctorClinicModel {
  int? id;
  double? price;
  String? times;
  int? doctorId;
  int? clinicId;
  String? createdAt;
  String? updatedAt;
  DoctorModel? doctor;
  ClinicModel? clinic;

  DoctorClinicModel(
      {this.id,
        this.price,
        this.times,
        this.doctorId,
        this.clinicId,
        this.createdAt,
        this.updatedAt,
        this.doctor,
        this.clinic});

  DoctorClinicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].toDouble();
    times = json['times'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor =
    json['doctor'] != null ? new DoctorModel.fromJson(json['doctor']) : null;
    clinic =
    json['clinic'] != null ? new ClinicModel.fromJson(json['clinic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['times'] = this.times;
    data['doctor_id'] = this.doctorId;
    data['clinic_id'] = this.clinicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.clinic != null) {
      data['clinic'] = this.clinic!.toJson();
    }
    return data;
  }
}