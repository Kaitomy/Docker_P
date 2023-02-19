import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance.freezed.dart';
part 'finance.g.dart';

@freezed
class Finance with _$Finance {
  const factory Finance(
      {
      required String financeName,
      required String description,
      required DateTime date,
      required int summ,
      required int logicalDel,
      required String category
      }) = _Finance;
  factory Finance.fromJson(Map<String, dynamic> json) => _$FinanceFromJson(json);
}
