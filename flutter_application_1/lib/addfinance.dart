import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/auth_dio_utils.dart';

class AddFinance extends StatefulWidget {
  const AddFinance({Key? key}) : super(key: key);

  @override
  State<AddFinance> createState() => _AddFinanceState();
}

class _AddFinanceState extends State<AddFinance> {
  var jsonList;
  late int category;

  @override
  void initState() {
    getCateg();
  }

  final List<DropdownMenuItem<String>> list = [];
  List<DropdownMenuItem<String>> get dropdownItems {
    return list;
  }

  void getCateg() async {
    try {
      final AuthDioUtils listFinance = AuthDioUtils();
      var response = await listFinance.dio.put("/journal");

      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data;
          for (var i = 0; i < jsonList['data'].length; i++) {
            list.add(DropdownMenuItem(
                value: jsonList['data'][i]['id'].toString(),
                child: Text(jsonList['data'][i]['categoryName'].toString())));
          }
        });

//final dropdown = DropdownButton(items: _createList());

      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void addFinanceNew() async {
    try{
    final AuthDioUtils listFinance = AuthDioUtils();
    var response = await listFinance.dio.post("/finance", data: {
      'financeName': _nameController.text,
      'description': _descController.text,
      'summ': int.parse(_summController.text),
      'category': {'id': int.parse(category.toString())}
    });

    if (response.statusCode == 200) {
      const snackBar = SnackBar(
        content: Text('Сводка добавлена'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text('Ошибка добавления'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
     } catch(e){
      print(e);

     }
  }

  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _summController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          child:SizedBox(
            height: 750,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 120),
            decoration:
                const BoxDecoration(color: Color.fromARGB(248, 97, 172, 79)),
            child: Container(
              height: double.infinity, //height of TabBarView
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text("Добавление новой финансовой сводки",
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Введите название',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        obscureText: false,
                        controller: _descController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Введите описание',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _summController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Введите сумму',
                        ),
                      ),
                      
                    ),
                    Padding(
              padding: EdgeInsets.only(top: 12),
         //     child: RoundedButton("Continue with Email or Phone", color: Color(0xFFCDFDFE)),
            ),
                    DropdownButtonFormField(
                      
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.arrow_drop_down_outlined),
                        hintText: 'Выберите тип',
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.yellow),
                      ),
                      items: dropdownItems,
                      onChanged: (value) {
                        category = int.parse(value.toString());
                        print(category);
                      },
                    ),
                    Padding(
              padding: EdgeInsets.only(top: 12),
         //     child: RoundedButton("Continue with Email or Phone", color: Color(0xFFCDFDFE)),
            ),
                    SizedBox(
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: ElevatedButton(
                          onPressed: () {
                            addFinanceNew();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              )),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Добавить справку",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        )
        )
            );//crfa



  }
}
