import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Credit',
            style: TextStyle(fontFamily: 'LeadsGo-Font'),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Text('Credit'),
              ],
            )),
      ),
    );
  }
}
