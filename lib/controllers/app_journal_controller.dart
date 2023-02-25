import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_application_3/model/categories.dart';
import 'package:dart_application_3/model/finance.dart';
import 'package:dart_application_3/model/journal.dart';
import 'package:dart_application_3/utils/app_response.dart';
import 'package:dart_application_3/utils/app_utils.dart';

class JournalController extends ResourceController {
JournalController(this.managedContext);

  final ManagedContext managedContext;

  //Вывод всех
  @Operation.get()
  Future<Response> getAllJournal(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      ) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final qGetJournal = Query<Journal>(managedContext);
       
      final List<Journal> journals = await qGetJournal.fetch();
      if (journals.isEmpty) {
        return AppResponse.ok(message: 'Не найдено финансовых справок');
      }

      return AppResponse.ok(
          body: journals,
          message: 'Вся журнализация данных');
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }


  @Operation.post()
 Future<Response> getDeleteFinance(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      {@Bind.query('str') String str = '',
      @Bind.query('pageLimit') int pageLimit = 20,
      @Bind.query('skipRows') int skipRows = 0}) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final qGetFinance = Query<Finance>(managedContext)
        ..fetchLimit = pageLimit
        ..offset = pageLimit * skipRows
        ..where((x) => x.user!.id).equalTo(id)
        ..where((x) => x.logicalDel).equalTo(1)
        ..where((x) => x.financeName).contains(str, caseSensitive: false)
        ..join(object: (x) => x.user)
        ..join(object: (x) => x.category);
      final List<Finance> finances = await qGetFinance.fetch();
      if (finances.isEmpty) {
        return AppResponse.ok(message: 'Не найдено финансовых справок');
      }

      for (var finance in finances) {

        finance.removePropertyFromBackingMap('user');
      }

      return AppResponse.ok(
          body: finances,
          message: 'Финансовые справки, удаленные данным пользователем');
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

@Operation.put()
  Future<Response> getCategory() async {
    try {
      //final id = AppUtils.getIdFromHeader(header);
      final qGetCategories = Query<Categories>(managedContext);
       
      final List<Categories> categories = await qGetCategories.fetch();
      if (categories.isEmpty) {
        return AppResponse.ok(message: 'Не найдено финансовых справок');
      }

      return AppResponse.ok(
          body: categories,
          message: 'Категории');
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

}
