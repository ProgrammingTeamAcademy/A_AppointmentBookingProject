import 'package:appointment_booking/components/bigtext.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';

class ProfilePageContainers extends StatelessWidget {
  final IconData iconData;
  final String text;
  ProfilePageContainers({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: config.width20),
      padding: EdgeInsets.symmetric(horizontal: config.width20),
      width: double.maxFinite,
      height: config.height20*3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(config.radius30),
        boxShadow:[
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 2),
            blurRadius: 2
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: config.height10*3,
            width: config.height10*3,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(iconData,color: Colors.white,size: config.iconSize18,)),
          ),
          SizedBox(width: config.width20,),
          BigText(text: text,color: Colors.black54,size: config.font22,)
        ],
      ),
    );
  }
}
