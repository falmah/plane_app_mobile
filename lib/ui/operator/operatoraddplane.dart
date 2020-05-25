import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:intl/intl.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/model/plane.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:plane_app_mobile/network/pilothandler.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class OperatorAddPlane extends StatefulWidget {

  Operator operator;
  OperatorAddPlane(this.operator);

  @override
  _OperatorAddPlane createState() => _OperatorAddPlane(operator);
}

class _OperatorAddPlane extends State<OperatorAddPlane> {

  Operator operator;

  final dateFormat = DateFormat("y-M-d");
  String plane_type = 'two-engine';
  String license = "license_1";
  String visa = 'visa_1';
  String plane = "boing 777";
  DateTime deadline;

  List<Plane> planeList = [];
  Future<List<Plane>> planeFuture;
  Future<List<Pilot>> pilotFuture;

/*
  @override
  void initState () {
    pilotFuture = getPilots(operator.id).then();
    super.initState();
  }
*/

  final _nameController = TextEditingController();
  final _prefixController = TextEditingController();
  final _idController = TextEditingController();
  final _locationController = TextEditingController();

  _OperatorAddPlane(this.operator);

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
          title: Text("Add plane"),
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
                  createTitle("Type: "),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: plane_type,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            plane_type = newValue;
                          });
                        },
                        items: <String>['two-engine', 'single engine', 'reactive two-engine', "transport"]
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
                  createTitle("Name: "),
                ],
              ),
              SizedBox(height: 5.0,),
              TextFormField (
                controller: _nameController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Registration prefix: "),
                ],
              ),
              SizedBox(height: 5.0,),
              TextFormField (
                controller: _prefixController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Prefix',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Registration id: "),
                ],
              ),
              SizedBox(height: 5.0,),
              TextFormField (
                controller: _idController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'id',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Row(
                children: <Widget>[
                  createTitle("Current Airport: "),
                ],
              ),
              SizedBox(height: 5.0,),
              TextFormField (
                controller: _locationController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'location',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    minWidth: 400,
                    onPressed: () => {},
                    child: Text('Add plane', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ),
            ],
          ),
        )
          ),
        ),
        backgroundColor: Colors.grey[850],
    ),
    );
  }
}
