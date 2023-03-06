import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

   

  @override
  State<Welcome> createState() => MyApp();
}

class MyApp extends State<Welcome> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Авторизации',
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





    void signInAnonimous() async {
      try {
        final user = await FirebaseAuth.instance.signInAnonymously();
        print(user.user?.uid);
        const snackBar = SnackBar(
          content: Text('Успешная авторизация под анонимным пользователем'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        print(e);
        const snackBar = SnackBar(
          content: Text('Ошибка'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    void SentEmailLink() async {
      try {
        var emailAuth = _userNameController.text;
        var acs = ActionCodeSettings(
            url: 'http://localhost:1234/#/?email=$emailAuth',
            handleCodeInApp: true,
            androidInstallApp: true);
     var response =  await FirebaseAuth.instance.sendSignInLinkToEmail(email: emailAuth, actionCodeSettings: acs);
        const snackBar = SnackBar(
          content: Text('Ссылка отправлена'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        print(e);
        const snackBar = SnackBar(
          content: Text('Ошибка'),
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
            const Text('Авторизации',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
            DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: const TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                                icon: Icon(IconData(0xf672,
                                    fontFamily: 'MaterialIcons'))),
                            Tab(
                                icon: Icon(IconData(0xf522,
                                    fontFamily: 'MaterialIcons'))),
                          ],
                        ),
                      ),
                      Container(
                          height: 700, //height of TabBarView
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text("              Регистрация",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: TextFormField(
                                      controller: _userNameController2,
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: validateEmail,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Введите email',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordController2,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Введите пароль',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          signUpEmailPassword();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            )),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text("Регистрация",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text("              Авторизация",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 16),
                                      child: TextFormField(
                                        controller: _userNameController,
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: validateEmail,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Введите email',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 16),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Введите пароль',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            signInEmailPassword();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              )),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text("Авторизоваться в системе",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: ElevatedButton(
                                          onPressed: () {
                                        signInAnonimous();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.grey),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              )),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                    "Авторизоваться в системе анонимно",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: ElevatedButton(
                                          onPressed: () {
                                        SentEmailLink();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.lightGreen),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              )),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                    "Отправить ссылку авторизации на Email",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ]),
                                        ),
                                      ),
                                    ),

                                   
                                  ]),
                            ),
                          ]))
                    ])),
          ]),
        ),
      ),
    );
  }
}
