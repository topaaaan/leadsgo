import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Aplikasi/aplikasi_screen.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_screen.dart';
import 'package:leadsgo_apps/Screens/Home/home_screen.dart';
import 'package:leadsgo_apps/Screens/Account/account_screen.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => new _LandingScreenState();
  String username;
  String nik;
  int income;
  String fotoProfil;
  String divisi;
  String greeting;
  String full_name;
  String hakAkses;
  List personalData;
  String tarif;
  int diamond;
  LandingScreen(
      this.username,
      this.nik,
      this.income,
      this.fotoProfil,
      this.divisi,
      this.greeting,
      this.full_name,
      this.hakAkses,
      this.personalData,
      this.tarif,
      this.diamond);
}

class _LandingScreenState extends State<LandingScreen> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [];
  @override
  Widget build(BuildContext context) {
    print(widget.income.toString());
    _container = [
      // new HomeScreen(
      //   widget.username,
      //   widget.nik,
      //   widget.income,
      //   widget.greeting,
      //   widget.hakAkses,
      //   widget.full_name,
      //   widget.personalData[0],
      //   widget.personalData[24],
      //   widget.diamond,
      //   widget.personalData[37],
      //   widget.personalData[34],
      //   widget.tarif,
      // ),
      new ApprovalScreen(widget.personalData[0]),
      new AplikasiScreen(),
      new AccountScreen(
          widget.username,
          widget.fotoProfil,
          widget.divisi,
          widget.personalData,
          widget.nik,
          widget.tarif,
          widget.hakAkses,
          widget.diamond),
    ];
    return new SafeArea(
      child: Scaffold(
        body: _container.elementAt(_bottomNavCurrentIndex),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        print(index);
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.home, color: leadsGoColor),
            icon: new Icon(Icons.home, color: Colors.grey),
            title: new Text(
              'Beranda',
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.verified_outlined, color: leadsGoColor),
            icon: new Icon(Icons.verified_outlined, color: Colors.grey),
            title: new Text(
              'Approval',
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.history, color: leadsGoColor),
            icon: new Icon(Icons.history, color: Colors.grey),
            title: new Text(
              'Pinjaman',
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.account_circle, color: leadsGoColor),
            icon: new Icon(Icons.account_circle, color: Colors.grey),
            title: new Text(
              'Akun',
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
              ),
            )),
      ],
    );
  }
}
