import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Login/login_screen.dart';
import 'package:leadsgo_apps/Screens/WebView/webview_screen.dart';
import 'package:leadsgo_apps/Screens/Welcome/components/background.dart';
import 'package:leadsgo_apps/components/rounded_button.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String latitudeData = "";
  String longitudeData = "";

  final String url = 'https://tetranabasainovasi.com/api_marsit_v1/service.php/getVersion';
  String versionId;
  String versionIdApp = '1.0.4';

  String title = "title";
  String content = "content";

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // Position _currentPosition;
  String _currentAddress = '';
  String _currentLatitude = '';
  String _currentLongitude = '';

  // _getCurrentLocation() {
  //   geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });

  //     _getAddressFromLatLng();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);

  //     Placemark place = p[0];

  //     setState(() {
  //       _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
  //       _currentLatitude = "${place.position.latitude}";
  //       _currentLongitude = "${place.position.longitude}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void initState() {
    super.initState();
    this.getAppVersion();
    // _getCurrentLocation();
    WidgetsFlutterBinding.ensureInitialized();
    // OneSignal.shared
    //     .init("3146f435-b89d-4004-9db7-8d778386075e", iOSSettings: null);
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   setState(() {
    //     title = notification.payload.title;
    //     title = notification.payload.body;
    //   });
    // });
    // OneSignal.shared.setNotificationOpenedHandler(
    //     (OSNotificationOpenedResult notification) {
    //   print("notifikasi di tap");
    // });

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

  Future<String> getAppVersion() async {
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.get(Uri.parse(url), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body)['Daftar_Version'];
      setState(() {
        versionId = resBody[0]['version_id'];
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

  Widget build(BuildContext context) {
    print(_currentAddress);
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    if (versionId == null) {
      return Background(
        color: null,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
        ),
      );
    } else {
      return Background(
        color: leadsGoColor.withOpacity(0.14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   "Marketing Report System",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, fontFamily: 'LeadsGo-Font', color: leadsGoColor),
              // ),
              SizedBox(height: size.height * 0.05),
              Image.asset(
                // "assets/images/MARKETING-01.png",
                "assets/LeadsGo_logo.png",
                height: 40,
              ),
              // Text(
              //   "Marketing Reporting System",
              //   style: TextStyle(
              //     fontWeight: FontWeight.normal,
              //     fontFamily: 'LeadsGo-Font',
              //     color: Colors.black,
              //     fontSize: 12,
              //   ),
              // ),
              SizedBox(height: size.height * 0.10),
              Image.asset(
                // "assets/images/MARKETING-01.png",
                "assets/LeadsGo-Welcome.png",
                // height: size.height * 0.45,
              ),
              Padding(
                padding: EdgeInsets.only(right: 14, left: 14),
                child: Text(
                  "Nikmati berbagai layanan membantu kerjaan kamu sebagai marketing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.45,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LeadsGo-Font',
                    color: leadsGoColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "MASUK",
                color: leadsGoColor,
                textColor: Colors.white,
                press: () {
                  if (versionIdApp != versionId) {
                    Toast.show(
                      'Versi aplikasi anda belum diupdate, mohon untuk melakukan update terlebih dahulu di playstore...',
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.red,
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
              RoundedButton(
                text: "DAFTAR",
                color: grey,
                textColor: leadsGoColor,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
                // child: Text(
                //   'DAFTAR',
                //   style: TextStyle(
                //       color: leadsGoColor,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 10,
                //       fontFamily: 'LeadsGo-Font'),
                // ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Center(
                    child: Text(
                      'V ' + versionIdApp,
                      style: TextStyle(color: Colors.black45, fontFamily: 'LeadsGo-Font'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
