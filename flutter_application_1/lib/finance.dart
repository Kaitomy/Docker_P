
import 'dart:convert';
  
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/finance.dart';
import 'package:flutter_application_1/utils/auth_dio_utils.dart';
  
void main() {
  runApp(const FinancePage());
}
  
class FinancePage extends StatelessWidget {
  const FinancePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}
  
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  
class _MyHomePageState extends State<MyHomePage> {
var jsonList;
  @override
  void initState() {
    getData();
  }
  
  void getData() async {
    try{

   final AuthDioUtils listFinance = AuthDioUtils();
      var response =await listFinance.dio.get("/finance");
      
     if(response.statusCode == 200) {
      setState(() {
        jsonList = response.data;
      
      });
     }else{
      print(response.statusCode);
     }
     } catch(e){
      print(e);
     }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Мои финансовые сводки',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList['data'].length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text(jsonList['data'][index]['financeName'].toString()),
              subtitle: Text(jsonList['data'][index]['description'].toString()),
              
            ));
          }),
    );
  }
}