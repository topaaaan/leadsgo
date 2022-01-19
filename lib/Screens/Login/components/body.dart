import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/WebView/webview_screen.dart';
import 'package:leadsgo_apps/Screens/WebView/webview_container_screen.dart';
import 'package:leadsgo_apps/Screens/Login/components/background.dart';
import 'package:leadsgo_apps/Screens/Signup/signup_screen.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';
import 'package:leadsgo_apps/Screens/forget/forget_password_screen.dart';
import 'package:leadsgo_apps/components/already_have_an_account_acheck.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:device_info/device_info.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<Body> {
  final _links = 'https://www.nabasa.co.id/marsitacademy/Pekerjaan';
  String tokenFCM;
  void getTokenFCM() async {
    String token = await FirebaseMessaging.instance.getToken();
    tokenFCM = token;
    print('fcm_token : $token');
  }

  var personalData = new List(38);
  bool visible = false;
  bool isDeveloper = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool checkedValue = false;
  String usernamePref;
  String passwordPref;

  String deviceName;
  String deviceBrand;
  String deviceModel;
  String deviceId;
  String deviceAndroidId;

  // Function Permission Get Location
  bool geolocator;
  String currentAddress = '';
  String currentLatitude = '';
  String currentLongitude = '';
  Position currentposition;
  // ignore: missing_return
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        geolocator = true;
      });
      Fluttertoast.showToast(msg: 'Please Keep your location on.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission is denied!');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  MdiIcons.mapMarkerCheckOutline,
                  color: leadsGoColor,
                  size: 50.0,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Aplikasi membutuhkan akses lokasi',
                // textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.3,
                  letterSpacing: 0.30,
                  fontFamily: 'LeadsGo-Font',
                  fontWeight: FontWeight.bold,
                  color: leadsGoColor,
                  // fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Nyalakan akses lokasi untuk mendukung pengunaan aplikasi dan informasi terbaru',
                // textAlign: TextAlign.left,
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
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        'TIDAK, TERIMAKASIH',
                        style: TextStyle(
                          color: leadsGoColor,
                          fontFamily: 'LeadsGo-Font',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Geolocator.openAppSettings();
                        Geolocator.openLocationSettings();
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: leadsGoColor,
                          fontFamily: 'LeadsGo-Font',
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ],
            ))
          ],
        ),
      );
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        geolocator = false;
        currentposition = position;
        currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        currentLatitude = currentposition.latitude.toString();
        currentLongitude = currentposition.longitude.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  // Funtion Device Info
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
      deviceName = _deviceData['device'];
      deviceBrand = _deviceData['brand'];
      deviceModel = _deviceData['model'];
      deviceId = _deviceData['id'];
      deviceAndroidId = _deviceData['androidId'];
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  Future<void> setPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);
    prefs.setString('password', passwordController.text);
  }

  void launchWhatsApp(
      {@required String phone, @required String message}) async {
    String url() {
      return "https://wa.me/$phone/?text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    usernamePref = preferences.getString("username");
    passwordPref = preferences.getString("password");
    if (usernamePref != null && passwordPref != null) {
      if (usernamePref == 'ADMIN181' && passwordPref == '317510240') {
        removePref();
      } else {
        setState(() {
          usernameController.text = usernamePref;
          passwordController.text = passwordPref;
          checkedValue = true;
        });
      }
    }
  }

  removePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("username");
    preferences.remove("password");
  }

  Future userLogin() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    String username = usernameController.text;
    String password = passwordController.text;

    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSmartLogin');

    //starting web api call
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
      'location': currentAddress,
      'latitude': currentLatitude,
      'longitude': currentLongitude,
      'on_device':
          '$deviceName/$deviceBrand/$deviceModel/$deviceId/Android_ID:$deviceAndroidId',
      'token': tokenFCM,
    });

    if (username == '' || password == '') {
      setState(() {
        visible = false;
      });
      alert(Colors.red, 'Login Gagal',
          'Mohon masukkan username atau password dengan benar.');
      // Showing Alert Dialog with Response JSON Message.
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: new Text('Login gagal, mohon masukkan username atau password yang benar'),
      //       actions: <Widget>[
      //         FlatButton(
      //           child: new Text("OK"),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    } else {
      //if the response message is matched
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Daftar_Login'];
        print(message['total_pencairan']);
        if (message['message'].toString() == 'Login Success') {
          if (message['status_account'] == 'SUSPEND') {
            setState(() {
              visible = false;
            });
            // Showing Alert Dialog with Response JSON Message.
            alert(Colors.red, 'Akun di Suspend',
                'Mohon hubungi bantuan atau periksa kembali username atau password yang kamu masukkan dengan benar.');
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: new Text('Login gagal, Account kamu di suspend, mohon hubungi IT Support'),
            //       actions: <Widget>[
            //         FlatButton(
            //           child: new Text("OK"),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
          } else {
            getNotifAbsen();
            setState(() {
              visible = false;
              personalData[0] = message['nik'];
              personalData[1] = message['full_name'];
              personalData[2] = message['marital_status'];
              personalData[3] = message['date_of_birth'];
              personalData[4] = message['place_of_birth'];
              personalData[5] = message['no_ktp'];
              personalData[6] = message['gender'];
              personalData[7] = message['religion'];
              personalData[8] = message['email_address'];
              personalData[9] = message['phone_number'];
              personalData[10] = message['education'];
              personalData[11] = message['alamat'];
              personalData[12] = message['kelurahan'];
              personalData[13] = message['kecamatan'];
              personalData[14] = message['kabupaten'];
              personalData[15] = message['kode_pos'];
              personalData[16] = message['propinsi'];
              personalData[17] = message['no_rekening'];
              personalData[18] = message['nama_bank'];
              personalData[19] = message['nama_rekening'];
              personalData[20] = message['divisi_karyawan'];
              personalData[21] = message['jabatan_karyawan'];
              personalData[22] = message['wilayah_karyawan'];
              personalData[23] = message['branch'];
              personalData[24] = message['status_karyawan'];
              personalData[25] = message['grade_karyawan'];
              personalData[26] = message['gaji_pokok'];
              personalData[27] = message['tunjangan_tkd'];
              personalData[28] = message['tunjangan_jabatan'];
              personalData[29] = message['tunjangan_perumahan'];
              personalData[30] = message['tunjangan_telepon'];
              personalData[31] = message['tunjangan_kinerja'];
              personalData[32] = message['nik_marsit'];
              personalData[33] = message['diamond'];
              personalData[34] = message['total_pencairan'];
              personalData[35] = message['total_interaksi'];
              personalData[36] = message['tipe'];
              personalData[37] = message['tgl_cut_off'];
            });
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                      username,
                      message['nik_marsit'],
                      message['income'],
                      message['full_name'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['full_name'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            }
            Size size = MediaQuery.of(context).size;
          }
        } else {
          if (message['status_account'] == 'NOTSET') {
            setState(() {
              visible = false;
            });
            // Showing Alert Dialog with Response JSON Message.
            alert(leadsGoColor, 'Akun Tidak Diketahui',
                'Mohon periksa kembali username atau password yang kamu masukkan.');
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title:
            //           new Text('Login Failed, Your Account is Notset, Please Contact Kantor Pusat'),
            //       actions: <Widget>[
            //         FlatButton(
            //           child: new Text("OK"),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
          } else {
            setState(() {
              visible = false;
            });
            // Showing Alert Dialog with Response JSON Message.
            alert(leadsGoColor, 'Akun Tidak Diketahui',
                'Mohon periksa kembali username atau password yang kamu masukkan.');
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: new Text('Login Failed, Please Check Your Username or Password'),
            //       actions: <Widget>[
            //         FlatButton(
            //           child: new Text("OK"),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
          }
        }
      } else {
        print('error');
      }
    }
  }

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void initState() {
    getTokenFCM();
    geolocator = false;
    // _determinePosition();
    initPlatformState();
    isDeveloper = false;
    // SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.dark, //status bar brigtness
      statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    ));
    super.initState();
    this.getPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (tokenFCM != '') {
      return WillPopScope(
        onWillPop: () async {
          print('Back Button pressed!');
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
              (route) => false);
        },
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: size.height * 0.02),
                // Text(
                //   "Selamat Datang",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //     fontFamily: 'LeadsGo-Font',
                //     color: Colors.black,
                //   ),
                // ),
                SizedBox(height: size.height * 0.02),
                Image.asset(
                  "assets/images/welcome.png",
                  height: size.height * 0.30,
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                      color: leadsGoColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textCapitalization: TextCapitalization.characters,
                    autocorrect: true,
                    controller: usernameController,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1.0),
                        borderRadius: BorderRadius.circular(123.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: leadsGoColor, width: 1.5),
                        borderRadius: BorderRadius.circular(123.0),
                      ),

                      hintText: "Username",
                      hintStyle: TextStyle(
                          fontFamily: 'LeadsGo-Font', color: Colors.black45),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black38, width: 1.0),
                        borderRadius: BorderRadius.circular(123.0),
                      ),
                      prefixIcon: Icon(
                        MdiIcons.accountCircleOutline,
                        color: leadsGoColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: _isHidden,
                    controller: passwordController,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1.0),
                        borderRadius: BorderRadius.circular(123.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: leadsGoColor, width: 1.5),
                        borderRadius: BorderRadius.circular(123.0),
                      ),
                      hintText: "Kata Sandi",
                      hintStyle: TextStyle(
                          fontFamily: 'LeadsGo-Font', color: Colors.black45),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black38, width: 1.0),
                        borderRadius: BorderRadius.circular(123.0),
                      ),
                      prefixIcon: Icon(
                        MdiIcons.lock,
                        color: leadsGoColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _toggleVisibility();
                        },
                        icon: _isHidden == true
                            ? Icon(
                                MdiIcons.eyeOutline,
                                color: leadsGoColor,
                              )
                            : Icon(
                                MdiIcons.eyeOff,
                                color: leadsGoColor,
                              ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                      color: leadsGoColor,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              checkedValue = !checkedValue;
                            });
                            if (checkedValue == true) {
                              setPref();
                            } else {
                              removePref();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Checkbox(
                                  value: checkedValue,
                                  activeColor: leadsGoColor,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = !checkedValue;
                                    });
                                    if (checkedValue == true) {
                                      setPref();
                                    } else {
                                      removePref();
                                    }
                                  },
                                ),
                                // you can control gap between checkbox and label with this field
                                Flexible(
                                  child: Text(
                                    'Simpan username',
                                    style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen()));
                          },
                          child: Text(
                            'Lupa password ?',
                            style: TextStyle(
                              color: leadsGoColor,
                              fontFamily: 'LeadsGo-Font',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      color: leadsGoColor, //MENGATUR WARNA TOMBOL
                      onPressed: () {
                        //PERINTAH YANG AKAN DIEKSEKUSI KETIKA TOMBOL DITEKAN
                        userLogin();
                        //getNotifAbsen();
                        FocusScope.of(context).unfocus();
                        isDeveloper = false;
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(123)),
                      child: visible
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              height: 20.0,
                              width: 20.0,
                            )
                          : Text(
                              'MASUK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'LeadsGo-Font',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'LeadsGo-Font',
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchURL(_links);
                      },
                      child: Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          color: leadsGoColor,
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            isDeveloper = true;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            isDeveloper = false;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Visibility(visible: isDeveloper, child: developer()),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Container(
            child: SpinKitDoubleBounce(
              itemBuilder: (_, int index) {
                // return DecoratedBox(
                //   decoration: BoxDecoration(
                //     color: index.isEven ? Colors.red : Colors.green,
                //   ),
                // );
                return index.isEven
                    ? Image(
                        image: AssetImage('assets/leadsgo-go-icon.png'),
                        color: leadsGoColor.withOpacity(0.2),
                      )
                    : Image(
                        image: AssetImage('assets/leadsgo-go-icon.png'),
                      );
              },
              size: 120.0,
            ),
          ),
        ),
      );
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  Widget alert(colorMessage, String headsMessage, String bodyMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    MdiIcons.alertCircleOutline,
                    color: colorMessage,
                    size: 50.0,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    headsMessage,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                      height: 1.3,
                      letterSpacing: 0.30,
                      fontFamily: 'LeadsGo-Font',
                      fontWeight: FontWeight.bold,
                      color: colorMessage,
                      // fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    bodyMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.3,
                      letterSpacing: 0.10,
                      fontFamily: 'LeadsGo-Font',
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kesulitan masuk?',
                      style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String teleponFix = '+62' + '081318367541';
                        launchWhatsApp(
                            phone: teleponFix,
                            message: 'Saya butuh bantuan login, ');
                      },
                      child: Text(
                        'Hubungi Bantuan',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: 'LeadsGo-Font',
                          // fontWeight: FontWeight.bold,
                          // fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
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
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          'OK',
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

  // khusus developer
  Widget developer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Brand : " + _deviceData['brand'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Device : ' + _deviceData['device'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Display : ' + _deviceData['display'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Fingerprint : ' + _deviceData['fingerprint'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hardware : ' + _deviceData['hardware'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Host : ' + _deviceData['host'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ID : ' + _deviceData['id'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Manufacture : ' + _deviceData['manufacturer'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Model : ' + _deviceData['model'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Product : ' + _deviceData['product'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Type : ' + _deviceData['type'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Android ID : ' + _deviceData['androidId'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'OS Version : Android ${_deviceData['version.release']}\nSDK Version : API ${_deviceData['version.sdkInt']}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Address : $currentAddress\nLatitude : $currentLatitude\nLongitude : $currentLongitude',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'TokenFCM : $tokenFCM',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getNotifAbsen() async {
    String password = passwordController.text;

    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/notifcekDailyAbsence');

    //starting web api call
    var response = await http.post(url, body: {
      'nik': password,
    });

    //if the response message is matched
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['status'];
      print(message);
    } else {
      print(response);
    }
  }
}
