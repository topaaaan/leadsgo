import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_interaksi_screen.dart';
import 'package:leadsgo_apps/constants.dart';

import 'approval_disbursment_root_screen.dart';

class ApprovalScreen extends StatefulWidget {
  String nikSdm;

  ApprovalScreen(this.nikSdm);
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
      fontFamily: "LeadsGo-Font",
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: leadsGoColor,
              title: Center(
                child: Text(
                  'Approval',
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    color: Colors.white,
                  ),
                ),
              ),
              automaticallyImplyLeading: false),
          body: WillPopScope(
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ApprovalInteractionScreen(
                                                '', '', '', widget.nikSdm)));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.verified_outlined, color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Approval Interaksi',
                                                  style: TextStyle(
                                                      fontFamily: 'LeadsGo-Font',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ApprovalDisbursmentRootPage(
                                                '', '', widget.nikSdm)));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.verified_outlined, color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Approval Pencairan',
                                                  style: TextStyle(
                                                      fontFamily: 'LeadsGo-Font',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              onWillPop: () async {
                Future.value(false);
              })),
    );
  }
}
