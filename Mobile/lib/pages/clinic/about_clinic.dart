import 'package:appointment_booking/model/clinic_model.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher ;
import 'package:appointment_booking/components/config.dart';

class AboutClinic extends StatelessWidget {
  const AboutClinic({super.key, required this.clinicModel});

  final ClinicModel clinicModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: config.height20,
      left: config.width20 ,right: config.width20),
      // margin: EdgeInsets.only(bottom: config.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "About clinic",
            style: TextStyle(fontSize: config.font18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: config.height20,),
          Text(
            "${clinicModel.about}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: config.height10,),
          Divider(
              color: Colors.black
          ),
          SizedBox(height: config.height10,),
          Text(
            "Address",
            style: TextStyle(fontSize: config.font18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: config.height10,),
          Text(
            "${clinicModel.address}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: config.height10/2,),
          Text(
            "City: ${clinicModel.province}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: config.height10,),
          Divider(
              color: Colors.black
          ),
          SizedBox(height: config.height10,),
          Text(
            "Phone number",
            style: TextStyle(fontSize: config.font18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: config.height10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${clinicModel.phone}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
              GestureDetector(
                onTap: () => UrlLauncher.launch("tel://${clinicModel.phone}"),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: config.width15),
                  padding:  EdgeInsets.symmetric(
                      horizontal:  config.width10,
                      vertical: config.height10
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
                  child: FaIcon(Icons.phone, color: AppColors.mainColor,size: config.iconSize16,),
                ),
              )
            ],
          ),
          SizedBox(height: config.height10,),
          Divider(
              color: Colors.black
          ),
          SizedBox(height: config.height10,),
        ],
      ),
    );
  }
}