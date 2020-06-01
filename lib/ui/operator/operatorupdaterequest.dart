import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:intl/intl.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/model/plane.dart';
import 'package:plane_app_mobile/model/request.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:plane_app_mobile/network/requesthandler.dart';

class OperatorUpdateRequest extends StatefulWidget {

  Operator operator;
  Request request;
  OperatorUpdateRequest(this.operator, this.request);

  @override
  _OperatorUpdateRequest createState() => _OperatorUpdateRequest(operator, this.request);
}

class _OperatorUpdateRequest extends State<OperatorUpdateRequest> {

  Operator operator;
  Request request;

  final dateFormat = DateFormat("yyyy-MM-dd");

  String pilot_name = 'Nick pilot';
  String license = "sport";
  String visa = 'temporary worker';
  String plane = "Learjet 23";

  List<Plane> planeList = [];
  Future<List<Plane>> planeFuture;
  Future<List<Pilot>> pilotFuture;

  Future<bool> updateRequest() async {
    Map<String, dynamic> req = {
      "status" : request.status,
      "pilot": pilot_name.split(" ")[0],
      "price": int.parse(_priceController.text),
      "required_license": license,
      "required_visa": visa,
      "deadline": deadlineController.text,
      "request_comment": _commentController.text,
      "ticket_id": request.ticket.id,
      "plane": plane
    };
    print(req.toString());

    var resp = await updateRequestHandler(json.encode(req), operator.id, request.id);
    String st = resp.toString();
    print(st);

    return true;
  }

  _OperatorUpdateRequest(this.operator, this.request) {
    license = request.required_license;
    visa = request.required_visa;
    plane = request.plane.name;
    _priceController.text = request.price.toString();
    deadlineController.text = dateFormat.format(request.deadline);
    _commentController.text = request.request_comment;
  }

/*
  @override
  void initState () {
    pilotFuture = getPilots(operator.id).then();
    super.initState();
  }
*/

  final _priceController = TextEditingController();
  final deadlineController = TextEditingController();
  final _commentController = TextEditingController();

  Text createTitle(String str) {
    return Text(str, style: TextStyle(fontSize: 20));
  }

  Text createInfo(String str) {
    return Text(str, style: TextStyle(fontSize: 20));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "mainWidget",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.grey,
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Create request"),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container (
            height: MediaQuery
              .of(context)
              .size
              .height,
          child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  createTitle("Pilot: "),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: pilot_name,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            pilot_name = newValue;
                          });
                        },
                        items: <String>['Nick pilot']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Required license: "),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: license,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            license = newValue;
                          });
                        },
                        items: <String>['sport', 'recreational', 'private', 'commersial', 'flight instructor', 'airline transport']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Required visa: "),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: visa,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            visa = newValue;
                          });
                        },
                        items: <String>['temporary worker', 'arrival']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Deadline: "),
                ],
              ),
              SizedBox(height: 5.0),
              DateTimeField(
                controller: deadlineController,
                format: dateFormat,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Price: "),
                ],
              ),
              SizedBox(height: 5.0),
              TextFormField (
                keyboardType: TextInputType.number,
                controller: _priceController,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'price',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Plane: "),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: plane,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            plane = newValue;
                          });
                        },
                        items: <String>['Learjet 23', 'Cirrus SR22', "Gulfstream G500", 'AH-225']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Comment: "),
                ],
              ),
              SizedBox(height: 5.0),
              TextFormField (
                controller: _commentController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Comment',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    minWidth: 400,
                    onPressed: () {
                      updateRequest();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Update request', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ),
            ],
          ),
        ),
          ),
        ),
        backgroundColor: Colors.grey[850],
    ),
    );
  }
}
