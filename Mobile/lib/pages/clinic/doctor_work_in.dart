import 'package:appointment_booking/components/doctor_card2.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/model/clinic_model.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:get/get.dart';

class DoctorWorkIn extends StatelessWidget {
  DoctorWorkIn({super.key, required this.clinicModel});

  final ClinicModel clinicModel;
  List doctorWI = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorController>(builder: (doctorController){
      for(var doc in doctorController.Doctors){
        if(doc.doctorClinicModel.clinicId == clinicModel.id){
          doctorWI.add(doc);
        }
      }
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.width20),
              child: Text(
                "Doctors",
                style: TextStyle(fontSize: config.font18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: config.height20,),
            GetBuilder<DoctorController>(builder: (doctorController){
              print('hey there ?');
              return
                doctorWI.isNotEmpty?
                Container(
                  height: config.height45*5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: doctorWI.length,
                      itemBuilder: (context,index){
                    return Container(width: config.screenWidth * .45,
                        child: DoctorCard2(doctor: doctorWI[index]));
                  }),
                )
              : Text('There\'s no information yet',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),);
            })
          ],
        ),
      );
    });
  }
}