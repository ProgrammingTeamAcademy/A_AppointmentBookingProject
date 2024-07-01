import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Apis extends GetConnect implements GetxService{
  late String token = '';
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String,String> mainHeader;

  Apis({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString('token') ?? '';
    mainHeader = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    };
  }

  void updateToken(String token){
    this.token = token;
    this.mainHeader = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    };

  }

  Future getData(String uri, {Map<String,String>? header}) async {
    try{
      var response = await get(uri,
          headers: header ?? mainHeader);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future postData(String uri,dynamic body) async {
    try{
      Response response = await post(uri,body,headers: mainHeader);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}