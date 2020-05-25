import 'package:plane_app_mobile/model/plane.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

Future<List<Plane>> getPlanes(String id) async {

  String request = 'http://'+ipAddr+':81/operator/plane/' + id + '/all';

  final http.Response response = await http.get(request);
  
  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Plane>((json) => Plane.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get planes');
  }
}