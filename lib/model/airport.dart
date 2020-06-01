import 'package:json_annotation/json_annotation.dart';
import 'city.dart';
part 'airport.g.dart';

@JsonSerializable(explicitToJson: true)
class Airport {
  String type;
  String name;
  double latitude;
  double longitude;
  City city;

  Airport(this.type, this.name, this.latitude, this.longitude, this.city);

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);
}
