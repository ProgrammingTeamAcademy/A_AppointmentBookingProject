import 'dart:convert';

import 'package:appointment_booking/components/appointment_card.dart';
import 'package:appointment_booking/components/doctor_card.dart';
import 'package:appointment_booking/components/search_bar.dart';
import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/pages/category_doctors/category_doctors.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  List appointments = [];

  List<Map<String , dynamic>> medCat = [
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"General"
    },
    {
      "icon":FontAwesomeIcons.heartPulse,
      "category":"Cardiology"
    },
    {
      "icon":FontAwesomeIcons.lungs,
      "category":"Respirations"
    },
    {
      "icon":FontAwesomeIcons.hospitalUser,
      "category":"Dermatology"
    },
    {
      "icon":FontAwesomeIcons.personPregnant,
      "category":"Gynecology"
    },
    {
      "icon":FontAwesomeIcons.teeth,
      "category":"Dental"
    },
    {
      "icon":FontAwesomeIcons.waveSquare,
      "category":"Nerves"
    },
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"Surgery"
    },
  ];
  AppointmentModel? appointmentModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState((){
        appointments = json.decode(Get.find<AppointmentController>().sharedPreferences!.getString('appointments').toString());
        var outputFormat = DateFormat('dd-MM-yyyy');
        var outputDate = outputFormat.format(DateTime.now());
        appointmentModel = null;
        for(var a in appointments){
          if(a['appointment_date'] == outputDate && a['status'] == "upcoming"){
            appointmentModel = AppointmentModel.fromJson(a);
          }
        }
      });
    });
  return Scaffold(
      body: GetBuilder<AuthController>(
          builder: (authController){
            return  Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: config.height45,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal:  config.width15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            authController.userModel!.name ?? '',
                            style: TextStyle(fontSize: config.font20,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: config.height20*2.5,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage("assets/images/profile.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: config.height20,
                    ),
                    SearchBar(),
                    SizedBox(
                      height: config.height20,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal:  config.width15,
                      ),
                      child: Text(
                        'Category',
                        style: TextStyle(fontSize: config.font16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: config.height15,
                    ),
                    SizedBox(
                      height: config.screenHeight * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List<Widget>.generate(
                            medCat.length,
                                (index){
                              return GestureDetector(
                                onTap: (){
                                  Get.to(()=>CategoryDoctors(category: medCat[index]['category']));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: config.width10/2,
                                  left: config.width10/2),
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(config.radius15),
                                      boxShadow:[
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: Offset(0, 2),
                                            blurRadius: 4
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: config.width15,vertical: config.height10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        FaIcon(medCat[index]['icon'],color: Colors.white,),
                                        SizedBox(width: config.width15,),
                                        Text(
                                          medCat[index]['category'],
                                          style: TextStyle(fontSize: config.font16, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: config.height20,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal:  config.width15,
                      ),
                      child: Text(
                        'Appointment Today',
                        style: TextStyle(fontSize: config.font16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: config.height15,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal:  config.width15,
                      ),
                      child:  GetBuilder<AppointmentController>(builder: (appointment){
                        return
                          appointmentModel.isNull?
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(config.radius20/2)
                          ),
                          child: Center(child: Padding(
                            padding: EdgeInsets.all(config.height20),
                            child: Text(
                              "No Appointment Today",
                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: config.font16),
                            ),
                          ),),
                        )
                        : AppointmentCard(
                              appointmentModel: appointmentModel!,
                              color: AppColors.mainColor,);
                      }),
                    ),
                    SizedBox(
                      height: config.height20,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal:  config.width15,
                      ),
                      child: Text(
                        'Top doctors',
                        style: TextStyle(fontSize: config.font16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: config.height15,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: config.height10),
                      child: GetBuilder<DoctorController>(builder: (doctorController){
                        return
                          // doctorController.isLoading?
                          Column(
                            children: List.generate(doctorController.Doctors.length, (index){
                          return DoctorCard(doctor: doctorController.Doctors[index]);
                        }));
                            // : CircularProgressIndicator();
                      }),
                    )
                  ],
                ),
              ),
            )
              ;
          },
      ),
    );
  }

}
