import 'package:booksdoctor/controols/controolSinDoctor.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

Padding icon_page(
  con_sin_doctor controller,
  CarouselController carouselController,
  GlobalKey<FormState> key,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AnimatedAlign(
      duration: const Duration(milliseconds: 400),
      alignment: !controller.item_arrow
          ? AlignmentDirectional.bottomEnd
          : AlignmentDirectional.bottomStart,
      child: IconButton(
          onPressed: () {
            if (controller.item_arrow) {
              carouselController
                  .previousPage(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.easeInSine)
                  .then((value) {
                controller.changed();
              });
            }
            if (key.currentState!.validate()) {
              if (!controller.item_arrow) {
                carouselController
                    .nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeInSine)
                    .then((value) {
                  controller.changed();
                });
              }
            }
          },
          icon: Icon(
            !controller.item_arrow ? Icons.arrow_right : Icons.arrow_left,
            size: 30,
          )),
    ),
  );
}
