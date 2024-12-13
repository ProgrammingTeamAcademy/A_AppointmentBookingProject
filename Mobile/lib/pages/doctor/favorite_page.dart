import 'dart:async';
import 'dart:convert';

import 'package:appointment_booking/components/doctor_card.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/controller/fav_doctors_controller.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});
  @override
  State<FavPage> createState() => FavPageState();
}

class FavPageState extends State<FavPage> {

  List list=[];
  @override
  void initState(){
    super.initState();
        list = json.decode(Get.find<FavDoctorsController>().sharedPreferences.getString('favDoc').toString());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     setState((){});
    });
    return Scaffold(
      body: GetBuilder<FavDoctorsController>(
        builder: (favdocController){
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(right: config.width20, left: config.width20, top: config.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Favorite doctors",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: config.font18),
                    textAlign: TextAlign.center,
                  ),
                  config.screensmall,
                  GetBuilder<DoctorController>(
                    builder: (doctorController){
                      return Expanded(
                          child:
                          ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index){
                                DoctorModel? doctorModel ;
                                doctorController.Doctors.forEach((element) {
                                  if(element.id == list[index]){
                                    doctorModel = element;
                                  }
                                });
                                return DoctorCard(doctor: doctorModel!);
                              }
                          ));
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
