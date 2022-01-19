import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:leadsgo_apps/Screens/Attendance/attendance_screen.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_screen.dart';
import 'package:leadsgo_apps/Screens/Home/app_bar.dart';
import 'package:leadsgo_apps/Screens/Interaction/planning_interaction_screen.dart';
import 'package:leadsgo_apps/Screens/Modul/modul_screen.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:leadsgo_apps/Screens/Planning/planning_screen.dart';
import 'package:leadsgo_apps/Screens/Voucher/voucher_screen.dart';
import 'package:leadsgo_apps/Screens/Datapens/datapens_screen.dart';
import 'package:leadsgo_apps/Screens/Report/report_screen.dart';
import 'package:leadsgo_apps/Screens/Report/report_screen_rsl.dart';
import 'package:leadsgo_apps/Screens/Report/report_screen_sl.dart';
import 'package:leadsgo_apps/Screens/Simulation/simulation_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Account/LogDiamond/lod_diamond_screen.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:leadsgo_apps/Screens/Planning/planning_add_screen.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_akad_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  String username;
  String nik;
  int income;
  String greeting;
  String full_name;
  String hakAkses;
  String nikSdm;
  String statusKaryawan;
  int diamond;
  String personalData;
  String pencapainan;
  String tarif;
  String tipe;

  HomeScreen(
      this.username,
      this.nik,
      this.income,
      this.greeting,
      this.full_name,
      this.hakAkses,
      this.nikSdm,
      this.statusKaryawan,
      this.diamond,
      this.personalData,
      this.pencapainan,
      this.tarif,
      this.tipe);
}

class _HomeScreenState extends State<HomeScreen> {
  // FUNC. CEK DAILY ABSENCE
  String leadsPoints = '0';

  get color => null;
  Future userPoints() async {
    final String url =
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getPoints';
    try {
      var res = await http.post(Uri.parse(url), body: {'nik_id': widget.nik});

      if (res.statusCode == 200) {
        var message = jsonDecode(res.body)['status'];
        var points = jsonDecode(res.body)['points'];

        if (message == 'sukses') {
          setState(() {
            leadsPoints = points;
          });
        } else {
          setState(() {
            leadsPoints = '0';
          });
        }
      } else {
        setState(() {
          leadsPoints = '0';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        leadsPoints = '0';
      });
    }
  }

  // FUNC. CEK DAILY ABSENCE
  String leadsCash = '0';
  Future userCash() async {
    final String url =
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getCash';
    try {
      var res = await http.post(Uri.parse(url), body: {'nik_id': widget.nik});

      if (res.statusCode == 200) {
        var message = jsonDecode(res.body)['status'];
        var cash = jsonDecode(res.body)['balance'];

        if (message == 'sukses') {
          setState(() {
            leadsCash = cash;
          });
        } else {
          setState(() {
            leadsCash = '0';
          });
        }
      } else {
        setState(() {
          leadsCash = '0';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        leadsCash = '0';
      });
    }
  }

  // FUNC. CEK DAILY ABSENCE
  @override
  void initState() {
    Timer(Duration(milliseconds: 300), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // status bar color
        statusBarBrightness: Brightness.light, //status bar brigtness
        statusBarIconBrightness: Brightness.light, //status barIcon Brightness
      ));
    });
    userPoints();
    userCash();

    // // realtime get points
    // final oneSecPoin = Duration(seconds: 1);
    // Timer.periodic(oneSecPoin, (Timer t) => userPoints());
    // // // realtime get points
    // final oneSecCash = Duration(seconds: 1);
    // Timer.periodic(oneSecCash, (Timer t) => userCash());

    super.initState();
    //GetConnect(); // calls getconnect method to check which type if connection it
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      // await showDialog or Show add banners or whatever
      // then
      return null;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: new Scaffold(
        // backgroundColor: Color(0xfff3f3f3),
        backgroundColor: Colors.grey.shade50,
        body: ColorfulSafeArea(
          color: leadsGoColor,
          // overflowRules: OverflowRules.symmetric(vertical: true),
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: CustomSliverDelegate(
                    expandedHeight: 180,
                    nik: widget.nik,
                    full_name: widget.full_name,
                    username: widget.username,
                    income: widget.income.toString(),
                    // diamond: widget.diamond.toString(),
                    points: leadsPoints.toString() != '0'
                        ? leadsPoints.toString()
                        : '0',
                    cash: leadsCash.toString() != '0'
                        ? leadsCash.toString()
                        : '0',
                    greeting: widget.greeting,
                    // minExtent: 150,
                    // maxExtent: 250,
                  ),
                ),
                SliverFillRemaining(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(children: [
                      FadeAnimation(
                        0.5,
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Selamat bekerja, tetap jaga kesehatan ya ...",
                              style: TextStyle(
                                fontSize: 15,
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'LeadsGo-Font',
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        0.5,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15.0),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.2),
                            //     spreadRadius: 1,
                            //     blurRadius: 5,
                            //     offset: Offset(0, 2),
                            //   ),
                            // ],
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          // padding: EdgeInsets.all(16),
                          height: MediaQuery.of(context).size.height * 0.26,
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
                                    // Absen
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons
                                                      .calendarAccountOutline,
                                                  size: 33,
                                                  color: Colors.teal.shade400,
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
                                                        'Go-Absen',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                        if (widget.tipe.toString() == 'D' ||
                                            widget.tipe.toString() == 'E') {
                                          Toast.show(
                                              'Fitur Absen Tidak Tersedia untuk Anda!',
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.CENTER,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white);
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Attendance(
                                                          widget.username,
                                                          widget.nik,
                                                          null)));
                                        }
                                      },
                                    ),
                                    // DATABASE MASTER
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons
                                                      .databaseSearchOutline,
                                                  size: 33,
                                                  color: Colors.purple.shade400,
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
                                                        'Database Master',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                builder: (context) =>
                                                    DatapensScreen(
                                                        widget.username,
                                                        widget.nik,
                                                        widget.hakAkses)));
                                      },
                                    ),
                                    // DATABASE PRIBADI
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons.folderAccountOutline,
                                                  size: 33,
                                                  color: Colors.orange.shade400,
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
                                                        'Database Pribadi',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                builder: (context) =>
                                                    PlanningScreen(
                                                        widget.username,
                                                        widget.nik,
                                                        widget.hakAkses)));
                                      },
                                    ),
                                    // SIMULASI
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons.calculator,
                                                  size: 33,
                                                  color: Colors.blue.shade400,
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
                                                        'Go-Simulasi',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                builder: (context) =>
                                                    SimulationViewScreen(
                                                        widget.nik)));
                                      },
                                    ),

                                    // INTERAKSI
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons
                                                      .humanGreetingProximity,
                                                  size: 33,
                                                  color: Colors.indigo.shade400,
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
                                                        'Hasil Interaksi',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                builder: (context) =>
                                                    PlanningInteractionScreen(
                                                        widget.username,
                                                        widget.nik,
                                                        widget.hakAkses)));
                                      },
                                    ),
                                    // PIPELINE
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons
                                                      .transitConnectionHorizontal,
                                                  size: 33,
                                                  color: Colors.redAccent,
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
                                                        'Go-Pipeline',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.4,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                builder: (context) =>
                                                    PipelineRootPage(
                                                        widget.username,
                                                        widget.nik)));
                                      },
                                    ),
                                    // PENCAIRAN
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons.bank,
                                                  size: 33,
                                                  color: Colors.green.shade400,
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
                                                        'Update Pencairan',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                            builder: (context) =>
                                                DisbursmentScreen(
                                              widget.username,
                                              widget.nik,
                                              widget.statusKaryawan,
                                              widget.personalData,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // INSENTIF
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  MdiIcons.fileClockOutline,
                                                  size: 33,
                                                  color:
                                                      Colors.blueGrey.shade400,
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
                                                        (widget.tipe.toString() ==
                                                                    'A' ||
                                                                widget.tipe
                                                                        .toString() ==
                                                                    'C')
                                                            ? 'Estimasi Gaji'
                                                            : 'Tracking Insentif',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          height: 1,
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              'LeadsGo-Font',
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                        print(widget.nik);
                                        if (widget.tipe.toString() == 'A') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VoucherScreenA(
                                                          widget.nik)));
                                        } else if (widget.tipe.toString() ==
                                            'C') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VoucherScreenC(
                                                          widget.nik)));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VoucherScreen(
                                                          widget.username,
                                                          widget.nik,
                                                          widget.tarif,
                                                          widget.tipe)));
                                        }
                                      },
                                    ),
                                    // LAPORAN
                                    // GestureDetector(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(5.0),
                                    //     child: Column(
                                    //       children: <Widget>[
                                    //         Container(
                                    //             decoration: BoxDecoration(
                                    //               color: Colors.transparent,
                                    //               borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //               border: Border.all(
                                    //                   width: 1.5, color: Colors.indigo.shade400),
                                    //             ),
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.all(1.0),
                                    //               child: Icon(
                                    //                 MdiIcons.fileChartOutline,
                                    //                 size: 33,
                                    //                 color: Colors.indigo.shade400,
                                    //               ),
                                    //             )),
                                    //         SizedBox(
                                    //           height: 4,
                                    //         ),
                                    //         Expanded(
                                    //           child: Column(
                                    //             children: <Widget>[
                                    //               Expanded(
                                    //                 child: Text(
                                    //                   'Laporan',
                                    //                   textAlign: TextAlign.center,
                                    //                   style: TextStyle(
                                    //                     fontSize: 11,
                                    //                     height: 1,
                                    //                     letterSpacing: 0.4,
                                    //                     fontFamily: 'LeadsGo-Font',
                                    //                     color: Colors.black87,
                                    //                     fontWeight: FontWeight.bold,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   onTap: () {
                                    //     if (widget.hakAkses == '5') {
                                    //       Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) => ReportScreenSl(
                                    //                   widget.username, widget.nikSdm)));
                                    //     } else if (widget.hakAkses == '90') {
                                    //       Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) => ReportScreenRsl(
                                    //                   widget.username, widget.nikSdm)));
                                    //     } else {
                                    //       Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>
                                    //                   ReportScreen(widget.username, widget.nik)));
                                    //     }
                                    //   },
                                    // ),

                                    // // DOKUMEN
                                    // GestureDetector(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(5.0),
                                    //     child: Column(
                                    //       children: <Widget>[
                                    //         Container(
                                    //             decoration: BoxDecoration(
                                    //               color: Colors.transparent,
                                    //               borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //               border: Border.all(width: 1.5, color: leadsGoColor),
                                    //             ),
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.all(1.0),
                                    //               child: Icon(
                                    //                 MdiIcons.folderInformation,
                                    //                 size: 33,
                                    //                 color: leadsGoColor,
                                    //               ),
                                    //             )),
                                    //         SizedBox(
                                    //           height: 6,
                                    //         ),
                                    //         Expanded(
                                    //           child: Column(
                                    //             children: <Widget>[
                                    //               Expanded(
                                    //                 child: Text(
                                    //                   'Dokumen',
                                    //                   textAlign: TextAlign.center,
                                    //                   style: TextStyle(
                                    //                     fontSize: 11,
                                    //                     fontFamily: 'LeadsGo-Font',
                                    //                     color: Colors.black87,
                                    //                     fontWeight: FontWeight.bold,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   onTap: () {
                                    //     Navigator.push(context,
                                    //         MaterialPageRoute(builder: (context) => ModulScreen()));
                                    //   },
                                    // ),
                                  ],
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'Rp ' + fmf.output.withoutFractionDigits;
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final String nik;
  final String username;
  final String full_name;
  final String income;
  // final String diamond;
  final String points;
  final String cash;
  final String greeting;
  // final double minExtent;
  // final double maxExtent;

  CustomSliverDelegate({
    @required this.expandedHeight,
    @required this.nik,
    @required this.username,
    @required this.full_name,
    @required this.income,
    // @required this.diamond,
    @required this.points,
    @required this.cash,
    @required this.greeting,
    // @required this.minExtent,
    // @required this.maxExtent,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 1.3 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: expandedHeight + expandedHeight / 3,
      // height: maxExtent,
      child: Stack(
        children: [
          FadeAnimation(
            0.5,
            SizedBox(
              height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
              child: Container(
                decoration: cardTopPosition >= 0
                    ? BoxDecoration(
                        color: leadsGoColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/bg-cloud.png"),
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
                        color: leadsGoColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                        ),
                      ),
                child: PreferredSize(
                  preferredSize: Size.fromHeight(200),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    elevation: 0.0,
                    actions: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(123)),
                                      // color: Color(0xFF193366)),
                                      color: Colors.black45),
                                  child: Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "assets/images/star.svg",
                                        width: 23.0,
                                        semanticsLabel: 'Points',
                                      ),
                                      // Image.asset(
                                      //   "assets/images/star.svg",
                                      //   fit: BoxFit.fill,
                                      //   width: size.width * 0.05,
                                      // ),
                                      SizedBox(width: 4),
                                      Tooltip(
                                        message: 'Total Points',
                                        child: Text(
                                          formatPoint(points.toString()),
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
                                    builder: (context) =>
                                        LogDiamondScreen(nik)));
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // InkWell(
                            //   child: Container(
                            //     // padding: EdgeInsets.all(7.0),
                            //     // decoration: BoxDecoration(
                            //     //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            //     //     // color: Color(0xFF193366)),
                            //     //     color: deepleadsGoColor),
                            //     child: SvgPicture.asset(
                            //       "assets/images/bell.svg",
                            //       width: 25.0,
                            //       color: Colors.white54,
                            //       semanticsLabel: 'Notification',
                            //     ),
                            //     // child: Icon(
                            //     //   MdiIcons.bell,
                            //     //   color: Colors.white,
                            //     //   size: 25.0,
                            //     // ),
                            //   ),
                            //   onTap: () {},
                            // )
                          ],
                        ),
                      ),
                    ],
                    title: Opacity(
                      opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                      child: Container(
                        child: Image.asset(
                          "assets/leadsgo_logo_white.png",
                          fit: BoxFit.fill,
                          width: size.width * 0.25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 34,
            bottom: 0.0,
            child: FadeAnimation(
              0.2,
              Opacity(
                opacity: percent,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * percent),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$greeting,',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$full_name",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     // mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "Caash ",
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           fontFamily: 'LeadsGo-Font',
                        //           fontWeight: FontWeight.normal,
                        //           color: cash.toString() != '0'
                        //               ? Colors.white
                        //               : Colors.white54,
                        //         ),
                        //       ),
                        //       Text(
                        //         formatRupiah(cash.toString()),
                        //         style: TextStyle(
                        //           fontSize: cash.toString() != '0' ? 18 : 14,
                        //           letterSpacing: 0.4,
                        //           fontFamily: 'LeadsGo-Font',
                        //           fontWeight: FontWeight.bold,
                        //           color: cash.toString() != '0'
                        //               ? Colors.white
                        //               : Colors.white54,
                        //         ),
                        //       ),
                        //       // IconButton(
                        //       //   onPressed: () => {
                        //       //     // modalShowGetAbsence('GAGAL', '', '13:00'),
                        //       //   },
                        //       //   iconSize: 18,
                        //       //   icon: Icon(
                        //       //     MdiIcons.refresh,
                        //       //     color: Colors.white,
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    )),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: FadeAnimation(
              0,
              Opacity(
                opacity: percent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(40, 5, 40, 0),
                        height: MediaQuery.of(context).size.width * 0.19,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    // Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.transparent,
                                    //       // borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //       // border: Border.all(width: 1.5, color: leadsGoColor),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(1.0),
                                    //       child: Icon(
                                    //         MdiIcons.accountMultiplePlusOutline,
                                    //         size: 33,
                                    //         color: leadsGoColor,
                                    //       ),
                                    //     )),
                                    // SizedBox(
                                    //   height: 6,
                                    // ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.accountMultiplePlusOutline,
                                            size: 35,
                                            color: leadsGoColor,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Go-Interaksi',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 11,
                                                letterSpacing: 1,
                                                fontFamily: 'LeadsGo-Font',
                                                color: leadsGoColor,
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlanningAddScreen(username, nik)));
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    // Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.transparent,
                                    //       // borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //       // border: Border.all(width: 1.5, color: leadsGoColor),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(1.0),
                                    //       child: Icon(
                                    //         MdiIcons.plusBoxMultipleOutline,
                                    //         size: 33,
                                    //         color: leadsGoColor,
                                    //       ),
                                    //     )),
                                    // SizedBox(
                                    //   height: 6,
                                    // ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.plusNetworkOutline,
                                            size: 35,
                                            color: leadsGoColor,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Pipeline',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 11,
                                                letterSpacing: 1,
                                                fontFamily: 'LeadsGo-Font',
                                                color: leadsGoColor,
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PipelineAddScreen(username, nik)));
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    // Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.transparent,
                                    //       // borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //       // border: Border.all(width: 1.5, color: leadsGoColor),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(1.0),
                                    //       child: Icon(
                                    //         MdiIcons.bankPlus,
                                    //         size: 33,
                                    //         color: leadsGoColor,
                                    //       ),
                                    //     )),
                                    // SizedBox(
                                    //   height: 6,
                                    // ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.bankPlus,
                                            size: 35,
                                            color: leadsGoColor,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Pencairan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 11,
                                                letterSpacing: 1,
                                                fontFamily: 'LeadsGo-Font',
                                                color: leadsGoColor,
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DisbursmentAkadScreen(username, nik)));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 3;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

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
}
