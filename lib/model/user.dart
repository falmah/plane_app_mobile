import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {

  User(this.name, this.surname, this.phone, 
        this.email, this.created_at, this.role, this.password);

	String name;
	String surname;
	String phone;
	String email;
	String created_at;
	String role;
	String password;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}