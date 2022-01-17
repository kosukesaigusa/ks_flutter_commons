/// 参考：
/// https://github.com/mono0926/flutter_firestore_ref

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class PassthroughConverter<T> implements JsonConverter<T, Object?> {
  const PassthroughConverter();

  @override
  T fromJson(Object? json) => json as T;

  @override
  Object? toJson(T object) => object;
}

class AutoDateTimeStringConverter implements JsonConverter<String?, dynamic> {
  const AutoDateTimeStringConverter();

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
