import 'package:flutter_application_1/utils/auth_dio_utils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends QueuedInterceptor {
  SharedPreferences? sharedPreferences;
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);

    sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences!.getString("accessToken");

    if(token != "" && token!= null) {
      options.headers["Authorization"] = "Bearer $token";
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }
}