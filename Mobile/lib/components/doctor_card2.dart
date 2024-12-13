import 'package:appointment_booking/main.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:appointment_booking/pages/doctor/doctor_details.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config.dart';
import 'package:appointment_booking/components/config.dart';

class DoctorCard2 extends StatelessWidget {
  const DoctorCard2({super.key, required this.doctor, this.isfav});

  final DoctorModel doctor;
  final bool? isfav;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: config.width10, left: config.width10, bottom: config.height10),
      height: config.height45 * 3,
      child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(config.radius15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(1, 3),
                      blurRadius: 4)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: config.screenWidth * .45,
                  height: config.height45 * 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(config.radius20 / 4.5),
                        topRight: Radius.circular(config.radius20 / 4.5),
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.cover
                          // Image.network("http://127.0.0.1:8000${doctor.image}"
                          //   , fit: BoxFit.fill,),
                          )),
                ),
                Flexible(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.width10,vertical: config.height15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${doctor.name}",
                        style: TextStyle(
                            fontSize: config.font14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${doctor.specialist}",
                        style: TextStyle(
                          fontSize: config.font24 / 2,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          onTap: () {
            // MyApp.navigatorKey.currentState!.push(MaterialPageRoute(builder: (_)=>DoctorDetails(
            //   doctor: doctor,isfav: isfav,
            // ) ));
            Get.to(DoctorDetails(doctor: doctor));
          } // Doctors Details,
          ),
    );
  }
}
