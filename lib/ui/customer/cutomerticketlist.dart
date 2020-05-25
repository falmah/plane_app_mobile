import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'customeraddticket.dart';
import '../../model/customer.dart';
import 'customerticketinfo.dart';
import 'package:plane_app_mobile/network/tickethandler.dart';

class CustomerTicketListPage extends StatefulWidget {

  Customer customer;
  CustomerTicketListPage(this.customer);

  @override
  _CustomerTicketListPage createState() => _CustomerTicketListPage(customer);
}

class _CustomerTicketListPage extends State<CustomerTicketListPage> {

  Customer customer;
  List<Ticket> ticketList = [];
  GlobalKey<RefreshIndicatorState> refreshKey;

  _CustomerTicketListPage(this.customer);

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
            var tmp = await getTickets(customer.id);
            setState(() {
              ticketList = tmp;  
            });
          }, 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<Ticket>>(
              future: getTickets(customer.id),
              builder: (BuildContext context, AsyncSnapshot<List<Ticket>> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  ticketList = snapshot.data;
                  child = ListView.builder(
                    itemCount: ticketList.length,
                    itemBuilder: (BuildContext contex, int index){
                      return TicketCard(refreshKey, ticketList[index], customer);
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerAddTicket(customer)));
          },
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard(this.refreshKey, this.ticket, this.customer, {Key key}) : super(key: key);

  final refreshKey;
  final customer;
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
      child: Dismissible(
        key: Key(UniqueKey().toString()),
        onDismissed: (direction) {
          deleteTicketHandler(ticket.id, customer.id);
          refreshKey.currentState.show(atTop: true);
        },
          child: GestureDetector (
          onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerTicketInfo(customer, ticket)));
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
      ),
    );
  }
}
