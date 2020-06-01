import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:intl/intl.dart';
import 'package:plane_app_mobile/model/request.dart';
import 'operatorupdaterequest.dart';

class OperatorRequestInfo extends StatefulWidget {

  Operator operator;
  Request request;
  OperatorRequestInfo(this.operator, this.request);

  @override
  _OperatorRequestInfo createState() => _OperatorRequestInfo(operator, request);
}

class _OperatorRequestInfo extends State<OperatorRequestInfo> {

  Operator operator;
  Request request;

  _OperatorRequestInfo(this.operator, this.request);

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
                    createInfo("To: "),
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
                            minWidth: 400,
                            onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OperatorUpdateRequest(operator, request)));
                            },
                            child: Text('Edit', style: TextStyle(fontSize: 30)),
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

