import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/network/planehandler.dart';
import 'package:plane_app_mobile/network/tickethandler.dart';
import 'operatorplaneinfo.dart';
import 'operatoraddplane.dart';
import 'package:plane_app_mobile/model/plane.dart';

class OperatorPlaneListPage extends StatefulWidget {

  Operator operator;
  OperatorPlaneListPage(this.operator);

  @override
  _OperatorPlaneListPage createState() => _OperatorPlaneListPage(operator);
}

class _OperatorPlaneListPage extends State<OperatorPlaneListPage> {

  Operator operator;

  _OperatorPlaneListPage(this.operator);
  List<Plane> planeList = [];
  GlobalKey<RefreshIndicatorState> refreshKey;

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
          title: Text("Customer tickets"),
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
          var tmp = await getPlanes(operator.id);
          setState(() {
            planeList = tmp;  
          });
        }, 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Plane>>(
            future: getPlanes(operator.id),
            builder: (BuildContext context, AsyncSnapshot<List<Plane>> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                planeList = snapshot.data;
                child = ListView.builder(
                  itemCount: planeList.length,
                  itemBuilder: (BuildContext contex, int index){
                    return PlaneCard(refreshKey, planeList[index], operator);
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
        MaterialPageRoute(builder: (context) => OperatorAddPlane(operator)));
      },
    ),
    ),
    );
  }
}

class PlaneCard extends StatelessWidget {
  const PlaneCard(this.refreshKey, this.plane, this.operator, {Key key}) : super(key: key);

  final refreshKey;
  final Operator operator;
  final Plane plane;
  static const titleStyle = TextStyle(fontSize: 25);
  static const subtitleStyle = TextStyle(fontSize: 19);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Dismissible(
        key: Key(UniqueKey().toString()),
        onDismissed: (direction) {
          //deletePlaneHandler(plane.id, operator.id);
          refreshKey.currentState.show(atTop: true);
        },
      child: GestureDetector (
        onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OperatorPlaneInfo(operator, plane)));
                  },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                plane.name,
                style: titleStyle,
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    'prefix: ',
                    style: subtitleStyle,
                  ),
                  Text(
                    plane.registration_prefix,
                    style: TextStyle(
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
