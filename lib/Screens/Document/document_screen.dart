import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'DOKUMEN',
            style: TextStyle(fontFamily: 'LeadsGo-Font'),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Text('DOKUMEN'),
            ],
          ),
        ),
      ),
    );
  }
}
