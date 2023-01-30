import 'dart:async';
import 'package:conduit_core/conduit_core.dart';   

class Migration6 extends Migration { 
  @override
  Future upgrade() async {
   		database.alterColumn("_Finance", "logicalDel", (c) {c.defaultValue = "0";});
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    