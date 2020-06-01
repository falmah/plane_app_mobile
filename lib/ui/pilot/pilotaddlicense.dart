import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plane_app_mobile/model/license.dart';
import 'package:plane_app_mobile/network/licensehandler.dart';
import '../../model/pilot.dart';

class PilotAddLicense extends StatefulWidget {

  Pilot pilot;
  PilotAddLicense(this.pilot);

  @override
  _PilotAddLicense createState() => _PilotAddLicense(pilot);
}

class _PilotAddLicense extends State<PilotAddLicense> {

  File img;
  Pilot pilot;
  String license_type = 'sport';
  String image_path = "";

  final _nameController = TextEditingController();

  _PilotAddLicense(this.pilot);

  Future<bool> createLicense() async {
    Map<String, dynamic> req = {
      "name": _nameController.text,
      "license_type": license_type,
      "image_size": await img.length()
    };
    print(req.toString());

    var resp = await addLicenseHandler(json.encode(req), pilot.id);
    print(resp);
    License lic = License.fromJson(resp);
    sendImage(lic.id, lic.image.toString(), img);
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
          title: Text("Create license"),
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
                      createTitle("License type: "),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: license_type,
                            elevation: 16,
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                license_type = newValue;
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
                      createTitle("License image: "),
                      RaisedButton(
                        onPressed: ()async {
                          final picked = await new ImagePicker().getImage(source: ImageSource.gallery);
                          img = File(picked.path);
                          setState(() {
                            image_path = "file is choosen";
                          });
                          },
                        child: Text('Choose Image'),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(7, 0, 0, 0), child: Text(image_path),)
                      
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: MaterialButton(
                        minWidth: 400,
                        onPressed: () {
                          createLicense();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },  
                        child: Text('Add license', style: TextStyle(fontSize: 30)),
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
