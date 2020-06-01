import 'package:flutter/material.dart';
import '../../model/customer.dart';
import 'customerproposallist.dart';
import 'cutomerticketlist.dart';

class CustomerMainPage extends StatefulWidget {
  Customer customer;
  CustomerMainPage(this.customer);

  @override
  _CustomerMainPage createState() => _CustomerMainPage(customer);
}

class _CustomerMainPage extends State<CustomerMainPage> {
  Customer customer;
  _CustomerMainPage(this.customer);

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
          title: Text(customer.user.name),
          //backgroundColor: Colors.grey
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  customer.user.name + ' profile',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomerTicketListPage(customer)));
                      },
                      child: Container(
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            //padding: EdgeInsets.all(8),
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Show tickets",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: Icon(
                                  Icons.airplanemode_active,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomerProposalListPage(customer)));
                      },
                      child: Container(
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            //padding: EdgeInsets.all(8),
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Show proposals",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: Icon(
                                  Icons.announcement,
                                  size: 50,
                                ),
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
