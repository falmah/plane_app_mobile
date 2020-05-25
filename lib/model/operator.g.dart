// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Operator _$OperatorFromJson(Map<String, dynamic> json) {
  return Operator(
    json['id'] as String,
    json['company_name'] as String,
    json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OperatorToJson(Operator instance) => <String, dynamic>{
      'id': instance.id,
      'company_name': instance.company_name,
      'city': instance.city?.toJson(),
      'user': instance.user?.toJson(),
    };
