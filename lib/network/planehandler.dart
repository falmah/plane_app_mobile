import 'package:plane_app_mobile/model/plane.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

Future<List<Plane>> getPlanesHandler(String id) async {
  String request = 'http://' + ipAddr + ':81/operator/plane/' + id + '/all';
  print(request);

  final http.Response response = await http.get(request);

  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    var tmp = parsed.map<Plane>((json) => Plane.fromJson(json)).toList();
    return tmp;
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get planes');
  }
}

Future<Plane> addPlaneHandler(String req_body, String id) async {
  String request = 'http://' + ipAddr + ':81/operator/plane/' + id + '/create';

  final http.Response response = await http.post(
    request,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: req_body,
  );

  if (response.statusCode != 404) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to create plane');
  }
}

Future<Map> updatePlaneHandler(
    String req_body, String plane, String ope) async {
  String request =
      'http://' + ipAddr + ':81/operator/plane/' + ope + '/update/' + plane;
  final http.Response response = await http.post(
    request,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: req_body,
  );
  if (response.statusCode != 404) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to update ticket');
  }
}
