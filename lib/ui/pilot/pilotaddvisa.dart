import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plane_app_mobile/model/visa.dart';
import 'package:plane_app_mobile/network/visahandler.dart';
import '../../model/pilot.dart';

class PilotAddVisa extends StatefulWidget {
  Pilot pilot;
  PilotAddVisa(this.pilot);

  @override
  _PilotAddVisa createState() => _PilotAddVisa(pilot);
}

class _PilotAddVisa extends State<PilotAddVisa> {
  File img;
  Pilot pilot;
  String visa_type = 'arrival';
  String image_path = "";

  final _nameController = TextEditingController();

  _PilotAddVisa(this.pilot);

  Future<bool> createVisa() async {
    Map<String, dynamic> req = {
      "name": _nameController.text,
      "visa_type": visa_type,
      "image_size": await img.length()
    };
    print(req.toString());

    var resp = await addVisaHandler(json.encode(req), pilot.id);
    print(resp);
    Visa lic = Visa.fromJson(resp);
    sendVisaImage(lic.id, lic.image.toString(), img);
    //String st = resp.toString();
    //print(st);

    return true;
  }

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
          title: Text("Create visa"),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      createTitle("Name: "),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: _nameController,
                    autofocus: false,
                    //initialValue: 'some password',
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                  ),
                  SizedBox(height: 22.0),
                  Row(
                    children: <Widget>[
                      createTitle("Visa type: "),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: visa_type,
                            elevation: 16,
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                visa_type = newValue;
                              });
                            },
                            items: <String>[
                              'arrival',
                              'temporary worker',
                            ].map<DropdownMenuItem<String>>((String value) {
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
                      createTitle("Visa image: "),
                      RaisedButton(
                        onPressed: () async {
                          final picked = await new ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          img = File(picked.path);
                          setState(() {
                            image_path = "file is choosen";
                          });
                        },
                        child: Text('Choose Image'),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                        child: Text(image_path),
                      )
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: MaterialButton(
                        minWidth: 400,
                        onPressed: () {
                          createVisa();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('Add visa', style: TextStyle(fontSize: 30)),
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
