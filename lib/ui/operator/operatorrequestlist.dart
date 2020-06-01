import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/network/requesthandler.dart';
import 'operatorrequestinfo.dart';
import 'package:plane_app_mobile/model/request.dart';

class OperatorRequestListPage extends StatefulWidget {

  Operator operator;
  OperatorRequestListPage(this.operator);

  @override
  _OperatorRequestListPage createState() => _OperatorRequestListPage(operator);
}

class _OperatorRequestListPage extends State<OperatorRequestListPage> {

  Operator operator;
  GlobalKey<RefreshIndicatorState> refreshKey;
  _OperatorRequestListPage(this.operator);
  List<Request> requestList = [];

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
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
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          var tmp = await getOperatorRequest(operator.id);
          setState(() {
            requestList = tmp;  
          });
        }, 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Request>>(
            future: getOperatorRequest(operator.id),
            builder: (BuildContext context, AsyncSnapshot<List<Request>> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                requestList = snapshot.data;
                child = ListView.builder(
                  itemCount: requestList.length,
                  itemBuilder: (BuildContext contex, int index){
                    return RequestCard(refreshKey, requestList[index], operator);
                  },
                );
              } else if (snapshot.hasError) {
                child = Column( children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
                );
              } else {
                child = Column( children: <Widget>[
                  CircularProgressIndicator(),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ],
                );
              }
              return child;
            },
          ),
        ),
      ),
    backgroundColor: Colors.grey[850],
    ),
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard(this.refreshKey, this.request, this.operator, {Key key}) : super(key: key);

  final refreshKey;
  final Operator operator;
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
      child: Dismissible(
        key: Key(UniqueKey().toString()),
        onDismissed: (direction) {
          deleteRequestHandler(request.id, operator.id);
          refreshKey.currentState.show(atTop: true);
        },
      child: GestureDetector (
        onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OperatorRequestInfo(operator, request)));
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
      ),
    );
  }
}
