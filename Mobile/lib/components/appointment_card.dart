import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:appointment_booking/pages/main/main_page.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appointment_booking/components/config.dart';

class AppointmentCard extends StatefulWidget {
  AppointmentCard(
      {super.key,
      required this.appointmentModel,
      this.color});

  final AppointmentModel appointmentModel;
  final Color? color;
  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(config.radius20 / 2),
          boxShadow:[
            BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(3, 3),
                blurRadius: 4
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(config.radius20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png")
                      // NetworkImage(
                      //     "http://127.0.0.1:8000${widget.doctor['doctor_profile']}"),
                      ),
                  SizedBox(
                    width: config.width10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr ${widget.appointmentModel.doctorClinicModel!.doctor!.name}",
                        style: TextStyle(
                            fontSize: config.font16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: config.height10/5,
                      ),
                      Text(
                        widget.appointmentModel.doctorClinicModel!.doctor!.specialist!,
                        style: TextStyle(fontSize: config.font14,color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              config.screensmall,
              ScheduleCard(appointments: widget.appointmentModel),
              config.screensmall,
              Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(config.radius15)),
                        ),
                        title: Text('Complete Appointment',
                            style: TextStyle(
                                fontSize: config.font18
                            )),
                        content: Text('Are you sure about this appointment is been completed',
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
                                Get.find<AppointmentController>().completeAppointment(widget.appointmentModel.id!);
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
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: config.height10,horizontal: config.width15),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.shade200,
                        borderRadius: BorderRadius.circular(config.radius15),
                        boxShadow:[
                          BoxShadow(
                              color: Colors.grey.shade700,
                              offset: Offset(0, 1),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Center(
                      child: Text("COMPLETE",
                        style: TextStyle(
                            color: Colors.white,fontSize: config.font16
                        ),),
                    ),
                  )
              ),
            ),
            SizedBox(width: config.width20,),
            Expanded(
              child: GestureDetector(
                  onTap: (){
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
                                Get.find<AppointmentController>().cancelAppointment(widget.appointmentModel.id!);
                                Get.find<AppointmentController>().getAppointment();
                                Get.close(1);
                              });
                            },
                            child: Text('Cancel appointment',
                                style: TextStyle(
                                    fontSize: config.font16,color: Colors.redAccent
                                )),
                          ),
                        ],
                      ),
                    );
                    // Get.find<AppointmentController>().cancelAppointment(widget.schedule.id!);
                    // Get.find<AppointmentController>().getAppointment();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: config.height10,horizontal: config.width15),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(config.radius15),
                        boxShadow:[
                          BoxShadow(
                              color: Colors.grey.shade700,
                              offset: Offset(0, 1),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Center(
                      child: Text("CANCEL",
                        style: TextStyle(
                            color: Colors.white,fontSize: config.font16
                        ),),
                    ),
                  )
              ),
            ),
          ],
        )

            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.appointments});

  final AppointmentModel appointments;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade400, borderRadius: BorderRadius.circular(config.radius20/2)),
      width: double.infinity,
      padding: EdgeInsets.all(config.radius20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month_outlined, color: Colors.white,size: config.iconSize18,),
              SizedBox(
                width: config.width10/2,
              ),
              Text(
                "${appointments.day}, ${appointments.appointmentDate}",
                style: TextStyle(color: Colors.white,fontSize: config.font26/2),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.alarm, color: Colors.white,size: config.iconSize18,),
              SizedBox(
                width: config.width10/2,
              ),
              Text(
                "${appointments.time}",
                style: TextStyle(color: Colors.white,fontSize: config.font26/2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
