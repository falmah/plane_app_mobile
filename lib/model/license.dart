import 'package:json_annotation/json_annotation.dart';
import 'package:plane_app_mobile/model/pilot.dart';
part 'license.g.dart';

@JsonSerializable(explicitToJson: true)
class License {
  String id;
  String name;
  String license_type;
  int image;
  int image_size;
  Pilot pilot;

  License(this.id, this.name, this.license_type, this.image, this.image_size,
      this.pilot);

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}
