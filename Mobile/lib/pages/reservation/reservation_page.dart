import 'dart:convert';

import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/controller/fav_doctors_controller.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/pages/reservation/cancel_app.dart';
import 'package:appointment_booking/pages/reservation/completed_app.dart';
import 'package:appointment_booking/pages/reservation/upcoming_app.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:intl/intl.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => ReservationPageState();
}
enum FilterStatus { upcoming, complete, cancel }

class ReservationPageState extends State<ReservationPage> {

  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
 List FilterSchedule =[];
 List appointments = [];
  // @override
  // void initState() {
  //   super.initState();
  //   handleRefresh();
  // }
  // // List FilterSchedule =[];


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState((){
        appointments = json.decode(Get.find<AppointmentController>().sharedPreferences!.getString('appointments').toString());
        FilterSchedule = appointments.where((element) {
          switch(element['status']){
            case 'upcoming':
              element['status'] = FilterStatus.upcoming.toString();
              break;
            case 'complete':
              element['status'] = FilterStatus.complete.toString();
              break;
            case 'cancel':
              element['status'] = FilterStatus.cancel.toString();
              break;
          }
          return element['status'] == status.toString();
        }).toList();

        FilterSchedule.sort((a,b)=> DateFormat('dd-MM-yyyy').parse(a['appointment_date'])
            .compareTo(DateFormat('dd-MM-yyyy').parse(b['appointment_date'])));
      });
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(right: config.width20, left: config.width20, top: config.height20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Appointment Schedule",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: config.font18),
                  textAlign: TextAlign.center,
                ),
                config.screensmall,
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: config.height10*4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(config.radius20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (FilterStatus filterStatus in FilterStatus.values)
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (filterStatus == FilterStatus.upcoming) {
                                        status = FilterStatus.upcoming;
                                        _alignment = Alignment.centerLeft;
                                      } else if (filterStatus ==
                                          FilterStatus.complete) {
                                        status = FilterStatus.complete;
                                        _alignment = Alignment.center;
                                      } else if (filterStatus ==
                                          FilterStatus.cancel) {
                                        status = FilterStatus.cancel;
                                        _alignment = Alignment.centerRight;
                                      }
                                    });
                                  },
                                  child: Center(
                                    child: Text(filterStatus.name),
                                  ),
                                ))
                        ],
                      ),
                    ),
                    AnimatedAlign(
                      alignment: _alignment,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        width: config.height20*5,
                        height: config.height10*4,
                        decoration: BoxDecoration(
                            boxShadow:[
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: Offset(0, 3),
                                  blurRadius: 4
                              )
                            ],
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            status.name,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                config.screensmall,
                Expanded(
                    child: ListView.builder(
                        itemCount: FilterSchedule.length,
                        itemBuilder: ((context, index) {
                          AppointmentModel schedule = AppointmentModel.fromJson(FilterSchedule[index]);
                          bool isLastItem = FilterSchedule.length + 1 == index;
                          return status == FilterStatus.upcoming?
                          UpcomingApp(isLastItem: isLastItem, schedule: schedule):
                          status == FilterStatus.complete?
                          CompletedApp(isLastItem: isLastItem, schedule: schedule):
                          CancelApp(isLastItem: isLastItem, schedule: schedule);
                          // return Container();
                        })))
              ],
            )),
      ),
    );
  }
}


