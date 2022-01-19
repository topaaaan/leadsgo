// import 'dart:io';
import 'dart:async';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:leadsgo_apps/Screens/Login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  String versionId;
  String versionIdApp = '1.0.11';

  String title = "title";
  String content = "content";

  bool isReady;

  // Funtion Get Verison Apps
  Future getAppVersion() async {
    versionId = '';
    final String url =
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getVersion';
    int timeout = 30;
    try {
      var res = await http.get(Uri.parse(url),
          headers: {'accept': 'application/json'}).catchError((e) {
        // SocketException would show up here, potentially after the timeout.
      }).timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body)['Daftar_Version'];
        setState(() {
          versionId = resBody[0]['version_id'];
          isReady = true;
        });
      } else {
        alert(leadsGoColor, 'Aplikasi sedang maintenance',
            'Untuk sementara waktu aplikasi sedang ada perbaikan.');
        setState(() {
          versionId = '';
          isReady = false;
        });
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Gagal koneksi ke server',
          'Mohon periksa jaringan internet kamu, dan nyalakan paket data atau wifi.');
      setState(() {
        versionId = '';
        isReady = false;
      });
    } on Error catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Aplikasi membutuhkan akses internet',
          'Mohon nyalakan paket data atau wifi untuk mengunakan aplikasi.');
      setState(() {
        versionId = '';
        isReady = false;
      });
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    SystemChrome.restoreSystemUIOverlays();
    Timer(Duration(milliseconds: 300), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: leadsGoColor, // status bar color
        statusBarBrightness: Brightness.light, //status bar brigtness
        statusBarIconBrightness: Brightness.light, //status barIcon Brightness
      ));
    });

    isReady = false;
    getAppVersion();

    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    // //Remove this method to stop OneSignal Debugging
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // OneSignal.shared.setAppId("bc3d6ade-cd42-4f2a-bca3-6c2849e849a1");

    // // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   print("Accepted permission: $accepted");
    // });

    // OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //   print('"Notification Opened: ${result}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyBuild(),
      bottomSheet: bottomSheetBuild(),
    );
  }

  Widget bodyBuild() {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Container(
      color: leadsGoColor.withOpacity(0.12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size.height * 0.15),
          FadeAnimation(
            0.5,
            Image(
              image: AssetImage('assets/LeadsGo_logo.png'),
              height: 36.5,
            ),
          ),
          FadeAnimation(
            0.6,
            Text(
              "Marketing Mobile Apps",
              style: TextStyle(
                letterSpacing: 0.80,
                fontWeight: FontWeight.normal,
                fontFamily: 'LeadsGo-Font',
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.08),
          FadeAnimation(
            0.7,
            Image(image: AssetImage('assets/LeadsGo-Welcome-Plan.png')),
          ),
          SizedBox(height: size.height * 0.01),
          FadeAnimation(
            0.8,
            Padding(
              padding: EdgeInsets.only(right: 14, left: 14),
              child: Text(
                "Nikmati berbagai layanan untuk membantu kerja kamu sebagai marketing yang hebat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.3,
                  letterSpacing: 0.50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LeadsGo-Font',
                  color: leadsGoColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          // test_debug(),
        ],
      ),
    );
  }

  Widget bottomSheetBuild() {
    if (isReady) {
      return FadeAnimation(
        0.9,
        Container(
          padding: EdgeInsets.symmetric(
            // horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Dengan melanjutakan, kamu setuju dengan',
                            style: TextStyle(
                              letterSpacing: 0.10,
                              fontFamily: 'LeadsGo-Font',
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' Syarat & Ketentuan',
                            style: TextStyle(
                              letterSpacing: 0.50,
                              fontFamily: 'LeadsGo-Font',
                              fontWeight: FontWeight.bold,
                              color: leadsGoColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'dan',
                            style: TextStyle(
                              letterSpacing: 0.10,
                              fontFamily: 'LeadsGo-Font',
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' Kebijakan Privasi',
                            style: TextStyle(
                              letterSpacing: 0.50,
                              fontFamily: 'LeadsGo-Font',
                              fontWeight: FontWeight.bold,
                              color: leadsGoColor,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            ' untuk penggunaan layanan aplikasi.',
                            style: TextStyle(
                              letterSpacing: 0.10,
                              fontFamily: 'LeadsGo-Font',
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: FlatButton(
                    height: 46,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(123),
                    ),
                    color: leadsGoColor,
                    child: Container(
                      child: Center(
                        child: Text(
                          'MULAI',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'LeadsGo-Font',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (versionIdApp != versionId) {
                        Fluttertoast.showToast(
                          msg:
                              'Versi aplikasi anda belum diupdate, mohon untuk melakukan update terlebih dahulu di playstore...',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          // fontSize: 16.0
                        );
                        _launchURL(
                            "https://play.google.com/store/apps/details?id=com.tetra.leadsgo_apps");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return FadeAnimation(
        0.9,
        Container(
          padding: EdgeInsets.symmetric(
            // horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    'Upss, kamu sedang offline',
                    style: TextStyle(
                      letterSpacing: 0.10,
                      fontFamily: 'LeadsGo-Font',
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: FlatButton(
                    height: 46,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(123),
                    ),
                    color: Colors.grey.withOpacity(0.3),
                    child: Container(
                      child: Center(
                        child: Text(
                          'LANJUTKAN',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: 'LeadsGo-Font',
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    onPressed: () {
                      getAppVersion();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  void alert(colorMessage, String headsMessage, String bodyMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    MdiIcons.earthOff,
                    color: colorMessage,
                    size: 50.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  headsMessage,
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.30,
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: colorMessage,
                    // fontSize: 14,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  bodyMessage,
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.10,
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          getAppVersion();
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          'RESET',
                          style: TextStyle(
                            color: colorMessage,
                            fontFamily: 'LeadsGo-Font',
                            fontWeight: FontWeight.bold,
                            // fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ],
              ))
            ],
          );
        });
  }
}
