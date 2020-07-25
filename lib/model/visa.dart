import 'package:json_annotation/json_annotation.dart';
import 'package:plane_app_mobile/model/pilot.dart';
part 'visa.g.dart';

@JsonSerializable(explicitToJson: true)
class Visa {
  String id;
  String name;
  String visa_type;
  int image;
  int image_size;
  Pilot pilot;

  Visa(this.id, this.name, this.visa_type, this.image, this.image_size,
      this.pilot);

  factory Visa.fromJson(Map<String, dynamic> json) =>
      _$VisaFromJson(json);

  Map<String, dynamic> toJson() => _$VisaToJson(this);
}
