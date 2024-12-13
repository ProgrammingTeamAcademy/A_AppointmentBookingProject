import 'package:appointment_booking/components/profile_page_containers.dart';
import 'package:appointment_booking/components/text_form_field.dart';
import 'package:appointment_booking/controller/auth_controller.dart';
import 'package:appointment_booking/pages/profile/sub_widgets/province.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appointment_booking/components/config.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  right: config.width20,
                  left: config.width20,
                  top: config.height20,
                  bottom: config.height45),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: config.font18),
                      textAlign: TextAlign.center,
                    ),
                    config.screensmall,
                    Stack(
                      children: [
                        Container(
                          height: config.height45 * 3,
                          width: config.width45 * 3,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/profile.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          right: config.width10 / 2,
                          bottom: config.height10 / 2,
                          child: Container(
                            height: config.height10 * 3.5,
                            width: config.height10 * 3.5,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Icon(
                              CupertinoIcons.camera,
                              color: Colors.white,
                              size: config.iconSize18,
                            )),
                          ),
                        )
                      ],
                    ),
                    config.screensmall,
                    ProfilePageContainers(
                        iconData: CupertinoIcons.person_solid,
                        text: authController.userModel!.name!),
                    SizedBox(
                      height: config.height20,
                    ),
                    //phone
                    GestureDetector(
                        onTap: () {
                          TextEditingController _phone =
                              TextEditingController();
                          _phone.text = authController.userModel!.phone!;
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(config.radius15)),
                              ),
                              title: Text('Do you wanna change your number',
                                  style: TextStyle(fontSize: config.font18)),
                              content: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Phone number',
                                    hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: config.font20,
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  controller: _phone),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Get.close(1),
                                  child: Text('No',
                                      style:
                                          TextStyle(fontSize: config.font16)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      authController.updateUser(phone: _phone.text);
                                      authController.getUser();
                                      Get.close(1);
                                    });
                                  },
                                  child: Text('Update',
                                      style: TextStyle(
                                          fontSize: config.font16)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: ProfilePageContainers(
                            iconData: CupertinoIcons.phone,
                            text: authController.userModel!.phone!)),
                    SizedBox(
                      height: config.height20,
                    ),
                    //province
                    ProvinceWidget(authController: authController),
                    SizedBox(
                      height: config.height20,
                    ),
                    Spacer(),
                    //log out
                    SizedBox(
                      height: config.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.find<AuthController>().logout(context);
                        print('logged out');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: config.width15,
                            vertical: config.height10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.redAccent,
                              size: config.iconSize18,
                            ),
                            SizedBox(
                              width: config.width10,
                            ),
                            Text(
                              'Log out',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: config.font20,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
