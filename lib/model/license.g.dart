// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

License _$LicenseFromJson(Map<String, dynamic> json) {
  return License(
    json['id'] as String,
    json['name'] as String,
    json['license_type'] as String,
    json['image'] as int,
    json['image_size'] as int,
    json['pilot'] == null
        ? null
        : Pilot.fromJson(json['pilot'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'license_type': instance.license_type,
      'image': instance.image,
      'image_size': instance.image_size,
      'pilot': instance.pilot?.toJson(),
    };
