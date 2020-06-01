import 'package:json_annotation/json_annotation.dart';
import 'city.dart';
import 'user.dart';
part 'pilot.g.dart';

@JsonSerializable(explicitToJson: true)
class Pilot {
  String id;
  bool busy;
  City city;
  User user;

  Pilot(this.id, this.busy, this.city, this.user);

  factory Pilot.fromJson(Map<String, dynamic> json) => _$PilotFromJson(json);

  Map<String, dynamic> toJson() => _$PilotToJson(this);
}
