import 'package:appointment_booking/components/bigtext.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:appointment_booking/pages/reservation/reservation_page.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessfullBooking extends StatelessWidget {
  const SuccessfullBooking({super.key, this.update = false});
  final bool update;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: config.height45*2,
              width: config.height45*2,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/done.png'),fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: config.height25,),
            (update == true)?
            BigText(text: 'Your reservation has been updated.',color: AppColors.mainColor,):
            BigText(text: 'Your booking taken successfully.',color: AppColors.mainColor,),
            SizedBox(height: config.height10,),
            GestureDetector(
              onTap: (){

                Get.close(3);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(config.radius15),
                    boxShadow:[
                      BoxShadow(
                          color: Colors.grey.shade700,
                          offset: Offset(0, 1),
                          blurRadius: 2
                      )
                    ]
                ),
                padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height10),
                child: BigText(text: 'Back to reservations page',size: config.font16,color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
