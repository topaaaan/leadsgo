import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadsgo_apps/Screens/Aplikasi/aplikasi_screen.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_screen.dart';
import 'package:leadsgo_apps/Screens/Home/home_screen.dart';
import 'package:leadsgo_apps/Screens/Penukaran/penukaran_screen.dart';
import 'package:leadsgo_apps/Screens/Leaderboard/leaderboard_screen.dart';
import 'package:leadsgo_apps/Screens/Account/account_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class LandingMrScreen extends StatefulWidget {
  @override
  _LandingMrScreenState createState() => new _LandingMrScreenState();
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
  LandingMrScreen(
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

class _LandingMrScreenState extends State<LandingMrScreen> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [];

  PageController pageController = PageController();
  bool Loading;

  @override
  void initState() {
    // TODO: implement initState
    Loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      if (_bottomNavCurrentIndex != 0) {
        pageController.animateToPage(0,
            duration: Duration(milliseconds: 900), curve: Curves.ease);
      }
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: new Scaffold(
        // body: _container.elementAt(_bottomNavCurrentIndex),
        body: PageView(
          controller: pageController,
          children: <Widget>[
            new HomeScreen(
              widget.username,
              widget.nik,
              widget.income,
              widget.greeting,
              widget.full_name,
              widget.hakAkses,
              widget.personalData[0],
              widget.personalData[24],
              widget.diamond,
              widget.personalData[37],
              widget.personalData[34],
              widget.tarif,
              widget.personalData[36],
            ),
            new PenukaranScreen(
              widget.username,
              widget.nik,
              widget.diamond,
            ),
            new LeaderboardScreen(
              widget.nik,
            ),
            // new SafeArea(
            //   child: Scaffold(
            //     body: Container(
            //       child: SizedBox(
            //         child: Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'COMING SOON',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 18,
            //                   height: 1,
            //                   letterSpacing: 0.5,
            //                   fontFamily: 'LeadsGo-Font',
            //                   color: Colors.black54,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               Text(
            //                 'FITUR INBOX',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                   height: 1,
            //                   letterSpacing: 0.5,
            //                   fontFamily: 'LeadsGo-Font',
            //                   color: Colors.black54,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            new AccountScreen(
                widget.username,
                widget.fotoProfil,
                widget.divisi,
                widget.personalData,
                widget.nik,
                widget.tarif,
                widget.hakAkses,
                widget.diamond),
          ],
          onPageChanged: (index) {
            setState(() {
              _bottomNavCurrentIndex = index;
            });
          },
        ),

        bottomSheet: _buildBottomNavigation(),
        // bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return new Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(123)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            // spreadRadius: 1,
            blurRadius: 15,
            // offset: Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: GNav(
            rippleColor: Colors.grey[300],
            hoverColor: Colors.grey[100],
            gap: 8,
            activeColor: leadsGoColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: leadsGoColor.withOpacity(0.1),
            color: Colors.black,
            tabs: [
              GButton(
                icon: MdiIcons.homeOutline,
                text: 'Home',
                textStyle:
                    TextStyle(fontFamily: 'LeadsGo-Font', color: leadsGoColor),
              ),
              GButton(
                icon: MdiIcons.shoppingOutline,
                text: 'LeadsShop',
                textStyle:
                    TextStyle(fontFamily: 'LeadsGo-Font', color: leadsGoColor),
              ),
              GButton(
                icon: MdiIcons.trendingUp,
                text: 'Leaderboard',
                textStyle:
                    TextStyle(fontFamily: 'LeadsGo-Font', color: leadsGoColor),
              ),
              GButton(
                icon: MdiIcons.accountCircleOutline,
                text: 'Profile',
                textStyle:
                    TextStyle(fontFamily: 'LeadsGo-Font', color: leadsGoColor),
              ),
            ],
            selectedIndex: _bottomNavCurrentIndex,
            onTabChange: (index) {
              // pageController.animateToPage(index,
              //     duration: Duration(milliseconds: 900), curve: Curves.ease);
              pageController.jumpToPage(index);
              setState(() {
                _bottomNavCurrentIndex = index;
              });
            },
          ),
        ),
      ),
    );
    // return new Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(15.0),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.2),
    //         spreadRadius: 1,
    //         blurRadius: 5,
    //         offset: Offset(0, 2),
    //       ),
    //     ],
    //   ),
    //   padding: EdgeInsets.all(10),
    //   child: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     onTap: (index) {
    //       print(index);
    //       setState(() {
    //         _bottomNavCurrentIndex = index;
    //       });
    //     },
    //     currentIndex: _bottomNavCurrentIndex,
    //     selectedItemColor: leadsGoColor,
    //     unselectedItemColor: Colors.grey,
    //     // backgroundColor: Colors.red,
    //     items: [
    //       BottomNavigationBarItem(
    //           activeIcon: Icon(MdiIcons.homeFlood, color: leadsGoColor),
    //           icon: Icon(MdiIcons.home, color: Colors.grey),
    //           title: Text(
    //             'Beranda',
    //             style: TextStyle(
    //               fontFamily: 'LeadsGo-Font',
    //             ),
    //           )),
    //       // BottomNavigationBarItem(
    //       //     activeIcon: Icon(Icons.history, color: leadsGoColor),
    //       //     icon: new Icon(Icons.history, color: Colors.grey),
    //       //     title: new Text(
    //       //       'History',
    //       //       style: TextStyle(
    //       //         fontFamily: 'LeadsGo-Font',
    //       //       ),
    //       //     )),
    //       BottomNavigationBarItem(
    //           activeIcon: Icon(MdiIcons.accountCircle, color: leadsGoColor),
    //           icon: new Icon(MdiIcons.accountCircleOutline, color: Colors.grey),
    //           title: new Text(
    //             'Akun',
    //             style: TextStyle(
    //               fontFamily: 'LeadsGo-Font',
    //             ),
    //           )),
    //     ],
    //   ),
    // );
  }
}
