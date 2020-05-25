// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plane _$PlaneFromJson(Map<String, dynamic> json) {
  return Plane(
    json['id'] as String,
    json['name'] as String,
    json['registration_prefix'] as String,
    json['registration_id'] as String,
    json['plane_type'] as String,
    json['current_location'] == null
        ? null
        : Airport.fromJson(json['current_location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaneToJson(Plane instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registration_prefix': instance.registration_prefix,
      'registration_id': instance.registration_id,
      'plane_type': instance.plane_type,
      'current_location': instance.current_location?.toJson(),
    };
