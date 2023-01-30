import 'package:conduit/conduit.dart';
import 'package:dart_application_3/model/categories.dart';
import 'package:dart_application_3/model/journal.dart';
import 'package:dart_application_3/model/user.dart';

class Finance extends ManagedObject<_Finance> implements _Finance {
  Map<String, dynamic> toJson() => asMap();
}

class _Finance {
  @primaryKey
  int? id;
   @Column()
  String? financeName;
   @Column()
  String? description;
   @Column(defaultValue: 'now()')
  DateTime? date;
   @Column()
  int? summ;
  @Column(nullable: true)
  int? logicalDel;
  @Relate(#financesList,isRequired: true,onDelete: DeleteRule.cascade)
  Categories? category;
  @Relate(#financesList,isRequired: true,onDelete: DeleteRule.cascade)
  User? user;

  ManagedSet<Journal>? journalList;
}
