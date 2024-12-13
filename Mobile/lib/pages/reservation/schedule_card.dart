import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.date,required this.day, required this.time});

  final String date;
  final String day;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      padding: EdgeInsets.all(config.height20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month_outlined,color: AppColors.mainColor),
          SizedBox(width: config.width10/2,),
          Text("$day, $date",style: TextStyle(color: AppColors.mainColor),),
          SizedBox(width: config.width20,),
          Icon(Icons.alarm,color: AppColors.mainColor),
          SizedBox(width: config.width10/2,),
          Text("$time",style: TextStyle(color:AppColors.mainColor),),
        ],
      ),
    );
  }
}