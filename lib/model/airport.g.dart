// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airport _$AirportFromJson(Map<String, dynamic> json) {
  return Airport(
    json['type'] as String,
    json['name'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AirportToJson(Airport instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city?.toJson(),
    };
