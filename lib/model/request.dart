import 'package:json_annotation/json_annotation.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'pilot.dart';
import 'ticket.dart';
import 'plane.dart';
part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class Request {
  String id;
  String status;
  Operator operator;
  Pilot pilot;
  String required_license;
  String required_visa;
  DateTime deadline;
  int price;
  Ticket ticket;
  Plane plane;
  String request_comment;

  Request(
      this.id,
      this.status,
      this.operator,
      this.pilot,
      this.required_license,
      this.required_visa,
      this.deadline,
      this.price,
      this.ticket,
      this.plane,
      this.request_comment);

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
