import 'package:plane_app_mobile/model/user.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'dart:async';
import 'dart:convert';
import 'const.dart';
import 'package:http/http.dart' as http;

Future<Map> loginHandler(String email, String password) async {
  final http.Response response = await http.post(
    'http://' + ipAddr + ':81/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode != 404) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map> registerHandler(String req_body) async {
  final http.Response response = await http.post(
    'http://' + ipAddr + ':81/register',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: req_body,
  );
  if (response.statusCode != 404) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
