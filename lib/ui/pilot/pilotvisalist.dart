import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/network/visahandler.dart';
import 'package:plane_app_mobile/ui/pilot/pilotaddvisa.dart';
import 'package:plane_app_mobile/model/visa.dart';
import 'package:plane_app_mobile/ui/pilot/pilotvisainfo.dart';

class PilotVisaListPage extends StatefulWidget {
  final Pilot pilot;
  PilotVisaListPage(this.pilot);

  @override
  _PilotVisaListPage createState() => _PilotVisaListPage(pilot);
}

class _PilotVisaListPage extends State<PilotVisaListPage> {
  Pilot pilot;
  GlobalKey<RefreshIndicatorState> refreshKey;

  _PilotVisaListPage(this.pilot);
  List<Visa> requestList = [];

  List<Widget> _generateList() {
    return new List<Widget>.generate(requestList.length, (int index) {
      return VisaCard(refreshKey, requestList[index], pilot);
    });
  }

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
          title: Text("${pilot.user.name}'s visas"),
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
            var tmp = await getPilotVisa(pilot.id);
            setState(() {
              requestList = tmp;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<Visa>>(
              future: getPilotVisa(pilot.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Visa>> snapshot) {
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
        ),
        backgroundColor: Colors.grey[850],
        floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PilotAddVisa(pilot)));
          },
        ),
      ),
    );
  }
}

class VisaCard extends StatelessWidget {
  const VisaCard(this.refreshKey, this.visa, this.pilot, {Key key})
      : super(key: key);

  final refreshKey;
  final Pilot pilot;
  final visa;
  static const titleStyle = TextStyle(fontSize: 25);
  static const subtitleStyle = TextStyle(fontSize: 19);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Dismissible(
        key: Key(UniqueKey().toString()),
        onDismissed: (direction) {
          //deleteRequestHandler(request.id, operator.id);
          refreshKey.currentState.show(atTop: true);
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PilotVisaInfo(pilot, visa)));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  visa.name,
                  style: titleStyle,
                ),
                subtitle: Row(
                  children: <Widget>[
                    Text(
                      'visa type: ',
                      style: subtitleStyle,
                    ),
                    Text(
                      visa.visa_type,
                      /*style: TextStyle(
                      color: setTicketStatusColor(),
                      fontSize: 19,
                    ),*/
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
