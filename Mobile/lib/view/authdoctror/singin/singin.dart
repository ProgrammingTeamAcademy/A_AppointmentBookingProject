import 'package:booksdoctor/controols/controolSinDoctor.dart';
import 'package:booksdoctor/shaerd/components/TextFormFild.dart';
import 'package:booksdoctor/shaerd/components/button.dart';
import 'package:booksdoctor/wdgit/CarouselSlider.dart';
import 'package:booksdoctor/wdgit/icon_page.dart';
import 'package:booksdoctor/wdgit/image_circal.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SingDoctor extends StatelessWidget {
  const SingDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    var key = GlobalKey<FormState>();
    var key2 = GlobalKey<FormState>();
    // return GetBuilder<con_sin_doctor>(
    //   builder: (controller) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.center,
          //
          //
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            const AnimatedImageDoctor(),
            inf_sing(carouselController, context, key, key2, user: false),
            GetBuilder(
              init: con_sin_doctor(),
              builder: (controller) {
                return Column(
                  children: [
                    icon_page(
                      controller,
                      carouselController,
                      key,
                    ),
                    Button(
                        widith: 150,
                        title: "تسجيل دخول",
                        disable: !controller.dane_input_sing ? true : false,
                        onprssed: () {
                          controller.IsEmailEX(
                              email: controller.email.text,
                              phone: controller.phone.text,
                              name: controller.name.text,
                              password: controller.password.text,
                              user_name: controller.textUser_name.text,
                              context: context);
                        }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  //);
}
//}
//}  );
//}

// ignore: non_constant_identifier_names

