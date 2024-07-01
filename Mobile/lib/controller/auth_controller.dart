import 'package:appointment_booking/components/snack_bar.dart';
import 'package:appointment_booking/controller/api.dart';
import 'package:appointment_booking/pages/auth/auth_page.dart';
import 'package:appointment_booking/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService{
  Apis apis;
  SharedPreferences sharedPreferences;
  AuthController({required this.apis, required this.sharedPreferences});
  Map<String,dynamic> data = {};
  bool isLoading = false;

  void clearToekn(){
    sharedPreferences.remove('token');
    return print('token is ${sharedPreferences.getString('token')}');
  }

  Future Register(String name, String password, String phone) async{
    isLoading = true;
    update();

    data = {'name':name,'password':password,'phone':phone,};
    Response response = await apis.postData("api/User/auth/register", data);

    if(response.statusCode == 200){
      apis.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString('token', response.body['token']);
      Get.to(()=> HomePage());
      isLoading = false;
      update();
      print(response.statusText);
      return response.statusText;
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      if(response.statusText == 'Forbidden' || response.statusText =='Internal Server Error') {
        print('Phone number already exist');
        return getSnackBar('Phone number already exist');
      }else{
        return getSnackBar(response.statusText!);
      }
    }
  }

  Future login(String phone, String password) async{
    isLoading = true;
    update();

    data = {'phone':phone,'password':password};
    Response response = await apis.postData("api/User/auth/login", data);

    if(response.statusCode == 200){
      apis.updateToken(response.body['token']);
      print("Token is ${response.body['token']}");
      await sharedPreferences.setString('token', response.body['token']);
      Get.to(()=> HomePage());
      isLoading = false;
      update();
      print('logged in successful');
      return response.statusText;
    }else{
      isLoading = false;
      update();
      print(response.statusText);
      return getSnackBar('Check phone no or password');
    }
  }

  Future logout() async{
    sharedPreferences.remove('token');

    Get.to(()=> AuthPage());
  }
}