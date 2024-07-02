import 'package:booksdoctor/controols/controllSinUser.dart';
import 'package:booksdoctor/controols/controolSinDoctor.dart';
import 'package:booksdoctor/shaerd/context/channel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';

class Wait_agrePage extends StatefulWidget {
  const Wait_agrePage({
    super.key,
  });

  @override
  State<Wait_agrePage> createState() => _Wait_agrePageState();
}

class _Wait_agrePageState extends State<Wait_agrePage> {
  String status = 'Loading...';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // PusherService pusherService = PusherService();

    // pusherService.initChannel(widget.UrlDoctor, (event) {
    //   setState(() {
    //     status = event!.data!;
    //   });
    // });
  }

  // pusherService.channel.bind('App\\Events\\StatusUpdatam', (event) {
  //   setState(() {
  //     status = event!.data!;
  //   });

  //);
  //}

  @override
  Widget build(BuildContext context) {
    var control = Get.put(con_sin_doctor());
    control.AmainAgery();

    return const Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("بانتظار موافقة المشرف")],
          ),
        ),
      ),
    );
  }
}
