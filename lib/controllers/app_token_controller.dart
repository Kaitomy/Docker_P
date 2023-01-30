import 'dart:async';
import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_application_3/utils/app_response.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class AppTokenController extends Controller {
  @override
  FutureOr<RequestOrResponse?> handle(Request request) {
    try {
      // Получаем токен из header запроса
      final header = request.raw.headers.value(HttpHeaders.authorizationHeader);
      final token = const AuthorizationBearerParser().parse(header);

      // Получаем jwt-claim для проверки токена
      final jwtClaim = verifyJwtHS256Signature(token ?? "", "SECRET_KEY");
      jwtClaim.validate();
      return request;
    } on JwtException catch (e) {
      return AppResponse.serverError(e.message);
    }
  }
}