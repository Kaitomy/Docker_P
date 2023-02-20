import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/welcome.dart';
import 'package:flutter_application_1/finance.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<Home> {
  int currentIndex = 0;

  final List<Widget> pages = [
    Welcome(),
    FinancePage(),
    FinancePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
          BottomNavigationBarItem(
              icon: Icon(Icons.create_outlined), label: "Финансы"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Профиль")
        ],
        currentIndex: currentIndex,
        onTap: ((value) {
          setState(() {
            currentIndex = value;
          });
        }),
      ),
      body: pages[currentIndex],
    );
  }
}

