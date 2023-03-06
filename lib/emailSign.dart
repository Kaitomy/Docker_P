import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:io';

import 'package:path/path.dart';

class EmailAuth extends StatefulWidget {
  const EmailAuth({Key? key}) : super(key: key);

  @override
  State<EmailAuth> createState() => MyApp();
}
String email = '';

class MyApp extends State<EmailAuth> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
  void initState() {
    
    setState(() {
     
      email =  window.location.href.substring(36,window.location.href.length);
    });
  }
  
  

  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController2 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  TextEditingController _emailController2 = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isNotEmpty && !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    void searchEmail() async {
      String address =
          window.location.href.substring(36, window.location.href.length);
      print(address);
    }

    void signUpEmailPassword() async {
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userNameController2.text,
            password: _passwordController2.text);
        const snackBar = SnackBar(
          content: Text('Успешная регистрация'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        const snackBar = SnackBar(
          content: Text('Ошибка ввода данных'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    }

    void signInEmailPassword() async {
      try {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _userNameController.text,
            password: _passwordController.text);
        print(user.user?.email);
        print(user.user?.uid);
        const snackBar = SnackBar(
          content: Text('Успешная авторизация'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        const snackBar = SnackBar(
          content: Text('Ошибка ввода данных'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

  

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(248, 97, 172, 79)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            SizedBox(height: 20.0),
            //     String r =
            Text('Успешная авторизация пользователя $email по Email',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
           
          ]),
        ),
      ),
    );
  }
}
