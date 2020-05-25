import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'package:plane_app_mobile/model/operator.dart';
import 'package:plane_app_mobile/model/pilot.dart';
import 'package:plane_app_mobile/network/loginhandler.dart';
import 'package:plane_app_mobile/ui/customer/customermain.dart';
import 'package:plane_app_mobile/ui/operator/operatormain.dart';
import 'package:plane_app_mobile/ui/pilot/pilotmain.dart';
import 'registration.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void login() async{
    var resp = await loginHandler(_usernameController.text, _passwordController.text);
    switch (resp["user"]["role"] as String) {
      case "customer": {
        Customer c = Customer.fromJson(resp);
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CustomerMainPage(c)));
      } break;
      case "operator": {
        Operator o = Operator.fromJson(resp);
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OperatorMainPage(o)));
      } break;
      case "pilot": {
        Pilot p = Pilot.fromJson(resp);
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PilotMainPage(p)));
      } break;
      default:
    }
    print(resp);
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        //child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      //initialValue: 'someUser@gmail.com',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      //initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          login();
        },
        padding: EdgeInsets.all(12),
        color: Colors.grey,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final registrationLabel = FlatButton(
      child: Text(
        'Registration',
        style: TextStyle(color: Colors.white38),
      ),
      onPressed: () {
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()));
        },
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.white38),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registrationLabel,
            forgotLabel
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.grey,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}