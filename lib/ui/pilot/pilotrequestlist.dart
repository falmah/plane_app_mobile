import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/network/requesthandler.dart';
import 'pilotrequestinfo.dart';
import 'package:plane_app_mobile/model/request.dart';

class PilotRequestListPage extends StatefulWidget {

  Pilot pilot;
  PilotRequestListPage(this.pilot);

  @override
  _PilotRequestListPage createState() => _PilotRequestListPage(pilot);
}

class _PilotRequestListPage extends State<PilotRequestListPage> {

  Pilot pilot;

  _PilotRequestListPage(this.pilot);
  List<Request> requestList = [];

  List<Widget> _generateList() {
    return new List<Widget>.generate(requestList.length, (int index) {
      return RequestCard(requestList[index], pilot);
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
          title: Text(pilot.user.name),
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
          child: FutureBuilder<List<Request>>(
            future: getOperatorRequest(pilot.id),
            builder: (BuildContext context, AsyncSnapshot<List<Request>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            requestList = snapshot.data;
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

class RequestCard extends StatelessWidget {
  const RequestCard(this.request, this.pilot, {Key key}) : super(key: key);

  final Pilot pilot;
  final request;
  static const titleStyle = TextStyle(fontSize: 25);
  static const subtitleStyle = TextStyle(fontSize: 19);

  Color setTicketStatusColor() {
    Color ticketColor;

    switch (request.status) {
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
                    MaterialPageRoute(builder: (context) => PilotRequestInfo(pilot, request)));
                  },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                request.ticket.title,
                style: titleStyle,
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    'status: ',
                    style: subtitleStyle,
                  ),
                  Text(
                    request.status,
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
