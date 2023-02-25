// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Finance _$FinanceFromJson(Map<String, dynamic> json) {
  return _Finance.fromJson(json);
}

/// @nodoc
mixin _$Finance {
  int get id => throw _privateConstructorUsedError;
  String get financeName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get summ => throw _privateConstructorUsedError;
  int get logicalDel => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinanceCopyWith<Finance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinanceCopyWith<$Res> {
  factory $FinanceCopyWith(Finance value, $Res Function(Finance) then) =
      _$FinanceCopyWithImpl<$Res, Finance>;
  @useResult
  $Res call(
      {int id,
      String financeName,
      String description,
      DateTime date,
      int summ,
      int logicalDel,
      String category});
}

/// @nodoc
class _$FinanceCopyWithImpl<$Res, $Val extends Finance>
    implements $FinanceCopyWith<$Res> {
  _$FinanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? financeName = null,
    Object? description = null,
    Object? date = null,
    Object? summ = null,
    Object? logicalDel = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      financeName: null == financeName
          ? _value.financeName
          : financeName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      summ: null == summ
          ? _value.summ
          : summ // ignore: cast_nullable_to_non_nullable
              as int,
      logicalDel: null == logicalDel
          ? _value.logicalDel
          : logicalDel // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FinanceCopyWith<$Res> implements $FinanceCopyWith<$Res> {
  factory _$$_FinanceCopyWith(
          _$_Finance value, $Res Function(_$_Finance) then) =
      __$$_FinanceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String financeName,
      String description,
      DateTime date,
      int summ,
      int logicalDel,
      String category});
}

/// @nodoc
class __$$_FinanceCopyWithImpl<$Res>
    extends _$FinanceCopyWithImpl<$Res, _$_Finance>
    implements _$$_FinanceCopyWith<$Res> {
  __$$_FinanceCopyWithImpl(_$_Finance _value, $Res Function(_$_Finance) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? financeName = null,
    Object? description = null,
    Object? date = null,
    Object? summ = null,
    Object? logicalDel = null,
    Object? category = null,
  }) {
    return _then(_$_Finance(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      financeName: null == financeName
          ? _value.financeName
          : financeName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      summ: null == summ
          ? _value.summ
          : summ // ignore: cast_nullable_to_non_nullable
              as int,
      logicalDel: null == logicalDel
          ? _value.logicalDel
          : logicalDel // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Finance implements _Finance {
  const _$_Finance(
      {required this.id,
      required this.financeName,
      required this.description,
      required this.date,
      required this.summ,
      required this.logicalDel,
      required this.category});

  factory _$_Finance.fromJson(Map<String, dynamic> json) =>
      _$$_FinanceFromJson(json);

  @override
  final int id;
  @override
  final String financeName;
  @override
  final String description;
  @override
  final DateTime date;
  @override
  final int summ;
  @override
  final int logicalDel;
  @override
  final String category;

  @override
  String toString() {
    return 'Finance(id: $id, financeName: $financeName, description: $description, date: $date, summ: $summ, logicalDel: $logicalDel, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Finance &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.financeName, financeName) ||
                other.financeName == financeName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.summ, summ) || other.summ == summ) &&
            (identical(other.logicalDel, logicalDel) ||
                other.logicalDel == logicalDel) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, financeName, description,
      date, summ, logicalDel, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FinanceCopyWith<_$_Finance> get copyWith =>
      __$$_FinanceCopyWithImpl<_$_Finance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FinanceToJson(
      this,
    );
  }
}

abstract class _Finance implements Finance {
  const factory _Finance(
      {required final int id,
      required final String financeName,
      required final String description,
      required final DateTime date,
      required final int summ,
      required final int logicalDel,
      required final String category}) = _$_Finance;

  factory _Finance.fromJson(Map<String, dynamic> json) = _$_Finance.fromJson;

  @override
  int get id;
  @override
  String get financeName;
  @override
  String get description;
  @override
  DateTime get date;
  @override
  int get summ;
  @override
  int get logicalDel;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$_FinanceCopyWith<_$_Finance> get copyWith =>
      throw _privateConstructorUsedError;
}
