import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/pages/reservation/schedule_card.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';

class CompletedApp extends StatelessWidget {
  CompletedApp({super.key,required this.isLastItem,required this.schedule});
  bool? isLastItem;
  AppointmentModel schedule;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(config.radius20),
      ),
      margin: !isLastItem!
          ? EdgeInsets.only(bottom: config.height20)
          : EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(config.height15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                SizedBox(width: config.width10,),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.doctorClinicModel!.doctor!.name!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: config.height10/2,
                    ),
                    Text(schedule.doctorClinicModel!.doctor!.specialist!,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: config.font24/2))
                  ],
                )
              ],
            ),
            SizedBox(height: config.height15,),
            ScheduleCard(
              date: schedule.appointmentDate!,
              day: schedule.day!,
              time: schedule.time!,
            ),
            SizedBox(height: config.height15,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: config.height15,
                left: config.width20,
                right: config.width20,
                top: config.height15,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(config.radius15),
                  boxShadow:[
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(2, 3),
                        blurRadius: 4
                    )
                  ]
              ),
              child: Center(
                child: Text(
                  "COMPLETED",
                  style: TextStyle(
                      fontSize: config.font18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}