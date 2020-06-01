import 'package:plane_app_mobile/model/request.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

Future<List<Request>> getOperatorRequest(String id) async {
  String request = 'http://' + ipAddr + ':81/operator/request/' + id + '/all';
  final http.Response response = await http.get(request);

  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Request>((json) => Request.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get requests');
  }
}

Future<List<Request>> getPilotRequests(String id) async {
  String request = 'http://' + ipAddr + ':81/pilot/request/' + id + '/all';
  final http.Response response = await http.get(request);

  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Request>((json) => Request.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get requests');
  }
}

Future<Request> addRequestHandler(String req_body, String id) async {
  String request =
      'http://' + ipAddr + ':81/operator/request/' + id + '/create';

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
    throw Exception('Failed to create request');
  }
}

Future<Request> updateRequestHandler(
    String req_body, String operator, String req) async {
  String request = 'http://' +
      ipAddr +
      ':81/operator/request/' +
      operator +
      '/update/' +
      req;

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
    throw Exception('Failed to create request');
  }
}

Future<bool> deleteRequestHandler(String req, String op) async {
  String request =
      'http://' + ipAddr + ':81/operator/request/' + op + '/delete/' + req;
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

void pilotChangeRequestStatus(String pilot, String req, String status) async {
  String request = 'http://' +
      ipAddr +
      ':81/pilot/request/' +
      pilot +
      '/status/' +
      req +
      '/' +
      status;
  final http.Response response = await http.get(
    request,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 404) {
    throw Exception('Failed to login');
  }
}
