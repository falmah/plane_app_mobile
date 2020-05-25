import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'package:intl/intl.dart';
import 'operatoraddrequest.dart';
import '../../model/customer.dart';

class OperatorTicketInfo extends StatefulWidget {

  Operator operator;
  Ticket ticket;
  OperatorTicketInfo(this.operator, this.ticket);

  @override
  _OperatorTicketInfo createState() => _OperatorTicketInfo(operator, ticket);
}

class _OperatorTicketInfo extends State<OperatorTicketInfo> {

  Operator operator;
  Ticket ticket;

  _OperatorTicketInfo(this.operator, this.ticket);

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
                createTitle(ticket.title),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Status: "),
                    createInfo(ticket.status), 
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("Cargo_type: "),
                    createInfo(ticket.cargo_type),
                  ],
                ),
                Divider(),
                createTitle("Date"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("From: "),
                    createInfo(DateFormat('yyyy-MM-dd').format(ticket.date_from)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("To: "),
                    createInfo(DateFormat('yyyy-MM-dd').format(ticket.date_to)),
                  ],
                ),
                Divider(),
                createTitle("Destination"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("From: "),
                    createInfo(ticket.dest_from.name)
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("To: "),
                    createInfo(ticket.dest_to.name)
                  ],
                ),
                Divider(),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Price: "),
                    createInfo(ticket.price.toString())
                  ],
                ),
                Divider(),
                createTitle("Customer"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    createInfo("Name: "),
                    createInfo(ticket.customer.user.name + " " + ticket.customer.user.name),
                  ],
                ),
                Row(
                  children: <Widget>[
                    createInfo("email: "),
                    createInfo(ticket.customer.user.email)
                  ],
                ),
                Divider(),
                createTitle("Comment"),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[ 
                    Flexible(
                      child: createInfo(ticket.ticket_comment),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row (
                      children: <Widget> [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            minWidth: 400,
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OperatorAddRequest(operator, ticket))),
                            },
                            child: Text('Create request', style: TextStyle(fontSize: 30)),
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

