import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plane_app_mobile/model/customer.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:plane_app_mobile/model/global.dart';
import 'package:plane_app_mobile/model/ticket.dart';
import 'package:plane_app_mobile/network/tickethandler.dart';
import '../../model/customer.dart';

class CustomerUpdateTicket extends StatefulWidget {

  Customer customer;
  Ticket ticket;
  CustomerUpdateTicket(this.customer, this.ticket);

  @override
  _CustomerUpdateTicket createState() => _CustomerUpdateTicket(customer, ticket);
}

class _CustomerUpdateTicket extends State<CustomerUpdateTicket> {

  Customer customer;
  Ticket ticket;
  final dateFormat = DateFormat("yyyy-MM-dd");
  String cargo_type = 'passenger';

  final _titleController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  String from= airports[0];
  final _commentController = TextEditingController();
  String _to = airports[0];
  final _priceController = TextEditingController();

  _CustomerUpdateTicket(this.customer, this.ticket){
    _titleController.text = ticket.title;
    _startController.text = dateFormat.format(ticket.date_from);
    _endController.text = dateFormat.format(ticket.date_to);
    _priceController.text = ticket.price.toString();
    _commentController.text = ticket.ticket_comment;
    cargo_type = ticket.cargo_type;
  }


  Future<bool> updateTicket()
  async {
    Map<String, dynamic> req = {
      "status": ticket.status,
      "cargo_type": cargo_type,
      "title": _titleController.text,
      "date_from": _startController.text,
      "date_to": _endController.text,
      "dest_from": from,
      "dest_to": _to,
      "price": int.parse(_priceController.text),
      "ticket_comment": _commentController.text
    };
    print(req.toString());

    var resp = await updateTicketHandler(json.encode(req), ticket.id, customer.id);
    String st = resp.toString();
    print(st);

    return true;
  }


  Text createTitle(String str) {
    return Text(str, style: TextStyle(fontSize: 20));
  }

  Text createInfo(String str) {
    return Text(str, style: TextStyle(fontSize: 20));
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
          title: Text("Create ticket"),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container (
            height: MediaQuery
              .of(context)
              .size
              .height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    createTitle("Title: "),
                  ],
                ),
                SizedBox(height: 5.0,),
                TextFormField (
                  controller: _titleController,
                  autofocus: false,
                  //initialValue: 'some password',
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("Cargo type: "),
                  ],
                ),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: cargo_type,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              cargo_type = newValue;
                            });
                          },
                          items: <String>['passenger', 'commodity']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("Start date: "),
                  ],
                ),
                SizedBox(height: 5.0),
                DateTimeField(
                  controller: _startController,
                  format: dateFormat,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("End date: "),
                  ],
                ),
                SizedBox(height: 5.0),
                DateTimeField(
                  controller: _endController,
                  format: dateFormat,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("From: "),
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 400.0,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: from,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              from = newValue;
                            });
                          },
                          items: airports.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox( width: 200, child: Text(value, overflow: TextOverflow.ellipsis)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("To: "),
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 400.0,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _to,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _to = newValue;
                            });
                          },
                          items: airports.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox( width: 200, child: Text(value, overflow: TextOverflow.ellipsis)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("Price: "),
                  ],
                ),
                SizedBox(height: 5.0),
                TextFormField (
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'price',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
                SizedBox(height: 22.0),
                Row(
                  children: <Widget>[
                    createTitle("Comment: "),
                  ],
                ),
                SizedBox(height: 5.0),
                TextFormField (
                  controller: _commentController,
                  autofocus: false,
                  //initialValue: 'some password',
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Comment',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: MaterialButton(
                      minWidth: 400,
                      onPressed: () {
                        updateTicket();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Update ticket', style: TextStyle(fontSize: 30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
    ),
    );
  }
}
