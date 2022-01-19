import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/Penukaran/reedem_screen.dart';
import 'package:leadsgo_apps/Screens/Account/LogDiamond/lod_diamond_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class PenukaranScreen extends StatefulWidget {
  String username;
  String nik;
  int diamond;

  PenukaranScreen(this.username, this.nik, this.diamond);
  @override
  _PenukaranScreenState createState() => _PenukaranScreenState();
}

class _PenukaranScreenState extends State<PenukaranScreen> {
  formatPoint(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
          // symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return fmf.output.withoutFractionDigits;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.diamond);
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'LeadsPoints',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(123)),
                            color: Colors.black45),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/star.svg",
                              width: 23.0,
                              semanticsLabel: 'Points',
                            ),
                            SizedBox(width: 4),
                            Tooltip(
                              message: 'Total Points',
                              child: Text(
                                formatPoint(widget.diamond.toString()),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'LeadsGo-Font',
                                ),
                              ),
                            ),
                          ],
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LogDiamondScreen(widget.nik)));
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
          // actions: <Widget>[
          //   SvgPicture.asset(
          //     "assets/images/star.svg",
          //     width: 23.0,
          //     semanticsLabel: 'Points',
          //   ),
          //   InkWell(
          //     child: Container(
          //       padding: EdgeInsets.only(top: 19.0, left: 5.0, right: 10.0),
          //       child: Text(
          //         formatPoint(widget.diamond.toString()),
          //         style: TextStyle(
          //           fontSize: 15.0,
          //           color: Colors.white,
          //           fontFamily: 'LeadsGo-Font',
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Form(
          child: Container(
            color: Colors.grey.shade50,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                FadeAnimation(
                  0.5,
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Pulsa & Paket Data',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LeadsGo-Font',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    FadeAnimationLeft(
                      1.0,
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.pink[200],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink[100],
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/pulsa.svg",
                                    height: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 15.0),
                                  child: Text(
                                    'Pulsa',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LeadsGo-Font',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RedeemScreen(
                                      widget.username,
                                      widget.nik,
                                      widget.diamond,
                                      'Isi Pulsa',
                                      'pulsa',
                                      'pulsa')));
                        },
                      ),
                    ),
                    FadeAnimationRight(
                      1.0,
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(right: 15.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[100],
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 15.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/paket-data.svg",
                                    height: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 15.0),
                                  child: Text(
                                    'Paket Data',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LeadsGo-Font',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RedeemScreen(
                                      widget.username,
                                      widget.nik,
                                      widget.diamond,
                                      'Isi Paket Data',
                                      'data',
                                      'data')));
                        },
                      ),
                    ),
                  ],
                ),
                FadeAnimation(
                  0.5,
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Top Up & Tagihan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LeadsGo-Font',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Expanded(
                            child: GridView.count(
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 0,
                          primary: false,
                          crossAxisCount: 4,
                          children: <Widget>[
                            // Ovo
                            FadeAnimation(
                              1.0,
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[900],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple[100],
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25.0, bottom: 7.0),
                                          child: SvgPicture.asset(
                                            "assets/icons/ovo.svg",
                                            width: 60.0,
                                            color: Colors.white,
                                          ),
                                        )),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Ovo',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    height: 1,
                                                    letterSpacing: 0.5,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RedeemScreen(
                                              widget.username,
                                              widget.nik,
                                              widget.diamond,
                                              'Top Up Ovo',
                                              'ovo',
                                              'etoll')));
                                },
                              ),
                            ),
                            // Dana
                            FadeAnimationDown(
                              1.0,
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue[400],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lightBlue[100],
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25.0, bottom: 7.0),
                                          child: SvgPicture.asset(
                                            "assets/icons/dana.svg",
                                            width: 70.0,
                                            color: Colors.white,
                                          ),
                                        )),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Dana',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    height: 1,
                                                    letterSpacing: 0.5,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RedeemScreen(
                                              widget.username,
                                              widget.nik,
                                              widget.diamond,
                                              'Top Up Dana',
                                              'dana',
                                              'etoll')));
                                },
                              ),
                            ),
                            // Shopeepay
                            FadeAnimation(
                              1.0,
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: leadsGoColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange[100],
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, bottom: 3.0),
                                                child: SvgPicture.asset(
                                                  "assets/icons/shopeepay.svg",
                                                  width: 60.0,
                                                  color: Colors.white,
                                                ))),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Shopeepay',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    height: 1,
                                                    letterSpacing: 0.5,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RedeemScreen(
                                              widget.username,
                                              widget.nik,
                                              widget.diamond,
                                              'Top Up ShopeePay',
                                              'shopee',
                                              'etoll')));
                                },
                              ),
                            ),
                            // Gopay
                            FadeAnimationDown(
                              1.0,
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent[700],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.greenAccent[100],
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 28.0, bottom: 7.0),
                                          child: SvgPicture.asset(
                                            "assets/icons/gopay.svg",
                                            width: 70.0,
                                            color: Colors.white,
                                          ),
                                        )),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Gopay',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    height: 1,
                                                    letterSpacing: 0.5,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RedeemScreen(
                                              widget.username,
                                              widget.nik,
                                              widget.diamond,
                                              'Top Up Gopay',
                                              'gopay',
                                              'etoll')));
                                },
                              ),
                            ),
                            // Listrik
                            FadeAnimationLeft(
                              1.0,
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.tealAccent[700],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.tealAccent[100],
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 7.0),
                                          child: SvgPicture.asset(
                                            "assets/icons/listrik.svg",
                                            width: 15.0,
                                            color: Colors.white,
                                          ),
                                        )),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Listrik',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    height: 1,
                                                    letterSpacing: 0.5,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RedeemScreen(
                                              widget.username,
                                              widget.nik,
                                              widget.diamond,
                                              'Isi Token Listrik',
                                              'pln',
                                              'pln')));
                                },
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
