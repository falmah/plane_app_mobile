// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pilot _$PilotFromJson(Map<String, dynamic> json) {
  return Pilot(
    json['id'] as String,
    json['busy'] as bool,
    json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PilotToJson(Pilot instance) => <String, dynamic>{
      'id': instance.id,
      'busy': instance.busy,
      'city': instance.city?.toJson(),
      'user': instance.user?.toJson(),
    };
