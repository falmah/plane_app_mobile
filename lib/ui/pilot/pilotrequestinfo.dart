import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:intl/intl.dart';
import 'package:plane_app_mobile/model/request.dart';

class PilotRequestInfo extends StatefulWidget {

  Pilot pilot;
  Request request;
  PilotRequestInfo(this.pilot, this.request);

  @override
  _PilotRequestInfo createState() => _PilotRequestInfo(pilot, request);
}

class _PilotRequestInfo extends State<PilotRequestInfo> {

  Pilot pilot;
  Request request;

  _PilotRequestInfo(this.pilot, this.request);

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
          title: Text("Ticket info"),
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
                createTitle(request.ticket.title),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Status: "),
                    createInfo(request.status), 
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("Deadline: "),
                    createInfo(DateFormat('yyyy-MM-dd').format(request.deadline)), 
                  ],
                ),
                Divider(),
                createTitle("Transportation"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("From: "),
                    createInfo(request.ticket.dest_from.name),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo(request.ticket.dest_to.name),
                  ],
                ),
                Divider(),
                createTitle("Pilot"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Name: "),
                    createInfo(request.pilot.user.name),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("Surname: "),
                    createInfo(request.pilot.user.surname),
                  ],
                ),
                Divider(),
                createTitle("Required"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("license: "),
                    createInfo(request.required_license)
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("visa: "),
                    createInfo(request.required_visa)
                  ],
                ),
                Divider(),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Price: "),
                    createInfo(request.price.toString())
                  ],
                ),
                Divider(),
                createTitle("PLane"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Name: "),
                    createInfo(request.plane.name),
                  ],
                ),
                Divider(),/*
                createTitle("Operator"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Name: "),
                    createInfo(request.operator.user.name + " " + request.operator.user.name),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("email: "),
                    createInfo(request.operator.user.email)
                  ],
                ),*/
                SizedBox(height: 5.0,),
                Divider(),
                createTitle("Comment"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[ 
                    Flexible(
                      child: createInfo(request.request_comment),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row (
                      children: <Widget> [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: MaterialButton(
                            color: Colors.green[800],
                            minWidth: 200,
                            onPressed: () => {},
                            child: Text('Accept request', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            color: Colors.red[900],
                            minWidth: 200,
                            onPressed: () => {},
                            child: Text('Decline request', style: TextStyle(fontSize: 20)),
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

