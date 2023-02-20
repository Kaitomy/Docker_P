import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/utils/auth_dio_utils.dart';
import 'dart:io';

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
  usernameValidator(String username) {
    if (username.isEmpty) {
      return false;
    } else if (username.length < 2) {
      return false;
    } else if (username.length > 20) {
      return false;
    }
    return true;
  }

  passwordValidator(String password) {
    if (password.isEmpty) {
      return false;
    } else if (password.length < 4) {
      return false;
    } else if (password.length > 20) {
      return false;
    }
    return true;
  }

  emailValidator(String email) {
    if (email.isEmpty) {
      return false;
    } else if (email.length < 4) {
      return false;
    } else if (email.length > 20) {
      return false;
    } else if (!email.contains("@")) {
      return false;
    } else {
      return true;
    }
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
    void signUp() async {
      final AuthDioUtils regist = AuthDioUtils();
      var result = await regist.Register(
        _userNameController2.text,
        _passwordController2.text,
        _emailController2.text,
      );
      String f = result.toString();
      if (f.contains("true") == true) {
        const snackBar = SnackBar(
          content: Text('Register true'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(
          content: Text('Register failed'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    void signIn() async {
      final AuthDioUtils auth = AuthDioUtils();
      var result =
          await auth.Auth(_userNameController.text, _passwordController.text);
      String f = result.toString();
      if (f.contains("true") == true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        const snackBar = SnackBar(
          content: Text('Authorization failed'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      body:
      SingleChildScrollView(
        child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(248, 97, 172, 79)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          SizedBox(height: 20.0),
          const Text('Finance',
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
                        height: 600, //height of TabBarView
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Введите никнейм',
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  child: TextFormField(
                                    controller: _emailController2,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Введите email',
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
                                        if ((usernameValidator(_userNameController2.text) == true) &
                                            (passwordValidator(
                                                    _passwordController2
                                                        .text) ==
                                                true) &
                                            (emailValidator(
                                                    _emailController2.text) ==
                                                true)) {
                                          signUp();
                                        }
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
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Введите никнейм',
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
                                          signIn();
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
                                              Text("Авторизоваться в системе",
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
