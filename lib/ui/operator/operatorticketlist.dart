import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'operatorticketinfo.dart';
import 'package:plane_app_mobile/network/tickethandler.dart';

class OperatorTicketListPage extends StatefulWidget {

  Operator operator;
  OperatorTicketListPage(this.operator);

  @override
  _OperatorTicketListPage createState() => _OperatorTicketListPage(operator);
}

class _OperatorTicketListPage extends State<OperatorTicketListPage> {

  Operator operator;

  _OperatorTicketListPage(this.operator);
  List<Ticket> ticketList = [];

  List<Widget> _generateList() {
    return new List<Widget>.generate(ticketList.length, (int index) {
      return TicketCard(ticketList[index], operator);
    });
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
          title: Text(operator.user.name),
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
          child: FutureBuilder<List<Ticket>>(
            future: getTicketsOperator(operator.id),
            builder: (BuildContext context, AsyncSnapshot<List<Ticket>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            ticketList = snapshot.data;
            children = _generateList();
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

class TicketCard extends StatelessWidget {
  const TicketCard(this.ticket, this.operator, {Key key}) : super(key: key);

  final Operator operator;
  final ticket;
  static const titleStyle = TextStyle(fontSize: 25);
  static const subtitleStyle = TextStyle(fontSize: 19);

  Color setTicketStatusColor() {
    Color ticketColor;

    switch (ticket.status) {
      case "open": {ticketColor = Colors.green; }
      break;
      case "pending": {ticketColor = Colors.yellow; }
      break;
      case "rejected": {ticketColor = Colors.red; }
      break;
      case "closed": {ticketColor = Colors.black26; }
      break;
    }
    
    return ticketColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: GestureDetector (
        onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OperatorTicketInfo(operator, ticket)));
                  },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                ticket.title,
                style: titleStyle,
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    'status: ',
                    style: subtitleStyle,
                  ),
                  Text(
                    ticket.status,
                    style: TextStyle(
                      color: setTicketStatusColor(),
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
