import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Report/interaksi_marketing_sl_screen.dart';
import 'package:leadsgo_apps/Screens/Report/pipeline_marketing_sl_screen.dart';
import 'package:leadsgo_apps/Screens/Report/disbursment_marketing_sl_screen.dart';
import 'package:leadsgo_apps/Screens/Report/report_insentif_screen.dart';
import 'package:leadsgo_apps/Screens/provider/report_marketing_sl_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ReportMarketingSlScreen extends StatefulWidget {
  @override
  _ReportMarketingSlScreen createState() => _ReportMarketingSlScreen();

  String nik;

  ReportMarketingSlScreen(this.nik);
}

_showPopupMenu(String niksales, String nama, String tarif) => PopupMenuButton<int>(
      padding: EdgeInsets.only(left: 2),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: GestureDetector(
            onTap: () {
              print(niksales);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DisbursmentMarketingScreen('', niksales, nama)));
            },
            child: Tooltip(
                message: 'Pencairan',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment_outlined,
                      color: leadsGoColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Pencairan')
                  ],
                )),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PipelineMarketingScreen('', niksales, nama)));
            },
            child: Tooltip(
                message: 'Pipeline',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.linear_scale,
                      color: leadsGoColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Pipeline')
                  ],
                )),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InteraksiMarketingScreen('', niksales, nama)));
            },
            child: Tooltip(
                message: 'Interaksi',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.directions_walk_outlined,
                      color: leadsGoColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Interaksi')
                  ],
                )),
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportInsentifScreen('', niksales, tarif)));
            },
            child: Tooltip(
                message: 'Insentif',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on_outlined,
                      color: leadsGoColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Insentif')
                  ],
                )),
          ),
        ),
      ],
      icon: Icon(Icons.more_vert),
      offset: Offset(0, 30),
    );

class _ReportMarketingSlScreen extends State<ReportMarketingSlScreen> {
  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void _createEmail({@required String email}) async {
    String emailaddress() {
      return 'mailto:$email?subject=Sample Subject&body=This is a Sample email';
    }

    if (await canLaunch(emailaddress())) {
      await launch(emailaddress());
    } else {
      throw 'Could not Email';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getMarketingSlReport';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Report_Marketing_Sl'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Report_Marketing_Sl'];
          _isLoading = false;
        }
      });
    }
  }

  String _nik(dynamic user) {
    return user['nik'];
  }

  String _nama(dynamic user) {
    return user['nama'];
  }

  String _jabatan(dynamic user) {
    return user['jabatan'];
  }

  String _jenisKelamin(dynamic user) {
    return user['jenis_kelamin'];
  }

  String _joinDate(dynamic user) {
    return user['join_date'];
  }

  String _alamatEmail(dynamic user) {
    return user['alamat_email'];
  }

  String _noTelepon(dynamic user) {
    return user['no_telepon_2'];
  }

  String _tarif(dynamic user) {
    return user['tarif'];
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Tim Marketing',
            style: fontFamily,
          ),
          actions: <Widget>[],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  child: FlatButton(
                                    onPressed: () {
                                      _createEmail(email: _alamatEmail(_users[index]));
                                    },
                                    child: Icon(MdiIcons.email),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  child: FlatButton(
                                    onPressed: () {
                                      String teleponFix =
                                          '+62' + _noTelepon(_users[index]).substring(1);
                                      launchWhatsApp(phone: teleponFix, message: 'Tes');
                                    },
                                    child: Icon(MdiIcons.whatsapp),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  child: FlatButton(
                                    onPressed: () {
                                      _makePhoneCall('tel:${_noTelepon(_users[index])}');
                                    },
                                    child: Icon(MdiIcons.phone),
                                  ),
                                ),
                              ],
                            ));
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: gender(_jenisKelamin(_users[index])),
                        title: Text('${_nama(_users[index])}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Join',
                                  child: Icon(
                                    MdiIcons.officeBuilding,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _joinDate(_users[index]),
                                  style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Jabatan',
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _jabatan(_users[index]),
                                  style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: _showPopupMenu(
                            _nik(_users[index]), _nama(_users[index]), _tarif(_users[index]))),
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
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty_outlined, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Tim Marketing Tidak Ditemukan!',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: Colors.black,
          ),
        )
      ],
    );
  }

  gender(String a) {
    if (a == '0') {
      return new Icon(
        MdiIcons.humanMale,
        color: Colors.lightBlue,
        size: 30.0,
      );
    } else {
      return new Icon(
        MdiIcons.humanFemale,
        color: Colors.redAccent,
        size: 30.0,
      );
    }
  }
}
