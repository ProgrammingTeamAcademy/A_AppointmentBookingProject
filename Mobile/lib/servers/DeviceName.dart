// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';

// Future<String> getDeviceName() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   String deviceName;

//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     deviceName = '${androidInfo.brand} ${androidInfo.model}';
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     deviceName = '${iosInfo.name} ${iosInfo.model}';
//   } else {
//     deviceName = 'Unknown Device';
//   }

//   return deviceName;
// }