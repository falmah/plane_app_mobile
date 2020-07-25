import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'package:plane_app_mobile/network/proposalhandler.dart';
import '../../model/customer.dart';
import 'package:plane_app_mobile/model/request.dart';

class CustomerProposalInfo extends StatefulWidget {

  final Customer customer;
  final Request request;
  CustomerProposalInfo(this.customer, this.request);

  @override
  _CustomerProposalInfo createState() => _CustomerProposalInfo(customer, request);
}

class _CustomerProposalInfo extends State<CustomerProposalInfo> {

  Customer customer;
  Request request;
  _CustomerProposalInfo(this.customer, this.request);

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
                    createInfo("Cargo_type: "),
                    createInfo(request.ticket.cargo_type),
                  ],
                ),
                Divider(),
                createTitle("Date"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("From: "),
                    createInfo(DateFormat('yyyy-MM-dd').format(request.ticket.date_from)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("To: "),
                    createInfo(DateFormat('yyyy-MM-dd').format(request.ticket.date_to)),
                  ],
                ),
                Divider(),
                createTitle("Destination"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("From: "),
                    Flexible(
                      child: createInfo(request.ticket.dest_from.name),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("To: "),
                    createInfo(request.ticket.dest_to.name),
                  ],
                ),
                Divider(),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Price: "),
                    createInfo(request.ticket.price.toString())
                  ],
                ),
                Divider(),
                createTitle("Operator"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Name: "),
                    createInfo(request.operator.user.name + " "),
                    createInfo(request.operator.user.surname),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("email: "),
                    createInfo(request.operator.user.email),
                  ],
                ),
                Divider(),
                createTitle("Pilot"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Name: "),
                    createInfo(request.pilot.user.name + " "),
                    createInfo(request.pilot.user.surname),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("email: "),
                    createInfo(request.pilot.user.email),
                  ],
                ),
                Divider(),
                createTitle("Comment"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[ 
                    Flexible(
                      child: createInfo(request.ticket.ticket_comment),
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
                            onPressed: () {
                              customerChangeProposalStatus(customer.id, request.id, 'pending');
                              Navigator.pop(context);
                            },
                            child: Text('Accept proposal', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            color: Colors.red[900],
                            minWidth: 200,
                            onPressed: () {
                              customerChangeProposalStatus(customer.id, request.id, 'rejected');
                              Navigator.pop(context);
                            },
                            child: Text('Decline proposal', style: TextStyle(fontSize: 20)),
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

