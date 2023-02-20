import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/finance.dart';

class FinancesCubit extends Cubit<FinancesState> {
  FinancesCubit() : super(FinancesInitial());

  void onLoad(List<Finance> finances) {
    emit(FinancesList(finances));
  }
}

@immutable
abstract class FinancesState {}

class FinancesInitial extends FinancesState {}

class FinancesList extends FinancesState {
  late List<Finance> finances;

  FinancesList(this.finances);
}