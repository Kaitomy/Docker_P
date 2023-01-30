import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_application_3/model/user.dart';
import 'package:dart_application_3/utils/app_response.dart';
import 'package:dart_application_3/utils/app_utils.dart';

class AppUserController extends ResourceController {
  AppUserController(this.managedContext);

  final ManagedContext managedContext;

  @Operation.get()
  Future<Response> getProfile(
      @Bind.header(HttpHeaders.authorizationHeader) String header) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      user!.removePropertiesFromBackingMap(['refreshToken', 'accessToken']);
      return AppResponse.ok(
          message: 'Успешное получения профиля', body: user.backing.contents);
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка получения профиля');
    }
  }

  @Operation.post()
  Future<Response> updateProfile(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.body() User user) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      var fUser = await managedContext.fetchObjectWithID<User>(id);

      // Запрос для обновления данных пользователя
      final qUpdateUser = Query<User>(managedContext)
        ..where((x) => x.id).equalTo(id)
        ..values.userName = user.userName ?? fUser!.userName
        ..values.email = user.email ?? fUser!.email;
      await qUpdateUser.updateOne();

      // Получаем обновленного пользователя
      final findUser = await managedContext.fetchObjectWithID<User>(id);
      findUser!.removePropertiesFromBackingMap(['refreshToken', 'accessToken']);

      return AppResponse.ok(
        message: 'Успешное обновление данных',
        body: findUser.backing.contents);
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка обновления данных');
    }
  }

  @Operation.put()
  Future<Response> updatePassword(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.query('newPassword') String newPassword,
      @Bind.query('oldPassword') String oldPassword
      ) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final qFindUser = Query<User>(managedContext)
        ..where((element) => element.id).equalTo(id)
        ..returningProperties(
          (element) => [element.salt, element.hashPassword]);
      final fUser = await qFindUser.fetchOne();

      final oldHashPassword =
          generatePasswordHash(oldPassword, fUser!.salt ?? "");
      if (oldHashPassword != fUser.hashPassword) {
        return AppResponse.badrequest(message: 'Неверный старый пароль');
      }

      final newHashPassword =
          generatePasswordHash(newPassword, fUser.salt ?? "");
      // запрос на обновление пароля
      final qUpdateUser = Query<User>(managedContext)
        ..where((x) => x.id).equalTo(id)
        ..values.hashPassword = newHashPassword;
      await qUpdateUser.fetchOne();

      return AppResponse.ok(message: 'Пароль успешно обновлен');
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка обновления пароля');
    }
  }
}
