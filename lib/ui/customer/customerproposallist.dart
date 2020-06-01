import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/request.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'package:plane_app_mobile/network/proposalhandler.dart';
import 'customeraddticket.dart';
import '../../model/customer.dart';
import 'customerproposalinfo.dart';

class CustomerProposalListPage extends StatefulWidget {
  final Customer customer;
  CustomerProposalListPage(this.customer);

  @override
  _CustomerProposalListPage createState() =>
      _CustomerProposalListPage(customer);
}

class _CustomerProposalListPage extends State<CustomerProposalListPage> {
  Customer customer;
  List<Request> requestList = [];
  GlobalKey<RefreshIndicatorState> refreshKey;

  _CustomerProposalListPage(this.customer);

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
          title: Text("Ticket list"),
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
            var tmp = await getProposalsHandler(customer.id);
            setState(() {
              requestList = tmp;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<Request>>(
              future: getProposalsHandler(customer.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Request>> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  requestList = snapshot.data;
                  child = ListView.builder(
                    itemCount: requestList.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return RequestCard(
                          refreshKey, requestList[index], customer);
                    },
                  );
                } else if (snapshot.hasError) {
                  child = Column(
                    children: <Widget>[
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
                  child = Column(
                    children: <Widget>[
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
  const RequestCard(this.refreshKey, this.request, this.customer, {Key key})
      : super(key: key);

  final refreshKey;
  final customer;
  final Request request;
  static const titleStyle = TextStyle(fontSize: 25);
  static const subtitleStyle = TextStyle(fontSize: 19);

  // Color setTicketStatusColor() {
  //   Color ticketColor;

  //   switch (request.status) {
  //     case "open": {ticketColor = Colors.green; }
  //     break;
  //     case "pending": {ticketColor = Colors.yellow; }
  //     break;
  //     case "rejected": {ticketColor = Colors.red; }
  //     break;
  //     case "closed": {ticketColor = Colors.black26; }
  //     break;
  //   }

  //   return ticketColor;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerProposalInfo(customer, request)));
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
                    'Operator: ',
                    style: subtitleStyle,
                  ),
                  Text(
                    request.operator.user.name +
                        " " +
                        request.operator.user.surname,
                    style: TextStyle(
                      //color: setTicketStatusColor(),
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
