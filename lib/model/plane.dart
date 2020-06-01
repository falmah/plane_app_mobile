import 'dart:async';
import 'package:json_annotation/json_annotation.dart';
import 'package:plane_app_mobile/model/airport.dart';
import 'package:plane_app_mobile/model/operator.dart';
part 'plane.g.dart';

@JsonSerializable(explicitToJson: true)
class Plane {
  String id;
  String name;
  String registration_prefix;
  String registration_id;
  String plane_type;
  Airport current_location;

  Plane(this.id, this.name, this.registration_prefix, this.registration_id,
      this.plane_type, this.current_location);

  factory Plane.fromJson(Map<String, dynamic> json) => _$PlaneFromJson(json);

  Map<String, dynamic> toJson() => _$PlaneToJson(this);
}
