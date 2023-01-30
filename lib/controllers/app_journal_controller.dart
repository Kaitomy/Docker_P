import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_application_3/model/journal.dart';
import 'package:dart_application_3/utils/app_response.dart';
import 'package:dart_application_3/utils/app_utils.dart';

class JournalController extends ResourceController {
JournalController(this.managedContext);

  final ManagedContext managedContext;
//Поиск по определенной сводке
  // @Operation.get('id')
  // Future<Response> getFinanceById(
  //     @Bind.header(HttpHeaders.authorizationHeader) String header,
  //     @Bind.path('id') int id) async {
  //   try {
  //     final userId = AppUtils.getIdFromHeader(header);
  //     final qGetFinance = Query<Finance>(managedContext)
  //       ..where((x) => x.user!.id).equalTo(userId)
  //       ..where((x) => x.id).equalTo(id)
  //       ..join(object: (x) => x.category);

  //     final note = await qGetFinance.fetchOne();
  //     if (note == null) {
  //       return AppResponse.badrequest(message: 'Не найдено финансовых сводок');
  //     }
  //     note.removePropertyFromBackingMap('user');

  //     var response =
  //         AppResponse.ok(body: note, message: 'Найдена финансовая сводка');
  //     return response;
  //   } catch (e) {
  //     return AppResponse.serverError(e);
  //   }
  // }

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
}
