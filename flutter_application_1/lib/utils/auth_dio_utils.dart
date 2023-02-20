import 'package:flutter_application_1/interceptors/auth_interceptor.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDioUtils {
  late Dio dio;

  SharedPreferences? sharedPreferences;

  AuthDioUtils() {
    _connectDio();
   _share();
  }

  Future<void> _share() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _connectDio() async {
    
    dio = new Dio(
      BaseOptions(
          baseUrl: "http://localhost:8889",
          connectTimeout: const Duration(milliseconds: 3500),
          receiveTimeout: const Duration(milliseconds: 3500),
          sendTimeout: const Duration(milliseconds: 3500)),
    );


    dio.interceptors.add(AuthInterceptor());
  }

  Future<bool> Auth(String userName, String password) async {
    try {
      final response = await dio.post("/token",
          data: Map.from({'userName': userName, 'password': password}));
      if (response.statusCode == 200) {
        sharedPreferences!.setString("accessToken", response.data["data"]["accessToken"]);
        sharedPreferences!.setString("refreshToken", response.data["data"]["refreshToken"]);
        return true;
      }
      else {return false;}
    } on DioError catch (error) {
      print(error.response!.statusCode);
      return false;
    }
  }

   Future<bool> changeProfile(String userName, String email, String oldPassword, String newPassword) async {
    try {
      dio.options.headers['Authorization'] = sharedPreferences!.getString('accessToken');
      final response = await dio.post("/user",
          data: Map.from({'userName': userName, 'email': email}));  
      if (newPassword != "") {
        final response_pass = await dio.put("/user", queryParameters: {"oldPassword": oldPassword, "newPassword": newPassword});
      }
      if (response.statusCode == 200 ) { return true;}
     else { return false;}
    } on DioError catch (error) {
      print(error.response!.statusCode);
      return false;
    }
   }
}