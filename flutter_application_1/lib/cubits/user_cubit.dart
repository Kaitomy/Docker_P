import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void onLoad(User user) {
    emit(UserData(user));
  }
}

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserData extends UserState {
  late User user;

  UserData(this.user);
}