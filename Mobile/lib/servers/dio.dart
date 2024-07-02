import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxController {
  RxBool isnameex = false.obs;
  static final Dio dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8000',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }));

  // Example method to check username availability
  Future<void> checkUserNameAvailability(String userName) async {
    await dio.post(
      '/api/Doctor/auth/isUserNameEx',
      data: {'user_name': userName},
    ).then((value) {
      var response = value;
      print(response.data['name_ex']);
      isnameex = RxBool(response.data['name_ex']);
    }).catchError((e) {
      print('Error: $e');
    });
  }
}
