import 'package:appointment_booking/model/doctor_clinic_model.dart';

class AppointmentModel {
  int? id;
  String? appointmentDate;
  String? day;
  String? time;
  String? status;
  int? userId;
  int? doctorClinicId;
  String? createdAt;
  String? updatedAt;
  DoctorClinicModel? doctorClinicModel;

  AppointmentModel(
      {this.id,
        this.appointmentDate,
        this.day,
        this.time,
        this.status,
        this.userId,
        this.doctorClinicId,
        this.createdAt,
        this.updatedAt,
        this.doctorClinicModel});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentDate = json['appointment_date'];
    day = json['day'];
    time = json['time'];
    status = json['status'];
    userId = json['user_id'];
    doctorClinicId = json['doctor_clinic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctorClinicModel =
    json['doctor_clinic'] != null ? new DoctorClinicModel.fromJson(json['doctor_clinic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_date'] = this.appointmentDate;
    data['day'] = this.day;
    data['time'] = this.time;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['doctor_clinic_id'] = this.doctorClinicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doctorClinicModel != null) {
      data['doctor_clinic'] = this.doctorClinicModel!.toJson();
    }
    return data;
  }
}