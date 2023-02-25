import 'package:conduit/conduit.dart';
import 'package:dart_application_3/model/finance.dart';

class Journal extends ManagedObject<_Journal> implements _Journal {
  Map<String, dynamic> toJson() => asMap();
}

class _Journal {
  @primaryKey
  int? id;
  @Column()
  String? action;
  @Column(defaultValue: 'now()')
  DateTime? date;
  @Relate(#journalList, isRequired: true, onDelete: DeleteRule.cascade)
  Finance? finance;
}
