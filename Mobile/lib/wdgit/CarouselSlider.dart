import 'package:booksdoctor/controols/controolSinDoctor.dart';
import 'package:booksdoctor/shaerd/components/TextFormFild.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

inf_sing(CarouselController carouselController, BuildContext context,
    GlobalKey<FormState> key, GlobalKey<FormState> key2,
    {required bool user}) {
  return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          height: MediaQuery.sizeOf(context).height * 0.45,
          autoPlay: false,
          animateToClosest: false,
          padEnds: false,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          viewportFraction: 1

          // scrollDirection: Axis.horizontal,
          ),
      items: [
        SingleChildScrollView(
            child: GetBuilder<con_sin_doctor>(
          init: con_sin_doctor(),
          builder: (controller) {
            return sing_text_form_filed(
              context,
              key,
              IsOne: false,
              hintone: 'ادجل اسم الكامل',
              hinttwo: 'ادجل رقم الجوال ',
              valdiate2: (String? b) {
                if (b!.isEmpty) {
                  return "الرجاء ادخال الرقم";
                } else if (!isNumeric(b)) {
                  return "ادخل رقم صحيح";
                }

                return null;
              },
              valdiate1: (p0) {
                if (p0!.isEmpty) {
                  return "ادخل الاسم";
                }
                return null;
              },
              textEditingController1: controller.name,
              textEditingController2: controller.phone,
            );
          },
        )),
        SingleChildScrollView(
          child: GetBuilder<con_sin_doctor>(
              init: con_sin_doctor(),
              builder: (controll) {
                key2.currentState?.validate;
                return sing_text_form_filed(
                  context,
                  key2,
                  IsOne: user ? false : true,
                  onchanged1: (p0) {
                    if (key2.currentState!.validate()) {
                      print(true);
                      controll.changed_dane();
                    } else {
                      controll.changed_flase();
                    }

                    //
                    //print(p0.toString());
                  },
                  prficon: controll.looding
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          width: 5,
                          height: 5,
                          child: const CircularProgressIndicator())
                      : const SizedBox(),
                  onchanged3: (p0) {
                    controll
                        .checkUserNameAvailability(p0.toString())
                        .then((value) {
                      if (key2.currentState!.validate()) {
                        print(true);
                        controll.changed_dane();
                      } else {
                        controll.changed_flase();
                      }

                      print(controll.isnameex);
                    });
                  },
                  onchanged2: (p0) {
                    if (key2.currentState!.validate()) {
                      print(true);
                      controll.changed_dane();
                    } else {
                      controll.changed_flase();
                    }
                  },
                  hint: "المعرف",
                  hintone: "ادخل الايميل",
                  hinttwo: "ادخل كلمة السر",
                  textEditingController3: controll.textUser_name,
                  valdiate3: (p0) {
                    if (!controll.isnameex) {
                      return controll.er;
                    }
                    return null;
                  },
                  textEditingController1: controll.email,
                  textEditingController2: controll.password,
                  valdiate1: (p0) {
                    if (p0!.isEmpty) {
                      return "ارجاء ادخال الايميل";
                    } else if (!p0.contains(RegExp(r'\w{1,}\@gmail\.com'))) {
                      return "ادخل ايميل صالح";
                      //
                    }
                    return null;
                  },
                  valdiate2: (p0) {
                    if (p0!.isEmpty) {
                      return " الرجاء ادخال كلمة السر";
                    } else if (!p0.contains(RegExp(
                        r'^(?=.*[A-Z])(?=.*\d.*\d)(?=.*[a-z].*[a-z]).*$'))) {
                      return " ادخال كلمة سر تحتوي حرفين وحرف كبير ورقميين بل الغة الانكليزية";
                    }
                    return null;
                  },
                );
              }),
        )
      ]);
}

SizedBox sing_text_form_filed(
  BuildContext context,
  GlobalKey<FormState> key, {
  String? hint,
  Function(String?)? onchanged1,
  Function(String?)? onchanged2,
  Function(String?)? onchanged3,
  String? Function(String?)? valdiate3,
  Widget? prficon,
  TextEditingController? textEditingController3,
  required bool IsOne,
  required String hintone,
  required String hinttwo,
  required TextEditingController textEditingController1,
  required TextEditingController textEditingController2,
  required String? Function(String?) valdiate1,
  required String? Function(String?) valdiate2,
}) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    // height: MediaQuery.sizeOf(context).height * 0.3,
    child: Form(
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            // height: 90,
            width: MediaQuery.sizeOf(context).width,
            // color: Colors.amber,
            child: TextForm(
                onfilld: onchanged1,
                hinitext: hintone,
                keyboardType: TextInputType.emailAddress,
                textEditingController: textEditingController1,
                validat: valdiate1),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            // height: 90,
            width: MediaQuery.sizeOf(context).width,
            // color: Colors.amber,
            child: TextForm(
              onfilld: onchanged2,
              hinitext: hinttwo,
              textEditingController: textEditingController2,
              validat: valdiate2,
            ),
          ),
          IsOne
              ? Container(
                  padding: const EdgeInsets.all(20),
                  // height: 90,
                  width: MediaQuery.sizeOf(context).width,
                  // color: Colors.amber,
                  child: TextForm(
                    onfilld: onchanged3!,
                    prficon: prficon,
                    // (p0) {
                    //   con_sin_doctor()
                    //       .checkUserNameAvailability(p0.toString())
                    //       .then((value) {
                    //     key.currentState!.validate();
                    //     print(controller.isnameex.value);
                    //   });
                    // },
                    hinitext: "المعرف ",

                    textEditingController: textEditingController3!,
                    validat: valdiate3!,
                    // (p0) {
                    //   if (!controller.isnameex.value) {
                    //     return controller.isnameex.toString();
                    //   }
                    //   return null;
                    // },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    ),
  );
}

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  return double.tryParse(s) != null;
}
