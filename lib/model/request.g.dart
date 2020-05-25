// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) {
  return Request(
    json['id'] as String,
    json['status'] as String,
    json['operator'] == null
        ? null
        : Operator.fromJson(json['operator'] as Map<String, dynamic>),
    json['pilot'] == null
        ? null
        : Pilot.fromJson(json['pilot'] as Map<String, dynamic>),
    json['required_license'] as String,
    json['required_visa'] as String,
    json['deadline'] == null
        ? null
        : DateTime.parse(json['deadline'] as String),
    json['price'] as int,
    json['ticket'] == null
        ? null
        : Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
    json['plane'] == null
        ? null
        : Plane.fromJson(json['plane'] as Map<String, dynamic>),
    json['request_comment'] as String,
  );
}

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'operator': instance.operator?.toJson(),
      'pilot': instance.pilot?.toJson(),
      'required_license': instance.required_license,
      'required_visa': instance.required_visa,
      'deadline': instance.deadline?.toIso8601String(),
      'price': instance.price,
      'ticket': instance.ticket?.toJson(),
      'plane': instance.plane?.toJson(),
      'request_comment': instance.request_comment,
    };
