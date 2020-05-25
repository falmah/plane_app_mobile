import 'package:json_annotation/json_annotation.dart';
import 'city.dart';
import 'user.dart';
part 'operator.g.dart';

@JsonSerializable(explicitToJson: true)
class Operator {
  String id;
	String company_name;
  City city;
  User user;

  Operator(this.id, this.company_name, this.city, this.user);

  factory Operator.fromJson(Map<String, dynamic> json) => _$OperatorFromJson(json);

  Map<String, dynamic> toJson() => _$OperatorToJson(this);
}
