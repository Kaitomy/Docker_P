// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Finance _$$_FinanceFromJson(Map<String, dynamic> json) => _$_Finance(
      financeName: json['financeName'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      summ: json['summ'] as int,
      logicalDel: json['logicalDel'] as int,
      category: json['category'] as String,
    );

Map<String, dynamic> _$$_FinanceToJson(_$_Finance instance) =>
    <String, dynamic>{
      'financeName': instance.financeName,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'summ': instance.summ,
      'logicalDel': instance.logicalDel,
      'category': instance.category,
    };
