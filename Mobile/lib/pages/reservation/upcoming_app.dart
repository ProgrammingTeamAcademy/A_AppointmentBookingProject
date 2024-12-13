import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/pages/book_appointment/booking_page.dart';
import 'package:appointment_booking/pages/reservation/reservation_page.dart';
import 'package:appointment_booking/pages/reservation/schedule_card.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:get/get.dart';

class UpcomingApp extends StatefulWidget {
  UpcomingApp({super.key,required this.isLastItem,required this.schedule});
  bool? isLastItem;
  AppointmentModel schedule;

  @override
  State<UpcomingApp> createState() => _UpcomingAppState();
}

class _UpcomingAppState extends State<UpcomingApp> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(config.radius20),
      ),
      margin: !widget.isLastItem!
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
                      widget.schedule.doctorClinicModel!.doctor!.name!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: config.height10/2,
                    ),
                    Text(widget.schedule.doctorClinicModel!.doctor!.specialist!,
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
              date: widget.schedule.appointmentDate!,
              day: widget.schedule.day!,
              time: widget.schedule.time!,
            ),
            SizedBox(height: config.height15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.mainColor
                      ),
                      onPressed: (){
                        Get.to(()=>BookingPage(doctorModel: widget.schedule.doctorClinicModel!.doctor!,
                        appointmentModel: widget.schedule,));
                      },
                      child: Text("Reschedule",
                        style: TextStyle(
                            color: Colors.white
                        ),)
                  ),
                ),
                SizedBox(width: config.width20,),
                Expanded(
                  child: OutlinedButton(
                      onPressed: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(config.radius15)),
                            ),
                            title: Text('Cancel Appointment',
                                style: TextStyle(
                                    fontSize: config.font18
                                )),
                            content: Text('Are you sure about cancel your appointment',
                                style: TextStyle(
                                    fontSize: config.font14
                                )),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Get.close(1),
                                child: Text('No',
                                    style: TextStyle(
                                        fontSize: config.font16
                                    )),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState((){
                                    Get.find<AppointmentController>().cancelAppointment(widget.schedule.id!);
                                    Get.find<AppointmentController>().getAppointment();
                                    Get.close(1);
                                  });
                                },
                                child: Text('Submit',
                                    style: TextStyle(
                                        fontSize: config.font16
                                    )),
                              ),
                            ],
                          ),
                        );
                        // Get.find<AppointmentController>().cancelAppointment(widget.schedule.id!);
                        // Get.find<AppointmentController>().getAppointment();
                      },
                      child: Text("Cancel",
                        style: TextStyle(
                            color: AppColors.mainColor
                        ),)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

