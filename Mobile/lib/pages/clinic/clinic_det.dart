import 'package:appointment_booking/model/clinic_model.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';

class ClinicDet extends StatelessWidget {
  const ClinicDet({super.key, required this.clinicModel});

  final ClinicModel clinicModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.width20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: config.radius20*2.25,
                    backgroundImage: AssetImage("assets/images/clinic1.jpg")
                  // NetworkImage("http://127.0.0.1:8000${doctor['doctor_profile']}"),
                ),
                SizedBox(width: config.width20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: config.height10,),
                    Text(
                      "Dr ${clinicModel.name}",
                      style: TextStyle(fontSize: config.font20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}