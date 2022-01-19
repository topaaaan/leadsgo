import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:toast/toast.dart';

class SlipGajiScreen extends StatefulWidget {
  @override
  _SlipGajiScreenState createState() => _SlipGajiScreenState();
}

class _SlipGajiScreenState extends State<SlipGajiScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Slip Gaji',
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
              color: grey,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.assignment_outlined, size: 70),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lihat Slip Gaji Yuk!',
                    style: TextStyle(
                        fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Dapatkan slip gaji anda disini.',
                    style: TextStyle(
                      fontFamily: "LeadsGo-Font",
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    color: leadsGoColor,
                    onPressed: () {
                      Toast.show(
                        'Maaf, untuk saat ini slip gaji belum tersedia',
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM,
                        backgroundColor: Colors.red,
                      );
                    },
                    child: Text(
                      'Belum Tersedia',
                      style: TextStyle(
                        fontFamily: "LeadsGo-Font",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ))),
    );
  }
}
