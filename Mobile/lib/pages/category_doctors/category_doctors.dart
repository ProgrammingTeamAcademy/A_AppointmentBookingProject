import 'package:appointment_booking/components/doctor_card.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CategoryDoctors extends StatelessWidget {
  CategoryDoctors({super.key,required this.category});

  String? category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "$category",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        leading:  Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.mainColor,
              boxShadow:[
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(1, 2),
                    blurRadius: 4
                )
              ]),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: FaIcon(Icons.arrow_back_ios_new),
            color: Colors.white,
            iconSize: 16,
          ),
        ),
        // actions: widget.actions,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: config.height10,horizontal: config.width15),
          child: GetBuilder<DoctorController>(builder: (doctorController){
            List doctors = [];
            for(var doc in doctorController.Doctors){
              if(doc.specialist.toLowerCase().contains(category!.toLowerCase())){
                doctors.add(doc);
              }
            }
            return
              Column(
                  children: List.generate(doctors.length, (index){
                    return DoctorCard(doctor: doctors[index]);
                  }));
          }),
        ),
      ),
    );
  }
}
