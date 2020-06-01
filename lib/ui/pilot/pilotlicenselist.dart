import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/network/licensehandler.dart';
import 'package:plane_app_mobile/ui/pilot/pilotaddlicense.dart';
import 'package:plane_app_mobile/ui/pilot/pilotlicenseinfo.dart';
import 'package:plane_app_mobile/model/license.dart';

class PilotLicenseListPage extends StatefulWidget {
  final Pilot pilot;
  PilotLicenseListPage(this.pilot);

  @override
  _PilotLicenseListPage createState() => _PilotLicenseListPage(pilot);
}

class _PilotLicenseListPage extends State<PilotLicenseListPage> {
  Pilot pilot;
  GlobalKey<RefreshIndicatorState> refreshKey;

  _PilotLicenseListPage(this.pilot);
  List<License> requestList = [];

  List<Widget> _generateList() {
    return new List<Widget>.generate(requestList.length, (int index) {
      return LicenseCard(refreshKey, requestList[index], pilot);
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
          title: Text(pilot.user.name),
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
            var tmp = await getPilotLicense(pilot.id);
            setState(() {
              requestList = tmp;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<License>>(
              future: getPilotLicense(pilot.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<License>> snapshot) {
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
                    builder: (context) => PilotAddLicense(pilot)));
          },
        ),
      ),
    );
  }
}

class LicenseCard extends StatelessWidget {
  const LicenseCard(this.refreshKey, this.license, this.pilot, {Key key})
      : super(key: key);

  final refreshKey;
  final Pilot pilot;
  final license;
  static const titleStyle = TextStyle(fontSize: 25);
  static const subtitleStyle = TextStyle(fontSize: 19);

/*
  Color setTicketStatusColor() {
    Color ticketColor;

    switch (lice.status) {
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
  }*/

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
                    builder: (context) => PilotPlaneInfo(pilot, license)));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  license.name,
                  style: titleStyle,
                ),
                subtitle: Row(
                  children: <Widget>[
                    Text(
                      'license type: ',
                      style: subtitleStyle,
                    ),
                    Text(
                      license.license_type,
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
