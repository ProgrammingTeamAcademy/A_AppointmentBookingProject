import 'package:appointment_booking/controller/clinic_controller.dart';
import 'package:appointment_booking/model/clinic_model.dart';
import 'package:appointment_booking/pages/clinic/about_clinic.dart';
import 'package:appointment_booking/pages/clinic/clinic_det.dart';
import 'package:appointment_booking/pages/clinic/doctor_work_in.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClinicDetails extends StatelessWidget {
   ClinicDetails({super.key, required this.clinic_id});

   var clinic_id;
  ClinicModel? clinicModel ;


  @override
  Widget build(BuildContext context) {
    print(clinic_id);
    return GetBuilder<ClinicController>(builder: (clinicController){
      for(var c in clinicController.Clinics){
        if(c.id == clinic_id){
          clinicModel = c ;
        }
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Clinic Details",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          leading: FaIcon(Icons.arrow_back_ios_new) != null
              ? Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: FaIcon(Icons.arrow_back_ios_new),
              color: Colors.black54,
              iconSize: 16,
            ),
          )
              : null,
          // actions: widget.actions,
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
            child: Column(
              children: [
                ClinicDet(clinicModel: clinicModel!),
                clinicModel!.about!.isNotEmpty?
                AboutClinic(clinicModel: clinicModel!):Container(),
                DoctorWorkIn(clinicModel: clinicModel!)
              ],
            ),
          ),
        ),
      );
    });
  }
}




