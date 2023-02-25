
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

class CustomSearchDelegate extends SearchDelegate{
  var jsonList2;
 void getData2() async {
    try{

   final AuthDioUtils listFinance = AuthDioUtils();
      var response =await listFinance.dio.get("/finance", queryParameters: {"str": query, "pageLimit": 100});
      
     if(response.statusCode == 200) {
      
        jsonList2 = response.data;
      
     
     }else{
      print(response.statusCode);
     }
     } catch(e){
      print(e);
     }
  }
 
 
  List<String> searchTerms = [
    "test",
    "search"
  ];
  @override
  List<Widget>? buildActions (BuildContext context){
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
         icon: Icon(Icons.clear),
         ),
    ];
  }
  @override
  Widget? buildLeading(BuildContext context){
    return IconButton(
      onPressed: () {
        close(context, null);
      },
     icon: Icon(Icons.arrow_back),
    );
  }
  @override
  Widget buildResults(BuildContext context){
    getData2();
      return ListView.builder(
          itemCount: jsonList2 == null ? 0 : jsonList2['data'].length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text(jsonList2['data'][index]['financeName'].toString()),
              subtitle: Text(jsonList2['data'][index]['description'].toString()),
              
            ));
          });
    }
  

    @override
    Widget buildSuggestions(BuildContext context){
      getData2();
      return ListView.builder(
          itemCount: jsonList2 == null ? 0 : jsonList2['data'].length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text(jsonList2['data'][index]['financeName'].toString()),
              subtitle: Text(jsonList2['data'][index]['description'].toString()),
              
            ));
          });
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
  
    void getDataFilter() async {
    try{

   final AuthDioUtils listFinance = AuthDioUtils();
      var response =await listFinance.dio.post("/journal");
      
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
  void getDataFilter2() async {
    try{

   final AuthDioUtils listFinance = AuthDioUtils();
      var response =await listFinance.dio.post("/journal");
      
     if(response.statusCode == 200) {
      
        jsonList = response.data;
      
     
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
          'Мои сводки',
          style: TextStyle(color: Colors.white),  
        ),
        actions: [
          
           IconButton(
            icon: const Icon(Icons.assignment_turned_in_outlined),
            onPressed: ( ) {
              getData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            onPressed: () {
              getDataFilter();
            },
          ),
          IconButton(
            onPressed: ( ) {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList['data'].length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text(jsonList['data'][index]['financeName'].toString()),
              subtitle: Text(jsonList['data'][index]['description'].toString()),
              trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                         onPressed: () {
                          
                          String id = jsonList['data'][index]['id'].toString();
                          int logicalDel = jsonList['data'][index]['logicalDel'];
              AuthDioUtils().deleteFinance(id,logicalDel);
              getData();
                              }, icon:const Icon(Icons.delete_outlined),
            )])
            ));
          }),
    );
  }
}