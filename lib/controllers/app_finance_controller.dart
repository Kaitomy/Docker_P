import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_application_3/model/finance.dart';
import 'package:dart_application_3/model/user.dart';
import 'package:dart_application_3/utils/app_response.dart';
import 'package:dart_application_3/utils/app_utils.dart';

class FinanceController extends ResourceController {
  FinanceController(this.managedContext);

  final ManagedContext managedContext;
//создание
  @Operation.post()
  Future<Response> createFinance(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.body() Finance finance) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      if (user == null) {
        throw AppResponse.badrequest(message: 'ошибка пользователя');
      }

      final qCreateFinance = Query<Finance>(managedContext)
        ..values.user!.id = id
        ..values.financeName = finance.financeName
        ..values.description = finance.description
        ..values.summ = finance.summ
        ..values.category!.id = finance.category!.id;
      final newFinance = await qCreateFinance.insert();
      newFinance.removePropertyFromBackingMap('user');

      return AppResponse.ok(
          body: newFinance, message: 'Финансовая сводка добавлена');
    } on QueryException catch (e) {
      return AppResponse.serverError(e,
          message: 'Ошибка создания финансовой сводки');
    }
  }

//Поиск по ID финансовой сводки
  @Operation.get('id')
  Future<Response> getFinanceById(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path('id') int id) async {
    try {
      final userId = AppUtils.getIdFromHeader(header);
      final qGetFinance = Query<Finance>(managedContext)
        ..where((x) => x.user!.id).equalTo(userId)
        ..where((x) => x.id).equalTo(id)
        ..join(object: (x) => x.category);

      final note = await qGetFinance.fetchOne();
      if (note == null) {
        return AppResponse.badrequest(message: 'Не найдено финансовых сводок');
      }
      note.removePropertyFromBackingMap('user');

      var response =
          AppResponse.ok(body: note, message: 'Найдена финансовая сводка');
      return response;
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

//редактирование
  @Operation.put('id')
  Future<Response> updateFinance(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path('id') int id,
      @Bind.body() Finance bodyFinance) async {
    try {
      final userId = AppUtils.getIdFromHeader(header);
      final fim = await managedContext.fetchObjectWithID<Finance>(id);
      if (fim == null) {
        return AppResponse.ok(message: 'Финансы не найдены');
      }
      if (fim.user?.id != userId) {
        return AppResponse.ok(message: 'Нельзя редактировать не вашу справку');
      }

      final qUpdateFinance = Query<Finance>(managedContext)
        ..where((x) => x.id).equalTo(id)
        ..values.description = bodyFinance.description ?? fim.description
        ..values.financeName = bodyFinance.financeName ?? fim.financeName
        ..values.summ = bodyFinance.summ ?? fim.summ;
        await qUpdateFinance.update();

      return AppResponse.ok(
         message: 'Финансовая сводка успешно обновлена');
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

//удаление
  @Operation.delete('id')
  Future<Response> deleteFinance(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path('id') int id) async {
    try {
      final userId = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(userId);
      if (user == null) {
        throw AppResponse.badrequest(message: 'Невалидный токен');
      }

      final finance = await managedContext.fetchObjectWithID<Finance>(id);
      if (finance == null) {
        return AppResponse.badrequest(message: 'Не найдено финансовых сводок');
      }

      if (finance.user!.id != userId) {
        final data = {'user': finance.user!.id, 'user': userId};
        return AppResponse.badrequest(
            message: 'Данную сводку не возможно удалить данным юзером');
      }

      final qDeleteFinance = Query<Finance>(managedContext)
        ..where((x) => x.id).equalTo(id);
      await qDeleteFinance.delete();

      return AppResponse.ok(message: 'Сводка была успешно удалена');
    } catch (e) {
      return AppResponse.serverError(e,
          message: 'Ошибка удаления финансовой сводки');
    }
  }

  //Пагинация
  @Operation.get()
  Future<Response> getAllFinance(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      {@Bind.query('str') String str = '',
      @Bind.query('pageLimit') int pageLimit = 20,
      @Bind.query('skipRows') int skipRows = 0}) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final qGetFinance= Query<Finance>(managedContext)
        ..fetchLimit = pageLimit
        ..offset = pageLimit * skipRows
        ..where((x) => x.user!.id).equalTo(id)
        ..where((x) => x.financeName).contains(str, caseSensitive: false)
        ..join(object: (x) => x.user)
        ..join(object: (x) => x.category);
      final List<Finance> finances = await qGetFinance.fetch();
      if (finances.isEmpty) {
        return AppResponse.ok( message: 'Не найдено финансовых справок');
      }

      for (var finance in finances) {
        finance.removePropertyFromBackingMap('user');
      }

      return AppResponse.ok(
          body: finances, message: 'Финансовые справки, созданные данным пользователем');
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }
}
