import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booksdoctor/modles/doctorModles.dart';
import 'package:booksdoctor/servers/dio.dart';
import 'package:booksdoctor/shaerd/context/channel.dart';
import 'package:booksdoctor/view/DoctorLayout/hameDoctor/hameDoctor.dart';
import 'package:booksdoctor/view/Wait_agre/Wait_agrePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class con_sin_doctor extends GetxController {
  bool item_arrow = false;
  String er = 'الرجاء الانتظار ';
  bool looding = false;
  bool isnameex = false;

  int? id;
  String? token;

  late TextEditingController textUser_name = TextEditingController();
  late SharedPreferences prefs;

  late TextEditingController password = TextEditingController();
  late TextEditingController email = TextEditingController();
  late TextEditingController name = TextEditingController();
  late TextEditingController phone = TextEditingController();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    password.dispose();
    email.dispose();
    name.dispose();
    phone.dispose();
  }

  static final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://2375-185-177-125-212.ngrok-free.app/api/Doctor/',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }));

  // Example method to check username availability

  void changed() {
    item_arrow = !item_arrow;
    update();
  }

  bool dane_input_sing = false;
  void changed_dane() {
    dane_input_sing = true;

    update();
  }

  void changed_flase() {
    dane_input_sing = false;

    update();
  }

  Future<void> checkUserNameAvailability(String userName) async {
    er = 'الرجاء الانتظار ';
    looding = true;
    isnameex = false;

    update();
    await dio.post(
      'auth/isUserNameEx',
      data: {'user_name': userName},
    ).then((value) {
      var response = value;

      print(response.data['name_ex']);
      bool o = response.data['name_ex'];
      isnameex = o;
      er = ' اسم مستخدم موجود';
      looding = false;
      update();
    }).catchError((e) {
      print('Error: $e');
    });
  }

  Future<void> IsEmailEX({
    required String email,
    required String name,
    required String password,
    required String user_name,
    required String phone,
    required BuildContext context,
  }) async {
    await dio.post('auth/isEmailEx', data: {'email': email}).then((value) {
      var response = value;
      var data = response.data;
      if (!data['status']) {
        AwesomeDialog(
                btnOk: const Text('تعديل'),
                btnOkOnPress: () {
                  print("object");
                  Get.back();
                },
                context: context,
                title: data['erorr'],
                dialogType: DialogType.error)
            .show();
      } else {
        registerDoctorAccout(
            email: email,
            name: name,
            password: password,
            user_name: user_name,
            phone: phone,
            context: context);
      }
      print(data);
    });
  }

  Future<void> registerDoctorAccout({
    required String email,
    required String name,
    required String password,
    required String user_name,
    required String phone,
    required BuildContext context,
  }) async {
    DoctorModel doctorModels =
        DoctorModel(email, name, password, user_name, phone);
    print(doctorModels.ToMap());
    await dio.post('auth/register', data: doctorModels.ToMap()).then((value) {
      var response = value;
      var data = response.data;
      print(data);
      id = data['id'];
      token = data['token'];

      DoctorTokenStore(id!, token!, context);
    }).catchError((x) {
      print(x);
    });
  }

  void DoctorTokenStore(int id, String tokens, BuildContext context) {
    prefs.setInt('doctor_id', id).then((value) {
      prefs.setString('doctor_token', tokens).then((value) {
        Get.to(const Wait_agrePage());
      });
    });
  }

  PusherService pusherService = PusherService();
  RxBool stauts = false.obs;
  void AmainAgery() {
    print("gggggggggggggggggggggggggggg$id");
    pusherService.initChannel((event) {
      var res = jsonDecode(event!.data!);
      print(res['user_id']);
      if (res['user_id'] == id) {
        print("fvbnm,./");
        Get.to(() => const hameDoctor());
      }
    });
  }
}
