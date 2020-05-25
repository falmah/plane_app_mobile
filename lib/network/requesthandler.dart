import 'package:plane_app_mobile/model/request.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

Future<List<Request>> getOperatorRequest(String id) async {

  String request = 'http://'+ipAddr+':81/operator/request/' + id + '/all';

  final http.Response response = await http.get(
    request
  );
  
  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Request>((json) => Request.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get requests');
  }
}





Future<bool> deleteRequestHandler(String req ,String op) async {
  String request = 'http://'+ipAddr+':81/operator/request/' + op + '/delete/'+req;
  final http.Response response = await http.get(
    request,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode != 404) {
    return true;
  } else {
    throw Exception('Failed to login');
  }
}
