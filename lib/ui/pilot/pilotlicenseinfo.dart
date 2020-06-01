import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/license.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:image/image.dart' as Im;
import 'package:plane_app_mobile/model/plane.dart';
import 'package:plane_app_mobile/network/const.dart';
import 'package:plane_app_mobile/network/licensehandler.dart';
import 'dart:io';

class PilotPlaneInfo extends StatefulWidget {

  Pilot pilot;
  License license;
  PilotPlaneInfo(this.pilot, this.license);

  @override
  _PilotPlaneInfo createState() => _PilotPlaneInfo(pilot, license);
}

class _PilotPlaneInfo extends State<PilotPlaneInfo> {

  Pilot pilot;
  License license;
  File img;

  _PilotPlaneInfo(this.pilot, this.license);

  Text createTitle(String str) {
    return Text(str, style: TextStyle(fontSize: 30));
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
          title: Text("License info"),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Uint8List>(
            future: receiveImage(license.id, license.image.toString()),
            builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              //Image tmp = Im.copyResize(snapshot.data, width:800);
          List<Widget> children;
          if (snapshot.hasData) {
            //Im.Image tmp = Im.decodeImage(snapshot.data);
            //var list = Im.encodePng(Im.copyResize(tmp, width:200, height: 200));
            children = <Widget>[
                createTitle(license.name),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("license type: "),
                    createInfo(license.license_type), 
                  ],
                ),
                Divider(),
                Image.network("http://"+ipAddr+":81/pilot/license/"+ license.id + '/get/img/'+ license.image.toString(), width: 500, height: 600,),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row (
                      children: <Widget> [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: MaterialButton(
                            minWidth: 400,
                            onPressed: () {
                              //Navigator.push(
                              //context,
                              //MaterialPageRoute(builder: (context) => OperatorUpdateLicense(operator, plane)));
                            },
                            child: Text('Edit', style: TextStyle(fontSize: 30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Column(
              children: children,
          );
        },
      ),
    ),
    backgroundColor: Colors.grey[850],
    ),
    );
  }
}

