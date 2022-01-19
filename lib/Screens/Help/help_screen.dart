import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Help/ask_screen.dart';
import 'package:leadsgo_apps/Screens/Login/login_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/profile_screen.dart';
import 'package:leadsgo_apps/constants.dart';

// ignore: must_be_immutable
class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  var question = new List(12);
  var asking = new List(12);
  @override
  Widget build(BuildContext context) {
    question[0] = 'BAGAIMANA SAYA BISA LOGIN KE APLIKASI INI ?';
    question[1] = 'BAGAIMANA JIKA ACCOUNT SAYA TIDAK BISA LOGIN ?';
    question[2] = 'BAGAIMANA SAYA MENDAPATKAN GAJI BULANAN ?';
    question[3] = 'BAGAIMANA SAYA MELAKUKAN INTERAKSI ?';
    question[4] = 'BAGAIMANA SAYA MELAKUKAN PENCAIRAN KREDIT ?';
    question[5] = 'BAGAIMANA SAYA MELAKUKAN SIMULASI KREDIT ?';
    question[6] = 'BAGAIMANA SAYA MELIHAT LAPORAN HARIAN INTERAKSI DAN PENCAIRAN ?';
    question[7] = 'BAGAIMANA SAYA MELIHAT INFO, BERITA TERBARU DARI KANTOR PUSAT ?';
    question[8] = 'BAGAIMANA SAYA MELIHAT DATA PRIBADI SAYA ?';
    question[9] = 'BAGAIMANA SAYA MENCETAK SLIP GAJI BULANAN ?';
    question[10] = 'BAGAIMANA SAYA MELAKUKAN PENGAJUAN FLASH CREDIT ?';
    question[11] = 'BAGAIMANA SAYA LOGOUT DARI APLIKASI INI ?';
    asking[0] =
        'KAMU DAPAT LOGIN MENGGUNAKAN USERNAME DAN PASSWORD WEB MARSYT YANG SUDAH ADA SAAT INI';
    asking[1] =
        'KAMU DAPAT MENGHUBUNGI SALES LEADER MASING-MASING UNTUK PEMBUKAAN ACCOUNT YANG TERSUSPEND';
    asking[2] =
        'KAMU DAPAT MELAKUKAN INTERAKSI DAN PENCAIRAN KREDIT UNTUK BISA MENDAPATKAN GAJI BULANAN';
    asking[3] =
        'KAMU DAPAT MELAKUKAN INTERAKSI DAN MENGINPUT PADA MENU INTERAKSI YANG BERADA PADA HALAMAN HOME';
    asking[4] =
        'KAMU DAPAT MELAKUKAN PENCAIRAN KREDIT DAN MENGINPUT PADA MENU PENCAIRAN KREDIT YANG BERADA PADA HALAMAN HOME';
    asking[5] =
        'KAMU DAPAT MELAKUKAN SIMULASI KREDIT PADA MENU SIMULASI YANG BERADA PADA HALAMAN HOME';
    asking[6] =
        'KAMU DAPAT MELIHAT LAPORAN INTERAKSI DAN PENCAIRAN KREDIT PADA MENU LAPORAN YANG BERADA PADA HALAMAN HOME';
    asking[7] =
        'KAMU DAPAT MELIHAT INFO DAN BERITA TERBARU PADA MENU BERITA YANG BERADA PADA HALAMAN HOME';
    asking[8] = 'KAMU DAPAT MELIHAT DATA PRIBADI PADA MENU PROFIL YANG BERADA PADA HALAMAN ACCOUNT';
    asking[9] =
        'KAMU DAPAT MELIHAT DAN MENCETAK SLIP GAJI PADA MENU SLIP GAJI YANG BERADA PADA HALAMAN ACCOUNT';
    asking[10] = 'KAMU DAPAT MELAKUKAN PENGAJUAN FLASH CREDIT PADA HALAMAN FLASH CREDIT';
    asking[11] = 'KAMU DAPAT LOGOUT PADA MENU LOGOUT YANG BERADA PADA HALAMAN ACCOUNT';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'FAQ',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white54),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[0], asking[0])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA BISA LOGIN KE APLIKASI INI ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[1], asking[1])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA JIKA ACCOUNT SAYA TIDAK BISA LOGIN ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[2], asking[2])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MENDAPATKAN GAJI BULANAN ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[3], asking[3])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELAKUKAN INTERAKSI ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[4], asking[4])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELAKUKAN PENCAIRAN KREDIT ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[5], asking[5])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELAKUKAN SIMULASI KREDIT ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[6], asking[6])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELIHAT LAPORAN HARIAN INTERAKSI DAN PENCAIRAN ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[7], asking[7])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELIHAT INFO, BERITA TERBARU DARI KANTOR PUSAT ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[8], asking[8])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELIHAT DATA PERIBADI SAYA ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[9], asking[9])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MECETAK SLIP GAJI BULANAN ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[10], asking[10])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA MELAKUKAN PENGAJUAN FLASH CREDIT ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AskScreen(question[11], asking[11])));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'BAGAIMANA SAYA LOGOUT DARI APLIKASI INI ?',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
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
