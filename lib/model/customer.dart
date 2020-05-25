import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
part 'customer.g.dart';

@JsonSerializable(explicitToJson: true)
class Customer {
  String id;
  User user;

  Customer(this.id, this.user);

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}