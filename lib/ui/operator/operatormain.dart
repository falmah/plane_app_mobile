import 'package:flutter/material.dart';
import '../../model/operator.dart';
import 'operatorticketlist.dart';
import 'operatorrequestlist.dart';
import 'operatorplanelist.dart';

class OperatorMainPage extends StatefulWidget {

  Operator operator;
  OperatorMainPage(this.operator);

  @override
  _OperatorMainPage createState() => _OperatorMainPage(this.operator);
}

class _OperatorMainPage extends State<OperatorMainPage> {

  Operator operator;
  _OperatorMainPage(this.operator);

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
          //backgroundColor: Colors.grey
          ),
        drawer: Drawer(
          child: ListView(
          // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  operator.user.name+' profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Log out'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    GestureDetector (
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OperatorTicketListPage(operator)));
                      },
                      child: Container(
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(8),
                        child: Center(
                         child: Column(
                            //padding: EdgeInsets.all(8),
                            children: <Widget> [
                              Expanded(
                                child: Text("Show Customer tickets", style: TextStyle(fontSize: 20),),
                              ),
                              Expanded(
                                child: Icon(Icons.assignment, size: 50,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector (
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OperatorPlaneListPage(operator)));
                      },
                      child: Container(
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(8),
                        child: Center(
                         child: Column(
                            //padding: EdgeInsets.all(8),
                            children: <Widget> [
                              Expanded(
                                child: Text("Show Planes", style: TextStyle(fontSize: 20),),
                              ),
                              Expanded(
                                child: Icon(Icons.airplanemode_active, size: 50,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector (
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OperatorRequestListPage(operator)));
                      },
                      child: Container(
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(8),
                        child: Center(
                         child: Column(
                            //padding: EdgeInsets.all(8),
                            children: <Widget> [
                              Expanded(
                                child: Text("Show requests", style: TextStyle(fontSize: 20),),
                              ),
                              Expanded(
                                child: Icon(Icons.assignment_ind, size: 50,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
    );
  }
}
