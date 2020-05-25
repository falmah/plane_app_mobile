import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:intl/intl.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/model/plane.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:plane_app_mobile/network/pilothandler.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class OperatorAddRequest extends StatefulWidget {

  Operator operator;
  Ticket ticket;
  OperatorAddRequest(this.operator, ticket);

  @override
  _OperatorAddRequest createState() => _OperatorAddRequest(operator, ticket);
}

class _OperatorAddRequest extends State<OperatorAddRequest> {

  Operator operator;
  Ticket ticket;

  final dateFormat = DateFormat("y-M-d");
  String pilot_name = 'Nick pilot';
  String license = "license_1";
  String visa = 'visa_1';
  String plane = "boing 777";
  DateTime deadline;

  List<Plane> planeList = [];
  Future<List<Plane>> planeFuture;
  Future<List<Pilot>> pilotFuture;

  List<String> _generatePlaneList() {
    return new List<String>.generate(planeList.length, (int index) {
      return planeList[index].name;
    });
  }
/*
  @override
  void initState () {
    pilotFuture = getPilots(operator.id).then();
    super.initState();
  }
*/

  final _titleController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _priceController = TextEditingController();

  _OperatorAddRequest(this.operator, this.ticket);

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
                        items: <String>['license_1']
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
                        items: <String>['visa_1']
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
                        items: <String>['boing 777']
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
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    minWidth: 400,
                    onPressed: () => {},
                    child: Text('Create request', style: TextStyle(fontSize: 30)),
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
