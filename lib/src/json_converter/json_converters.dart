/// 参考：
/// https://github.com/mono0926/flutter_firestore_ref

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ks_flutter_commons/ks_flutter_commons.dart';

class PassthroughConverter<T> implements JsonConverter<T, Object?> {
  const PassthroughConverter();

  @override
  T fromJson(Object? json) => json as T;

  @override
  Object? toJson(T object) => object;
}

/// Firestore ドキュメントには FieldValue.serverTimestamp() を、
/// Dart のインスタンスとしては DateTime を与える。
/// タイムスタンプのコンバータ。
class AutoTimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const AutoTimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    return null;
  }

  /// toJson、つまり、書き込みのためにインスタンスを生成してドキュメント化する時は
  /// TimestampConverter のフィールドは FieldValue.serverTimestamp() に自動で置換する。
  @override
  dynamic toJson(DateTime? object) =>
      object == null ? FieldValue.serverTimestamp() : Timestamp.fromDate(object);
}

/// Firestore ドキュメントには FieldValue.serverTimestamp() を、
/// Dart のインスタンスとしては toIso8601String() した文字列を与える
/// タイムスタンプのコンバータ
class AutoTimestampIso8601StringConverter implements JsonConverter<String?, dynamic> {
  const AutoTimestampIso8601StringConverter();

  @override
  String? fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate().toIso8601String();
    }
    return null;
  }

  /// toJson、つまり、書き込みのためにインスタンスを生成してドキュメント化する時は
  /// TimestampConverter のフィールドは FieldValue.serverTimestamp() に自動で置換する。
  @override
  dynamic toJson(String? object) =>
      object == null ? FieldValue.serverTimestamp() : Timestamp.fromDate(DateTime.parse(object));
}

/// 自動で Iso8601String の DateTime を付与するコンバータ。
/// Firestore ODM が Timestamp 型の orderBy に対応していないので使用する。
class AutoDateTimeIso8601StringConverter implements JsonConverter<String?, String> {
  const AutoDateTimeIso8601StringConverter();

  @override
  String? fromJson(String json) => json;

  /// toJson、つまり、書き込みのためにインスタンスを生成してドキュメント化する時は
  /// TimestampConverter のフィールドは FieldValue.serverTimestamp() に自動で置換する。
  @override
  String toJson(String? object) => object ?? DateTime.now().toIso8601String();
}

/// エポック秒で int の値を与えるコンバータ
/// 後から追加すると数が大きくなる表示順序などのフィールド (e.g. order) などに使用する
class AutoSecondsSinceEpochConverter implements JsonConverter<int?, int> {
  const AutoSecondsSinceEpochConverter();

  @override
  int? fromJson(int json) => json;

  /// toJson、つまり、書き込みのためにインスタンスを生成してドキュメント化する時は
  /// 例えば 2022-01-01 12:00:00 のときは、20220101120000 に置換した整数を保存する
  @override
  int toJson(int? object) => object ?? DateTime.now().millisecondsSinceEpoch * 1000;
}

/// デフォルト false で Firestore に書き込む bool 型のためのコンバータ。
class DefaultFalseConverter implements JsonConverter<bool?, dynamic> {
  const DefaultFalseConverter();

  @override
  bool? fromJson(dynamic json) => toBool(json);

  /// toJson、つまり、書き込みのためにインスタンスを生成してドキュメント化する時は
  /// 指定がなければ defaultValue にする。
  @override
  bool toJson(bool? object) => object ?? false;
}

/// デフォルト false で Firestore に書き込む bool 型のためのコンバータ。
class DefaultIntConverter implements JsonConverter<int?, dynamic> {
  const DefaultIntConverter({this.defalutValue = 3});

  final int defalutValue;

  @override
  int? fromJson(dynamic json) {
    if (json is int) {
      return json;
    }
    return defalutValue;
  }

  /// toJson、つまり、書き込みのためにインスタンスを生成してドキュメント化する時は
  /// 指定がなければ defaultValue にする。
  @override
  int toJson(int? object) => object ?? defalutValue;
}
