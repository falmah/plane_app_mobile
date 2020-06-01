import 'package:plane_app_mobile/model/request.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

Future<List<Request>> getProposalsHandler(String id) async {
  String request = 'http://' + ipAddr + ':81/customer/proposal/' + id + '/all';
  final http.Response response = await http.get(request);

  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Request>((json) => Request.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get requests');
  }
}
void customerChangeProposalStatus(String customer, String req, String status) async {
  String request = 'http://' +
      ipAddr +
      ':81/customer/proposal/' +
      customer +
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
