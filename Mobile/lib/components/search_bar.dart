import 'package:appointment_booking/components/smalltext.dart';
import 'package:appointment_booking/components/text_form_field.dart';
import 'package:appointment_booking/controller/clinic_controller.dart';
import 'package:appointment_booking/controller/doctor_controller.dart';
import 'package:appointment_booking/model/clinic_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:appointment_booking/pages/clinic/clinic_details.dart';
import 'package:appointment_booking/pages/doctor/doctor_details.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {

  SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showSearch(context: context, delegate:MySearchDelegant ());
      },
      child: Container(
        width: double.maxFinite,
        height: config.height20*2.5,
        margin: EdgeInsets.symmetric(horizontal: config.width15),
        padding:  EdgeInsets.symmetric(
          horizontal:  config.width15,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(config.radius15),
            boxShadow:[
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0, 2),
                  blurRadius: 4
              )
            ]
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded,color: AppColors.mainColor,size: config.iconSize20,),
            SizedBox(width: config.width15,),
            SmallText(text: "Search by doctor, clinic or city",
            color: Colors.black54,size: config.font16,)
          ],
        ),
      ),
    );
  }
}


class  MySearchDelegant extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isNotEmpty? Padding(
        padding:  EdgeInsets.all(config.width10),
        child: IconButton(
          onPressed: () {
            query = "";
          },
          icon: FaIcon(Icons.clear,size: config.iconSize18),
        ),
      ):Container()
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: FaIcon(Icons.arrow_back_ios_new,size: config.iconSize18,));
  }

  @override
  Widget buildResults(BuildContext context) {



    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List clinics =[];
    List doctors =[];

    if(query.isNotEmpty) {
      for (var doc in Get
          .find<DoctorController>()
          .Doctors) {
        if (doc.name.toLowerCase().contains(query.toLowerCase())) {
          doctors.add(doc);
        }
      }

      for(var clinic in Get.find<ClinicController>().Clinics){
        if (clinic.name.toLowerCase().contains(query.toLowerCase())||clinic.province.toLowerCase().contains(query.toLowerCase())) {
          clinics.add(clinic);
        }
      }
    }
    ///return filter Items on ListView
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: config.width15,vertical: config.height20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            clinics.isNotEmpty? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clinics',
                  style: TextStyle(fontSize: config.font16,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: config.height10,),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: clinics.length,
                    itemBuilder: (context, index){
                      return SearchCCard(clinic: clinics[index]);
                    }),
                SizedBox(height: config.height20,),
              ],
            ):Container(),
            doctors.isNotEmpty? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doctors',
                  style: TextStyle(fontSize: config.font16,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: config.height10,),
                ListView.builder(
                      shrinkWrap: true,
                      itemCount: doctors.length,
                      itemBuilder: (context, index){
                        return SearchDCard(doctor: doctors[index]);
                      }),
              ],
            ):Container()
          ],
        ),
      ),
    );
  }


}

class SearchDCard extends StatelessWidget {
  const SearchDCard({super.key, required this.doctor});
  final DoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: config.height10),
      height: config.height45 *1.75,
      child: GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: config.width10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(config.radius15),
                boxShadow:[
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 3),
                      blurRadius: 4
                  )
                ]
            ),
            child: Row(
              children: [
                Container(
                  width: config.height45 * 1,
                  height: config.height45 * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(config.radius30*2),
                      image: DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.cover
                        // Image.network("http://127.0.0.1:8000${doctor.image}"
                        //   , fit: BoxFit.fill,),
                      )),
                ),
                SizedBox(width: config.width20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr ${doctor.name}",
                      style: TextStyle(
                          fontSize: config.font16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${doctor.specialist}",
                      style: TextStyle(
                        fontSize: config.font14,
                      ),
                    ),
                  ],
                )
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

class SearchCCard extends StatelessWidget {
  const SearchCCard({super.key, required this.clinic});
  final ClinicModel clinic;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: config.height10),
      height: config.height45 *1.75,
      child: GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: config.width10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(config.radius15),
                boxShadow:[
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 3),
                      blurRadius: 4
                  )
                ]
            ),
            child: Row(
              children: [
                Container(
                  width: config.height45 * 1,
                  height: config.height45 * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(config.radius30*2),
                      image: DecorationImage(
                          image: AssetImage("assets/images/clinic1.jpg"),
                          fit: BoxFit.cover
                        // Image.network("http://127.0.0.1:8000${doctor.image}"
                        //   , fit: BoxFit.fill,),
                      )),
                ),
                SizedBox(width: config.width20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${clinic.name}",
                      style: TextStyle(
                          fontSize: config.font16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: config.height10/3,),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,size: config.iconSize16,color: AppColors.iconColor2,),
                        SizedBox(width: config.width10/2,),
                        Text(
                          "${clinic.province}",
                          style: TextStyle(
                            fontSize: config.font14,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            // MyApp.navigatorKey.currentState!.push(MaterialPageRoute(builder: (_)=>DoctorDetails(
            //   doctor: doctor,isfav: isfav,
            // ) ));
            Get.to(ClinicDetails(clinic_id: clinic.id,));
          } // Doctors Details,
      ),
    );
  }
}
