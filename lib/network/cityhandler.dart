import 'package:plane_app_mobile/model/city.dart';
import 'dart:async';
import 'const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<City>> getCities() async {
  final http.Response response =
      await http.get('http://' + ipAddr + ':81/cities');

  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<City>((json) => City.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get cities');
  }
}

//List<City> parseCities(String responseBody) {}
