import 'dart:typed_data';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plane_app_mobile/model/visa.dart';
import 'const.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

Future<List<Visa>> getPilotVisa(String id) async {
  String request = 'http://' + ipAddr + ':81/pilot/visa/' + id + '/all';
  print(request);
  final http.Response response = await http.get(request);

  if (response.statusCode != 404) {
    print(response.body);
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Visa>((json) => Visa.fromJson(json)).toList();
    //return compute(parseCities, response.body);
  } else {
    throw Exception('Failed to get requests');
  }
}

Future<Map> addVisaHandler(String req_body, String id) async {
  String request = 'http://' + ipAddr + ':81/pilot/visa/' + id + '/create';
  print(request);

  final http.Response response = await http.post(
    request,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: req_body,
  );

  if (response.statusCode != 404) {
    print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to create plane');
  }
}

void sendVisaImage(String license, String oid, File img) async {
  String uri = 'http://' +
      ipAddr +
      ':81/pilot/visa/' +
      license +
      '/create/img/' +
      oid;
  print(uri);
  var stream = new http.ByteStream(DelegatingStream.typed(img.openRead()));
  var length = await img.length();

  var request = new http.MultipartRequest("POST", Uri.parse(uri));
  var multipartFile = new http.MultipartFile('fileupload', stream, length,
      filename: basename(img.path));

  request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}

Future<Uint8List> receiveVisaImage(String license, String oid) async {
  String uri =
      'http://' + ipAddr + ':81/pilot/license/' + license + '/get/img/' + oid;
  print(uri);
  var response = await http.get(uri);

  if (response.statusCode != 404) {
    print(response.bodyBytes.length);
    return response.bodyBytes;
  } else {
    throw Exception('Failed to create plane');
  }
}

/*
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
*/
