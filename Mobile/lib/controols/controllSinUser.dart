import 'package:flutter/material.dart';
import 'package:get/get.dart';

class con_sin_user extends GetxController {
  bool item_arrow = false;
  void changed() {
    item_arrow = !item_arrow;
    update();
  }

  bool dane_input_sing = false;
  void changed_dane() {
    dane_input_sing = true;

    update();
  }

  TextEditingController textname = TextEditingController();

  TextEditingController textphone = TextEditingController();
  void insertextname(String name) {
    textname.text = name;
    print(name);
    update();
  }

  void insertTextPhone(String phone) {
    textname.text = phone;
    update();
  }
}
