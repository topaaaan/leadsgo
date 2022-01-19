import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class LogDiamondScreen extends StatefulWidget {
  String niksales;

  LogDiamondScreen(this.niksales);
  @override
  _LogDiamondScreen createState() => _LogDiamondScreen();
}

class _LogDiamondScreen extends State<LogDiamondScreen> {
  bool _isLoading = false;
  final apiUrl = Uri.parse(
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getLogPoint');

  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {'nik': widget.niksales});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Log'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Log'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id_account'];
  }

  String _kodeTransaksi(dynamic user) {
    return user['action'];
  }

  String _debit(dynamic user) {
    return user['add_balance'];
  }

  String _updatedAt(dynamic user) {
    return user['tanggal'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: new Text(
            'Riwayat Point',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'LeadsGo-Font',
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        body: Container(
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation(
                0.5,
                Card(
                  color: _kodeTransaksi(_users[index]) == 'IN'
                      ? Colors.green[100]
                      : Colors.red[100],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/star.svg",
                                width: 15.0,
                              ),
                              // Icon(
                              //   Icons.info_outlined,
                              //   color: Colors.black54,
                              //   size: 15,
                              // ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  setKeterangan(_kodeTransaksi(_users[index])),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.black54,
                                size: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(_updatedAt(_users[index]),
                                    style: TextStyle(color: Colors.black54)),
                              ),
                            ],
                          ),
                          trailing: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  setDiamond(
                                    _kodeTransaksi(_users[index]),
                                    _debit(_users[index]),
                                  ),
                                  style:
                                      setStyle(_kodeTransaksi(_users[index])),
                                ),
                              ),
                              // Icon(
                              //   MdiIcons.diamond,
                              //   color: Colors.black54,
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                // decoration: BoxDecoration(
                //     color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                "assets/images/star.svg",
                width: 120.0,
                semanticsLabel: 'Points',
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Riwayat Point\nBelum Tersedia!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "LeadsGo-Font",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
          ]),
        );
      }
    }
  }

  setKeterangan(String kodeTransaksi) {
    String x = kodeTransaksi;
    if (x == 'IN') {
      return 'Point Masuk';
    } else {
      return 'Point Keluar';
    }
  }

  setDiamond(String kodeTransaksi, String debit) {
    String x = kodeTransaksi;
    if (x == 'IN') {
      return '+ ' + debit;
    } else {
      if (debit != '0') {
        return '- ' + debit;
      } else {
        return 'Failed';
      }
    }
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setStyle(String kodeTransaksi) {
    String x = kodeTransaksi;
    if (x == 'IN') {
      return TextStyle(color: Colors.green);
    } else {
      return TextStyle(color: Colors.red);
    }
  }
}
