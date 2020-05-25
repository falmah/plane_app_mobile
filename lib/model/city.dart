import 'package:json_annotation/json_annotation.dart';
import 'country.dart';
part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
	String name;
	double latitude;
  double longitude;
  Country country;

  City(this.name, this.latitude, this.longitude, this.country);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}