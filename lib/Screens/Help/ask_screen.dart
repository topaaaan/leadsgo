import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

// ignore: must_be_immutable
class AskScreen extends StatefulWidget {
  String question;
  String asking;
  AskScreen(this.question, this.asking);
  @override
  _AskScreenState createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Jawaban',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(color: Colors.white54),
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 50.0),
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                '${widget.question}',
                                style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                '${widget.asking}',
                                style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
