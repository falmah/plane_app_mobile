import 'package:plane_app_mobile/model/pilot.dart';
import 'dart:async';
import 'dart:convert';
import 'const.dart';
import 'package:http/http.dart' as http;

Future<List<Pilot>> getPilots(String id) async {

  String request = 'http://'+ipAddr+':81/operator/pilot/' + id + '/all';

  final http.Response response = await http.get(request);
  
  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Pilot>((json) => Pilot.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get cities');
  }
}