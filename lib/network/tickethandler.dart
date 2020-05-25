import 'package:plane_app_mobile/model/ticket.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

Future<List<Ticket>> getTickets(String id) async {

  String request = 'http://'+ipAddr+':81/customer/ticket/' + id + '/all';

  final http.Response response = await http.get(
    request
  );
  
  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Ticket>((json) => Ticket.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get cities');
  }
}

Future<List<Ticket>> getTicketsOperator(String id) async {

  String request = 'http://'+ipAddr+':81/operator/ticket/' + id + '/all';

  final http.Response response = await http.get(
    request
  );
  
  if (response.statusCode != 404) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Ticket>((json) => Ticket.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get cities');
  }
}

Future<Map> addTicketHandler(String req_body, String id) async {
  String request = 'http://'+ipAddr+':81/customer/ticket/' + id + '/create';
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
    throw Exception('Failed to login');
  }
}

Future<Map> updateTicketHandler(String req_body, String ticket ,String cus) async {
  String request = 'http://'+ipAddr+':81/customer/ticket/' + cus + '/update/'+ticket;
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
    throw Exception('Failed to login');
  }
}

Future<bool> deleteTicketHandler(String ticket ,String cus) async {
  String request = 'http://'+ipAddr+':81/customer/ticket/' + cus + '/delete/'+ticket;
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