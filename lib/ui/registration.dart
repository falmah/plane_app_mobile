import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/global.dart';
import 'package:plane_app_mobile/ui/customer/customermain.dart';
import 'package:plane_app_mobile/ui/operator/operatormain.dart';
import 'package:plane_app_mobile/ui/pilot/pilotmain.dart';
import 'package:plane_app_mobile/network/loginhandler.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {

  String dropdownValue = 'customer';
  static String city;
  bool _isOperator = false;
  bool _isOperatorPilot = false;

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _companyNameController = TextEditingController();

  void register () async {
    Map<String, dynamic> req = {
      "name": _nameController.text,
      "surname": _surnameController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "password": _passwordController.text,
      "role": dropdownValue,
    };

    if(_isOperatorPilot) {
      req["city"] = city;
    }

    if(_isOperator) {
      req["company_name"] = _companyNameController.text;
    }

    var resp = await registerHandler(json.encode(req));
    switch (resp["user"]["role"] as String) {
      case "customer": {
        Customer c = Customer.fromJson(resp);
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CustomerMainPage(c)));
      } break;
      case "operator": {
        Operator o = Operator.fromJson(resp);
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OperatorMainPage(o)));
      } break;
      case "pilot": {
        Pilot p = Pilot.fromJson(resp);
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PilotMainPage(p)));
      } break;
      default:
    }
    print(resp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "registrationWidget",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.grey,
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[850],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 18.0),
              Center(child:Text(
                  'Registration',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 22.0),
              Text(
                'Name:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField (
                controller: _nameController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Text (
                'Surname:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField (
                controller: _surnameController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Surname',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Text (
                'Email:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField (
                controller: _emailController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Text (
                'Phone number:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField (
                controller: _phoneController,
                autofocus: false,
                keyboardType: TextInputType.number,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration (
                  hintText: 'Phone',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Text (
                'Password:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField (
                controller: _passwordController,
                autofocus: false,
                //initialValue: 'some password',
                obscureText: false,
                decoration: InputDecoration (
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 22.0),
              Text (
                'Role:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    switch (newValue) {
                      case "customer": {
                        _isOperator = false;
                        _isOperatorPilot = false;
                      } break;
                      case "operator": {
                        _isOperator = true;
                        _isOperatorPilot = true;
                      } break;
                      case "pilot": {
                        _isOperator = false;
                        _isOperatorPilot = true;
                      }break;
                    }
                    dropdownValue = newValue;
                  });
                },
                items: <String>['customer', 'operator', 'pilot']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 18.0),
              Visibility (
                visible: _isOperatorPilot,
                child: Text (
                  'City:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Visibility (
                visible: _isOperatorPilot,
                child: DropdownButton<String>(
                  value: city,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      city = newValue;
                    });
                  },
                  items: cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                ),
              ),
              SizedBox(height: 18.0),
              Visibility (
                visible: _isOperator,
                child: Text (
                  'Company name:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Visibility (
                visible: _isOperator,
                child:  TextFormField (
                  controller: _companyNameController,
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration (
                    hintText: 'Company name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () {
                    register();
                  },
                  padding: EdgeInsets.all(12),
                  color: Colors.grey,
                  child: Text('Register', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}