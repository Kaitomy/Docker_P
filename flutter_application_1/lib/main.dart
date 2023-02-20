import 'package:flutter/material.dart';
import 'package:flutter_application_1/welcome.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences? sharedPreferences;
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: PageView(
        children: const [
          Welcome()
         
        ]
      )
    );
  }
}