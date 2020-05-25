import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/plane.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:plane_app_mobile/model/plane.dart';
import 'package:intl/intl.dart';
import 'operatoraddrequest.dart';

class OperatorPlaneInfo extends StatefulWidget {

  Operator operator;
  Plane plane;
  OperatorPlaneInfo(this.operator, this.plane);

  @override
  _OperatorPlaneInfo createState() => _OperatorPlaneInfo(operator, plane);
}

class _OperatorPlaneInfo extends State<OperatorPlaneInfo> {

  Operator operator;
  Plane plane;

  _OperatorPlaneInfo(this.operator, this.plane);

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
          title: Text("Plane info"),
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
          child: Center(
            child: Column(
              children: <Widget>[
                createTitle(plane.name),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Registration prefix: "),
                    createInfo(plane.registration_prefix), 
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("Registration id: "),
                    createInfo(plane.registration_id),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("type: "),
                    createInfo(plane.plane_type),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row (
                      children: <Widget> [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: MaterialButton(
                            minWidth: 200,
                            onPressed: () => {},
                            child: Text('Edit', style: TextStyle(fontSize: 30)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            minWidth: 200,
                            onPressed: () => {},
                            child: Text('Delete', style: TextStyle(fontSize: 30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
    backgroundColor: Colors.grey[850],
    ),
    );
  }
}

