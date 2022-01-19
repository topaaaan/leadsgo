import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:toast/toast.dart';

class AplikasiScreen extends StatefulWidget {
  @override
  _AplikasiScreenState createState() => _AplikasiScreenState();
}

class _AplikasiScreenState extends State<AplikasiScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: leadsGoColor,
              title: Center(
                child: Text(
                  'Pinjaman',
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    color: Colors.white,
                  ),
                ),
              ),
              automaticallyImplyLeading: false),
          body: WillPopScope(
              child: Container(
                  color: grey,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.assignment_outlined, size: 70),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ajukan Pinjaman Yuk!',
                        style: TextStyle(
                            fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Dapatkan pinjaman karyawan disini.',
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
                            'Maaf, untuk saat ini pinjaman belum tersedia',
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
                  )),
              onWillPop: () async {
                Future.value(false);
              })),
    );
  }
}
