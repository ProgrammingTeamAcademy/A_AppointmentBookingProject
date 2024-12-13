import 'dart:convert';

import 'package:appointment_booking/components/profile_page_containers.dart';
import 'package:appointment_booking/components/smalltext.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/controller/prevince_controller.dart';
import 'package:appointment_booking/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:get/get.dart';

class ProvinceWidget extends StatefulWidget {
  ProvinceWidget({super.key, required this.authController});
  AuthController authController;

  @override
  State<ProvinceWidget> createState() => _ProvinceWidgetState();
}

class _ProvinceWidgetState extends State<ProvinceWidget> {
  List countries = [];
  List provincesA = [];
  Map<String, dynamic>? province;
  String? provinceName;
  late String countryName;
  int? provinceId;
  List provinces = [];
  Map user = {};

  @override
  void initState() {
    super.initState();
    countries = json.decode(widget.authController.sharedPreferences
        .getString('country')
        .toString());
    provinces = json.decode(widget.authController.sharedPreferences
        .getString('province')
        .toString());
    countryName = countries[0];
    provincesA = [];
    for(var p in provinces){
      if(p['country'] == countryName){
        provincesA.add(p);
      }
    }
    provinceName = provincesA[0]['province_name'];
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        user = json.decode(widget.authController.sharedPreferences
            .getString('userInfo')
            .toString());
        // print(provinces);
        provincesA = [];
        for(var p in provinces){
          if(p['country'] == countryName){
            provincesA.add(p);
          }
        }

      });
    });

    return GestureDetector(
      onTap: () {

        provinceId = widget.authController.userModel!.provinceID!;
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => Center(
            child: Container(
              height: config.screenHeight * 0.36,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(config.radius15)),
                ),
                title: Text('Do you wanna change your city',
                    style: TextStyle(fontSize: config.font18)),
                content: Column(
                  children: [
                    DropdownButton(
                        value: countryName,
                        items: countries.map((e) {
                          return DropdownMenuItem(
                              value: e.toString(),
                              child: SmallText(
                                text: e,
                                color: Colors.black54,
                              ));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            countryName = newValue.toString();
                            provincesA = [];
                            for(var p in provinces){
                              if(p['country'] == countryName){
                                provincesA.add(p);
                              }
                            }
                            provinceName = provincesA[0]['province_name'];
                            // user['country_id'] = country!['id'];
                            // widget.authController.sharedPreferences
                            //     .remove('userInfo');
                            // widget.authController.sharedPreferences
                            //     .setString('userInfo', json.encode(user));
                            // print(widget.authController.sharedPreferences
                            //     .getString('userInfo'));

                            // Get.find<ProvinceController>()
                            //     .getProvinces(country!['id']);
                            // provinces = json.decode(widget
                            //     .authController.sharedPreferences
                            //     .getString('province')
                            //     .toString());
                            // print(provinces);
                            // provinceName = provinces[0]['province_name'];
                          });
                        }),
                    SizedBox(
                      height: config.height10 / 2,
                    ),
                    DropdownButton(
                      value:  provinceName,
                        items: provincesA.map(( e){
                      return DropdownMenuItem(
                          value: e['province_name'],
                          child: SmallText(text: e['province_name'],color: Colors.black54,)
                      );
                    }).toList(),
                        onChanged: (newValue){
                        setState((){
                          print(provinceName);
                          provinceName = newValue.toString() ;
                          print("$provinceName, $newValue");
                          for(var p in provincesA){
                            if(p['province_name'] == provinceName){
                              provinceId = p['id'];
                            }
                          }
                        });
                      }),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Get.close(1),
                    child:
                        Text('No', style: TextStyle(fontSize: config.font16)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        widget.authController
                            .updateUser(provinceID: provinceId);
                        widget.authController.getUser();
                        Get.close(1);
                      });
                    },
                    child: Text('Update',
                        style: TextStyle(fontSize: config.font16)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: ProfilePageContainers(
          iconData: CupertinoIcons.location_solid,
          text: widget.authController.userModel!.provinceName ?? ''),
    );
  }
}
