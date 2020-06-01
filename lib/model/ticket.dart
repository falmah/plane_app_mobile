import 'package:json_annotation/json_annotation.dart';
import 'customer.dart';
import 'airport.dart';
part 'ticket.g.dart';

@JsonSerializable(explicitToJson: true)
class Ticket {
  String id;
  Customer customer;
  String status;
  String cargo_type;
  DateTime date_from;
  DateTime date_to;
  String title;
  Airport dest_from;
  Airport dest_to;
  int price;
  String ticket_comment;

  Ticket(
      this.id,
      this.customer,
      this.status,
      this.cargo_type,
      this.date_from,
      this.date_to,
      this.dest_from,
      this.dest_to,
      this.price,
      this.title,
      this.ticket_comment);

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
