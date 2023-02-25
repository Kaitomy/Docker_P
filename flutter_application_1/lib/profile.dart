import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/auth_dio_utils.dart';
import 'package:flutter_application_1/welcome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/user_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();

  @override
  void initState() {
    AuthDioUtils()
        .getUser()
        .then((value) => context.read<UserCubit>().onLoad(value));
    super.initState();
  }
 void refreshProfile() async {
      final AuthDioUtils ref = AuthDioUtils();
      var result =
          await ref.changeProfile(_userNameController.text, _emailController.text,_oldPasswordController.text,_newPasswordController.text);
      String f = result.toString();
      if (f.contains("true") == true) {
        const snackBar = SnackBar(
          content: Text('Изменение успешно'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      } else {
        const snackBar = SnackBar(
          content: Text('Ошибка изменения'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.green,
          title: Text(
            'Мой профиль',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },
            ),
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserData) {
                  _userNameController.text = (state as UserData).user.userName;
                  _emailController.text = (state as UserData).user.email;
                }
                return Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _userNameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Мой логин',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Мой email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        obscureText: true,
                        controller: _oldPasswordController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Введите старый пароль',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        obscureText: true,
                        controller: _newPasswordController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Введите новый пароль',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: ElevatedButton(
                          onPressed: () {
                     refreshProfile();
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
                                Text("Изменить профиль",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ));
              },
            ),
            
          ],
        ));
  }
}
