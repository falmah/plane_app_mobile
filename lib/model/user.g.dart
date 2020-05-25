// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['surname'] as String,
    json['phone'] as String,
    json['email'] as String,
    json['created_at'] as String,
    json['role'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'phone': instance.phone,
      'email': instance.email,
      'created_at': instance.created_at,
      'role': instance.role,
      'password': instance.password,
    };
