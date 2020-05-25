// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return Ticket(
    json['id'] as String,
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    json['status'] as String,
    json['cargo_type'] as String,
    json['date_from'] == null
        ? null
        : DateTime.parse(json['date_from'] as String),
    json['date_to'] == null ? null : DateTime.parse(json['date_to'] as String),
    json['dest_from'] == null
        ? null
        : Airport.fromJson(json['dest_from'] as Map<String, dynamic>),
    json['dest_to'] == null
        ? null
        : Airport.fromJson(json['dest_to'] as Map<String, dynamic>),
    json['price'] as int,
    json['title'] as String,
    json['ticket_comment'] as String,
  );
}

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer?.toJson(),
      'status': instance.status,
      'cargo_type': instance.cargo_type,
      'date_from': instance.date_from?.toIso8601String(),
      'date_to': instance.date_to?.toIso8601String(),
      'title': instance.title,
      'dest_from': instance.dest_from?.toJson(),
      'dest_to': instance.dest_to?.toJson(),
      'price': instance.price,
      'ticket_comment': instance.ticket_comment,
    };
