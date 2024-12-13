import 'dart:convert';

import 'package:appointment_booking/controller/fav_doctors_controller.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:appointment_booking/pages/book_appointment/booking_page.dart';
import 'package:appointment_booking/pages/clinic/clinic_details.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.doctor, this.isfav});
  final DoctorModel doctor;
  final bool? isfav;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  DoctorModel? doctor;
  bool isFav = false;
  List list=[];
  @override
  void initState(){
    doctor = widget.doctor;
    // isFav = widget.isfav! ;
    // Get.find<FavDoctorsController>().getFavDoctors();
    print(Get.find<FavDoctorsController>().sharedPreferences.getString('favDoc'));
    list = json.decode(Get.find<FavDoctorsController>().sharedPreferences.getString('favDoc').toString());
    if(list.contains(doctor!.id)){
      isFav = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Doctor Details",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        leading: Container(
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
        actions:[
          IconButton(
              onPressed: () {
                Get.find<FavDoctorsController>().storeFavDoctor(doctor!.id!);
                setState(() {
                  if(list.contains(doctor!.id)){
                    list.remove(doctor!.id);
                  }else{
                    list.add(doctor!.id);
                  }
                  Get.find<FavDoctorsController>().sharedPreferences.remove('favDoc');
                  Get.find<FavDoctorsController>().sharedPreferences.setString('favDoc',json.encode(list));
                  isFav = !isFav;
                  // if(list.contains(doctor['doc_id'])){
                  //   list.removeWhere((id) => id ==  doctor['doc_id']);
                  // }else{
                  //   list.add(doctor['doc_id']);
                  // }
                  // Provider.of<AuthModel>(context,listen: false).setFavList(list);
                  // final SharedPreferences prefs = await SharedPreferences.getInstance();
                  // final token = prefs.getString('Token') ?? '';
                  // if(token.isNotEmpty && token != ''){
                  //   final response = await DioProvider().storeFavDoc(list, token);
                  //   if(response == 200){
                  //     setState((){
                  //       isFav = !isFav;
                  //     });
                  //   }
                  // }
                });
              },
              icon: FaIcon(
                isFav ? Icons.favorite : Icons.favorite_border_outlined,
                color: Colors.red,
              ))
        ],
      ),
      // CustomAppbar(
      //   title: "Doctor Details",
      //   icon: FaIcon(Icons.arrow_back_ios_new),
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         setState(()async {
      //           final list= Provider.of<AuthModel>(context, listen: false).getFav;
      //
      //           if(list.contains(doctor['doc_id'])){
      //             list.removeWhere((id) => id ==  doctor['doc_id']);
      //           }else{
      //             list.add(doctor['doc_id']);
      //           }
      //
      //           Provider.of<AuthModel>(context,listen: false).setFavList(list);
      //
      //           final SharedPreferences prefs = await SharedPreferences.getInstance();
      //           final token = prefs.getString('Token') ?? '';
      //
      //           if(token.isNotEmpty && token != ''){
      //             final response = await DioProvider().storeFavDoc(list, token);
      //             if(response == 200){
      //               setState((){
      //                 isFav = !isFav;
      //               });
      //             }
      //           }
      //
      //
      //         });
      //       },
      //       icon: FaIcon(
      //         isFav ? Icons.favorite : Icons.favorite_border_outlined,
      //         color: Colors.red,
      //       ))
      // ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: config.screenHeight - config.height45*2,
            child: Column(
              children: [
                DocDet(doctor: doctor!),
                doctor!.aboutDoctor!.isNotEmpty?
                AboutDoc(doctor: doctor!):Container(),
                Spacer(),
                Padding(padding: EdgeInsets.symmetric(horizontal: config.width45/2 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Examination fee",
                      style: TextStyle(
                          fontSize: config.font16, ),
                    ),
                    Text(
                      "\$${doctor!.doctorClinicModel!.price}",
                      style: TextStyle(
                          fontSize: config.font16,),
                    )
                  ],
                ),),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: config.height20,
                    left: config.width20,
                    right: config.width20,
                    top: config.height10,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>BookingPage(doctorModel: doctor!,));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        bottom: config.height15,
                        left: config.width20,
                        right: config.width20,
                        top: config.height15,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
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
                          "Book Appointment",
                          style: TextStyle(
                              fontSize: config.font18, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocDet extends StatelessWidget {
  const DocDet({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
              radius: config.radius30*2.25,
              backgroundImage: AssetImage("assets/images/profile.png")
              // NetworkImage("http://127.0.0.1:8000${doctor['doctor_profile']}"),
              ),
          config.screensmall,
          Text(
            "Dr ${doctor.name}",
            style: TextStyle(fontSize: config.font24, fontWeight: FontWeight.bold),
          ),
          config.screensmall,
          doctor.shortDescription!.isNotEmpty?SizedBox(
            width: config.screenWidth * 0.80,
            child: Text(
              "${doctor.shortDescription}",
              style: TextStyle(fontSize: config.font14, color: AppColors.paraColor),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ):Container(),
          doctor.shortDescription!.isNotEmpty?config.screensmall:Container(),
          SizedBox(
            width: config.screenWidth * 0.75,
            child: GestureDetector(
              onTap: (){
                Get.to(()=> ClinicDetails(clinic_id: doctor.doctorClinicModel!.clinicId));
              },
              child: Text(
                "Work in ${doctor.clinic}",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutDoc extends StatelessWidget {
  const AboutDoc({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(config.height20),
      margin: EdgeInsets.only(bottom: config.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          config.screenmedium,
          Text(
            "About Doctor",
            style: TextStyle(fontSize: config.font18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: config.height20,),
          Text(
            "${doctor.aboutDoctor}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}