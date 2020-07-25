// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visa _$VisaFromJson(Map<String, dynamic> json) {
  return Visa(
    json['id'] as String,
    json['name'] as String,
    json['visa_type'] as String,
    json['image'] as int,
    json['image_size'] as int,
    json['pilot'] == null
        ? null
        : Pilot.fromJson(json['pilot'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VisaToJson(Visa instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'visa_type': instance.visa_type,
      'image': instance.image,
      'image_size': instance.image_size,
      'pilot': instance.pilot?.toJson(),
    };
