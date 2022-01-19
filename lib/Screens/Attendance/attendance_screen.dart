import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
// import 'package:leadsgo_apps/Screens/Attendance/directions_model.dart';
// import 'package:leadsgo_apps/Screens/Attendance/directions_repository.dart';
import 'package:leadsgo_apps/Screens/Attendance/camera.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
// import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';

class Attendance extends StatefulWidget {
  String username;
  String nik;
  File imageFile;

  @override
  Attendance(
    this.username,
    this.nik,
    this.imageFile,
  );

  State<Attendance> createState() => AttendanceState();
}

class AttendanceState extends State<Attendance> with TickerProviderStateMixin {
  getNamaHari(String dayText) {
    switch (dayText) {
      case 'Monday':
        return 'Senin';
        break;
      case 'Tuesday':
        return 'Selasa';
        break;
      case 'Wednesday':
        return 'Rabu';
        break;
      case 'Thursday':
        return 'Kamis';
        break;
      case 'Friday':
        return 'Jumat';
        break;
      case 'Saturday':
        return 'Sabtu';
        break;
      case 'Sunday':
        return 'Minggu';
        break;
    }
  }

// CLASS AttendanceState
  // // FUNC. Geolocation
  // bool geolocator;
  // String currentAddress;
  // double currentLatitude;
  // double currentLongitude;
  // Position currentposition;
  // var _lokasiKamu;
  // Future _determinePosition() async {
  //   bool ServiceEnabled;
  //   LocationPermission permission;

  //   ServiceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!ServiceEnabled) {
  //     setState(() {
  //       geolocator = true;
  //     });
  //     Fluttertoast.showToast(msg: 'Please Keep your location on.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();

  //     if (permission == LocationPermission.denied) {
  //       Fluttertoast.showToast(msg: 'Location Permission is denied!');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => AlertDialog(
  //         title: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: Icon(
  //                 MdiIcons.mapMarkerCheckOutline,
  //                 color: leadsGoColor,
  //                 size: 50.0,
  //               ),
  //             ),
  //             SizedBox(height: 15),
  //             Text(
  //               'Aplikasi membutuhkan akses lokasi',
  //               // textAlign: TextAlign.left,
  //               style: TextStyle(
  //                 height: 1.3,
  //                 letterSpacing: 0.30,
  //                 fontFamily: 'LeadsGo-Font',
  //                 fontWeight: FontWeight.bold,
  //                 color: leadsGoColor,
  //                 // fontSize: 14,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               'Nyalakan akses lokasi untuk mendukung pengunaan aplikasi dan informasi terbaru',
  //               // textAlign: TextAlign.left,
  //               style: TextStyle(
  //                 height: 1.3,
  //                 letterSpacing: 0.10,
  //                 fontFamily: 'LeadsGo-Font',
  //                 fontWeight: FontWeight.normal,
  //                 color: Colors.black54,
  //                 fontSize: 14,
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           Center(
  //               child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 // crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context, false);
  //                     },
  //                     child: Text(
  //                       'TIDAK, TERIMAKASIH',
  //                       style: TextStyle(
  //                         color: leadsGoColor,
  //                         fontFamily: 'LeadsGo-Font',
  //                       ),
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       Geolocator.openAppSettings();
  //                       Geolocator.openLocationSettings();
  //                       Navigator.pop(context, false);
  //                     },
  //                     child: Text(
  //                       'OK',
  //                       style: TextStyle(
  //                         color: leadsGoColor,
  //                         fontFamily: 'LeadsGo-Font',
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 15),
  //                 ],
  //               ),
  //             ],
  //           ))
  //         ],
  //       ),
  //     );
  //   }

  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);

  //     Placemark place = placemarks[0];

  //     setState(() {
  //       geolocator = false;
  //       currentposition = position;
  //       currentAddress =
  //           "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
  //       currentLatitude = currentposition.latitude;
  //       currentLongitude = currentposition.longitude;
  //       _lokasiKamu = LatLng(currentposition.latitude, currentposition.longitude);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // // .END Geolocation

  // // FUNC. GET BRANCH LOCATION
  // var branchLatitude;
  // var branchLongitude;
  // String kantorCabang = '';
  // var _lokasiKCP;
  // Future getBranchLocation() async {
  //   final url =
  //       Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getBranchLocation');
  //   int timeout = 30;
  //   try {
  //     var response =
  //         await http.post(url, body: {'nik': widget.nik}).timeout(Duration(seconds: timeout));

  //     if (response.statusCode == 200) {
  //       var message = json.decode(response.body)['Branch_KC'];
  //       // _makerInfo(LatLng(double.parse(message[0]['LAT']), double.parse(message[0]['LNG'])));
  //       setState(() {
  //         kantorCabang = message[0]['NAMA'].toString();
  //         branchLatitude = double.parse(message[0]['LAT']);
  //         branchLongitude = double.parse(message[0]['LNG']);
  //         _lokasiKCP = LatLng(double.parse(message[0]['LAT']), double.parse(message[0]['LNG']));
  //       });
  //     } else {
  //       alert(leadsGoColor, 'Aplikasi sedang maintenance',
  //           'Untuk sementara waktu aplikasi sedang ada perbaikan.');
  //     }
  //   } on TimeoutException catch (e) {
  //     print('Timeout Error: $e');
  //     alert(leadsGoColor, 'Gagal koneksi ke server',
  //         'Mohon periksa jaringan internet kamu, dan nyalakan paket data atau wifi.');
  //   } on Error catch (e) {
  //     print('Timeout Error: $e');
  //     alert(leadsGoColor, 'Aplikasi membutuhkan akses internet',
  //         'Mohon nyalakan paket data atau wifi untuk mengunakan aplikasi.');
  //   }
  // }
  // // END. GET BRANCH LOCATION

  // FUNC. CEK DAILY ABSENCE
  bool isAvailable;
  bool cekLibur;
  Future cekAbsenceAvailable() async {
    setState(() {
      isAvailable = false;
      cekLibur = false;
    });
    int timeout = 30;
    final String url =
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/cekDailyAbsence';
    try {
      var res = await http.post(Uri.parse(url),
          body: {'nik_id': widget.nik}).timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body)['daily_absence'];

        setState(() {
          if (resBody == 'available') {
            isAvailable = false;
          } else if (resBody == 'libur') {
            isAvailable = false;
            cekLibur = true;
          } else {
            isAvailable = true;
          }
        });
      } else {
        alert(leadsGoColor, 'Aplikasi sedang maintenance',
            'Untuk sementara waktu aplikasi sedang ada perbaikan.');
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Gagal koneksi ke server',
          'Mohon periksa jaringan internet kamu, dan nyalakan paket data atau wifi.');
    } on Error catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Aplikasi membutuhkan akses internet',
          'Mohon nyalakan paket data atau wifi untuk mengunakan aplikasi.');
    }
  }
  // FUNC. CEK DAILY ABSENCE

  // FUNC. GET SET OPENING ATTENDANCE
  double setDistance;
  String setTimeIn;
  String setTimeOut;
  bool timeReady;
  Future getWaktuAbsen() async {
    int timeout = 30;
    final String url =
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getWaktuAbsen';
    try {
      var res =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: timeout));
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body)['distance'];

        String timeNow = DateFormat.Hm().format(DateTime.now());
        DateTime fixTimeNow = DateFormat.Hm().parse(timeNow);
        DateTime openTime = DateFormat.Hm().parse(resBody[0]['set_time_in']);
        DateTime closeTime = DateFormat.Hm()
            .parse(resBody[0]['set_time_out'])
            .add(Duration(minutes: 1));

        setState(() {
          setDistance = double.parse(resBody[0]['value']);
          setTimeIn = resBody[0]['set_time_in'];
          setTimeOut = resBody[0]['set_time_out'];

          if (openTime.isBefore(fixTimeNow) && closeTime.isAfter(fixTimeNow) ||
              openTime.isAtSameMomentAs(fixTimeNow)) {
            if (fixTimeNow.isAfter(closeTime)) {
              timeReady = false;
            } else {
              timeReady = true;
            }
          } else {
            timeReady = false;
          }
        });

        if (_imageFile != null) {
          await modalNext();
        }
      } else {
        alert(leadsGoColor, 'Aplikasi sedang maintenance',
            'Untuk sementara waktu aplikasi sedang ada perbaikan.');
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Gagal koneksi ke server',
          'Mohon periksa jaringan internet kamu, dan nyalakan paket data atau wifi.');
    } on Error catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Aplikasi membutuhkan akses internet',
          'Mohon nyalakan paket data atau wifi untuk mengunakan aplikasi.');
    }
  }
  // FUNC. GET SET OPENING ATTENDANCE

  // FUNC. Controller Google Maps
  // GoogleMapController _googleMapController;
  // Directions _info;
  // bool isTarget;
  // bool onRoute;
  // Future _makerInfo(LatLng pos) async {
  //   // Get directions
  //   final directions =
  //       await DirectionsRepository().getDirections(origin: _lokasiKamu, destination: pos);
  //   setState(() {
  //     _info = directions;
  //   });
  //   // setState(() => );
  // }
  // .END Controller Google Maps

  // // SET Marker Maps
  // Set<Marker> _createMarker() {
  //   return {
  //     Marker(
  //       markerId: MarkerId('Kamu'),
  //       infoWindow: const InfoWindow(title: 'Kamu'),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  //       position: _lokasiKamu,
  //     ),
  //     Marker(
  //       markerId: MarkerId('Kantor'),
  //       infoWindow: const InfoWindow(title: 'Kantor'),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //       position: _lokasiKCP,
  //     ),
  //   };
  // }
  // // .END Marker Maps

  // SET GET DATA
  final usernameController = TextEditingController();
  final positionController = TextEditingController();
  File _imageFile;
  String base64Image;
  String fileName;
  Future setDataState() async {
    try {
      cekAbsenceAvailable();
      // _determinePosition();
      // getBranchLocation();
      getWaktuAbsen();
      // _makerInfo(_lokasiKCP);
    } catch (e) {
      print(e);
    }

    setState(() {
      // usernameController.text = widget.username;
      // positionController.text = currentAddress;
      isAvailable = false;
      timeReady = false;
      isNext = false;
      // isTarget = false;
      // onRoute = false;
    });
  }
  // .END SET DATA

  // CLEAR CACHE
  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    String directoryPath = '${cacheDir.path}/absen_picture/';

    if (cacheDir.existsSync()) {
      // cacheDir.deleteSync(recursive: true);
      Directory(directoryPath).deleteSync(recursive: true);
    }
  }
  // .END CLEAR CACHE

  @override
  void initState() {
    _imageFile = widget.imageFile;
    this.setDataState();
    super.initState();
  }

  @override
  void dispose() {
    // _googleMapController.dispose();
    deleteCacheDir();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dayText = DateFormat.EEEE().format(DateTime.now());
    String namaHari = getNamaHari(dayText);

    // final _initialCameraPosition = CameraPosition(
    //   target: _lokasiKCP != null ? _lokasiKCP : LatLng(0.0, 0.0),
    //   zoom: 11.5,
    // );

    // Future.delayed(const Duration(milliseconds: 100), () {
    //   _makerInfo(_lokasiKCP);
    // });

    Size size = MediaQuery.of(context).size;

    if (
        // _info != null &&
        // _lokasiKamu != null &&
        // _lokasiKCP != null
        setTimeIn != null) {
      return WillPopScope(
        onWillPop: () async {
          print('Back Button pressed!');
          final shouldPop = await _onBackPressed(context);
          return shouldPop;
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: leadsGoColor,
              centerTitle: false,
              title: const Text(
                'Absen Kehadiran',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LeadsGo-Font',
                ),
              ),
              // actions: [
              //   Container(
              //     padding: EdgeInsets.only(right: 10),
              //     child: TextButton(
              //         onPressed: () => {
              //               // modalShowGetAbsence('GAGAL', '', '13:00'),
              //               setState(() {
              //                 _lokasiKamu = null;
              //                 _imageFile = null;
              //                 // onRoute = false;
              //                 isNext = false;
              //               }),
              //               cekAbsenceAvailable(),
              //               deleteCacheDir(),
              //               _determinePosition(),
              //               getBranchLocation(),
              //               getWaktuAbsen(),
              //             },
              //         style: TextButton.styleFrom(
              //           primary: Colors.white,
              //           textStyle: const TextStyle(fontWeight: FontWeight.w600),
              //         ),
              //         child: Row(
              //           children: [
              //             Icon(
              //               MdiIcons.refresh,
              //               color: Colors.white,
              //             ),
              //             Text('Refresh',
              //                 style: TextStyle(
              //                   letterSpacing: 0.80,
              //                   fontWeight: FontWeight.bold,
              //                   fontFamily: 'LeadsGo-Font',
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 )),
              //           ],
              //         )),
              //   ),
              // ],
            ),
            // body: FadeAnimation(
            //   0.1,
            // _lokasiKamu != null
            // && _info != null
            // ?
            // Container(
            //   padding: EdgeInsets.only(bottom: size.height * 0.15),
            //   alignment: Alignment.center,
            //   child: Stack(
            //     alignment: Alignment.topCenter,
            //     children: [
            // GoogleMap(
            //   myLocationButtonEnabled: false,
            //   zoomControlsEnabled: false,
            //   initialCameraPosition: _initialCameraPosition,
            //   onMapCreated: (controller) => _googleMapController = controller,
            //   liteModeEnabled: false,

            //   // markers: {if (_origin != null) _origin, if (_destination != null) _destination},
            //   markers: _createMarker(),

            //   polylines: {
            //     if (_info != null && onRoute == true)
            //       Polyline(
            //         polylineId: PolylineId('poly'),
            //         color: _info.totalDistanceValue > setDistance
            //             ? Colors.red
            //             : leadsGoColor,
            //         width: 5,
            //         points: _info.polylinePoints
            //             .map((e) => LatLng(e.latitude, e.longitude))
            //             .toList(),
            //       ),
            //   },
            //   // onLongPress: _makerInfo,
            // ),

            // if (_info != null)
            // Positioned(
            //   top: 20.0,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 6.0,
            //       horizontal: 12.0,
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(0.8),
            //       borderRadius: BorderRadius.circular(20.0),
            //       boxShadow: const [
            //         BoxShadow(
            //           color: Colors.black26,
            //           offset: Offset(0, 2),
            //           blurRadius: 6.0,
            //         )
            //       ],
            //     ),
            //     child: Text(
            //       // '${_info.totalDistance}, ${_info.totalDuration}',
            //       'Jarak ke kantor ${_info.totalDistance},\nbutuh waktu ${_info.totalDuration}',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         letterSpacing: 0.80,
            //         fontWeight: FontWeight.normal,
            //         fontFamily: 'LeadsGo-Font',
            //         color: Colors.black54,
            //         fontSize: 14,
            //       ),
            //     ),
            //   ),
            // ),
            // ],
            // ),
            // ),
            // :
            // Container(
            //     padding: EdgeInsets.only(bottom: size.height * 0.15),
            //     color: Colors.grey.shade200,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Center(
            //           child: Container(
            //             child: SpinKitDoubleBounce(
            //               color: Colors.blueAccent.withOpacity(0.2),
            //               size: 100.0,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // floatingActionButton:
            // FadeAnimation(
            //   0.2,
            //   Container(
            //     height: size.width * 0.8,
            //     child: Column(
            //       // mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Container(
            //           width: 45.0,
            //           height: 45.0,
            //           child: FloatingActionButton(
            //             backgroundColor: Colors.grey.shade200,
            //             foregroundColor: Colors.black38,
            //             onPressed: () => {
            //               _googleMapController.animateCamera(
            //                 _info != null
            //                     ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
            //                     : CameraUpdate.newCameraPosition(_initialCameraPosition),
            //               ),
            //               setState(() {
            //                 // _lokasiKamu = null;
            //                 onRoute = false;
            //               }),
            //               _determinePosition(),
            //               getBranchLocation(),
            //               getWaktuAbsen(),
            //             },
            //             child: const Icon(
            //               MdiIcons.refreshCircle,
            //               size: 30,
            //             ),
            //           ),
            //         ),
            //         SizedBox(height: 15),
            //         // Container(
            //         //   width: 45.0,
            //         //   height: 45.0,
            //         //   child: FloatingActionButton(
            //         //     backgroundColor: Colors.blueAccent,
            //         //     foregroundColor: Colors.white,
            //         //     onPressed: () => {
            //         //       _googleMapController.animateCamera(
            //         //         CameraUpdate.newCameraPosition(
            //         //           CameraPosition(
            //         //             target: _lokasiKamu,
            //         //             zoom: 16.5,
            //         //             tilt: 50.0,
            //         //           ),
            //         //         ),
            //         //       ),
            //         //     },
            //         //     child: const Icon(MdiIcons.humanHandsup),
            //         //   ),
            //         // ),
            //         // SizedBox(height: 10),
            //         // Container(
            //         //   width: 45.0,
            //         //   height: 45.0,
            //         //   child: FloatingActionButton(
            //         //     backgroundColor: Colors.redAccent,
            //         //     foregroundColor: Colors.white,
            //         //     onPressed: () {
            //         //       _googleMapController.animateCamera(
            //         //         CameraUpdate.newCameraPosition(
            //         //           CameraPosition(
            //         //             target: _lokasiKCP,
            //         //             zoom: 16.5,
            //         //             tilt: 50.0,
            //         //           ),
            //         //         ),
            //         //       );
            //         //       setState(() {
            //         //         isTarget = false;
            //         //       });
            //         //     },
            //         //     child: const Icon(MdiIcons.officeBuildingMarkerOutline),
            //         //   ),
            //         // ),
            //         // SizedBox(height: 10),
            //         Container(
            //           width: 53.0,
            //           height: 53.0,
            //           child: FloatingActionButton(
            //             backgroundColor: Colors.white,
            //             foregroundColor: Colors.blue,
            //             onPressed: () {
            //               if (isTarget) {
            //                 _googleMapController.animateCamera(
            //                   _info != null
            //                       ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
            //                       : CameraUpdate.newCameraPosition(_initialCameraPosition),
            //                 );
            //                 setState(() {
            //                   isTarget = false;
            //                 });
            //               } else {
            //                 _googleMapController.animateCamera(
            //                   CameraUpdate.newCameraPosition(
            //                     CameraPosition(
            //                       target: _lokasiKamu,
            //                       zoom: 18.5,
            //                       tilt: 50.0,
            //                     ),
            //                   ),
            //                 );
            //                 setState(() {
            //                   isTarget = true;
            //                 });
            //               }
            //             },
            //             child: isTarget
            //                 ? Icon(
            //                     MdiIcons.compass,
            //                     size: 25,
            //                   )
            //                 : Icon(
            //                     MdiIcons.crosshairsGps,
            //                     size: 25,
            //                   ),
            //           ),
            //         ),
            //         SizedBox(height: 20),
            //         Container(
            //           width: 55.0,
            //           height: 55.0,
            //           child: FloatingActionButton(
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //             backgroundColor: leadsGoColor,
            //             foregroundColor: Colors.white,
            //             onPressed: () {
            //               if (onRoute) {
            //                 _googleMapController.animateCamera(
            //                   _info != null
            //                       ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
            //                       : CameraUpdate.newCameraPosition(_initialCameraPosition),
            //                 );
            //                 setState(() {
            //                   isTarget = false;
            //                   onRoute = false;
            //                 });
            //               } else {
            //                 _googleMapController.animateCamera(
            //                   _info != null
            //                       ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
            //                       : CameraUpdate.newCameraPosition(_initialCameraPosition),
            //                 );
            //                 setState(() {
            //                   isTarget = false;
            //                   onRoute = true;
            //                 });
            //               }
            //             },
            //             child: Icon(
            //               MdiIcons.directions,
            //               size: 28,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            body:
                // _lokasiKamu != null ?
                FadeAnimation(
              0.3,
              Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: new BorderRadius.only(
                  //     topLeft: const Radius.circular(30.0),
                  //     topRight: const Radius.circular(30.0),
                  //   ),
                  // ),
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                  // height: size.width * 0.50,
                  // width: size.width,
                  child:
                      // _lokasiKamu != null ?
                      Center(
                    child: FadeAnimation(
                      0.1,
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            MdiIcons.informationOutline,
                            size: 60,
                            color: isAvailable == false
                                ? Colors.green
                                : Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              '$namaHari, ${DateFormat("dd").format(DateTime.now())} ${bulan} ${DateFormat("yyyy").format(DateTime.now())}',
                              style: TextStyle(
                                // letterSpacing: 0.2,
                                color: Colors.black87,
                                // fontWeight: FontWeight.bold,
                                fontFamily: 'LeadsGo-Font',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              descJarak(),
                              // 'Terima kasih hari ini kamu sudah absen,\nbesok jangan terlambat absen lagi ya!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.4,
                                color: isAvailable == false
                                    ? Colors.green
                                    : leadsGoColor,
                                fontFamily: 'LeadsGo-Font',
                                fontSize: 19,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(16, 23, 16, 23),
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Dapatkan poin kamu setiap harinya dan tukarkan menjadi pulsa, listrik, atau reedem ke E-Wallet',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.2,
                                      color: leadsGoColor,
                                      fontFamily: 'LeadsGo-Font',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Absen dilakukan pada hari kerja pukul ${setTimeIn.substring(0, 5)} - ${setTimeOut.substring(0, 5)} WIB',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontFamily: 'LeadsGo-Font',
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          timeReady == true
                                  // && _lokasiKamu != null
                                  &&
                                  isAvailable == true
                              ? FadeAnimation(
                                  1,
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10, left: 20, right: 20),
                                    // height: size.height * 0.1,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: TextButton(
                                            onPressed: () {
                                              modalNext();
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      EdgeInsets.symmetric(
                                                          vertical: 12)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(leadsGoColor),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          123),
                                                ),
                                              ),
                                            ),
                                            child: isNext == true
                                                ? SizedBox(
                                                    height: 19,
                                                    child: SpinKitThreeBounce(
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  )
                                                : Text(
                                                    'ABSEN SEKARANG',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'LeadsGo-Font',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),

                          // !isAvailable
                          //     ? Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Icon(
                          //             MdiIcons.checkboxMarkedCircleOutline,
                          //             size: 30,
                          //             color: Colors.green,
                          //           ),
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           Text(
                          //             '$namaHari, ',
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               letterSpacing: 0.4,
                          //               color: Colors.green,
                          //               fontFamily: 'LeadsGo-Font',
                          //               fontSize: 18,
                          //             ),
                          //           ),
                          //           Text(
                          //             '${DateFormat("dd").format(DateTime.now())} ${namaBulan(DateFormat("MM").format(DateTime.now()).toString())} ${DateFormat("yyyy").format(DateTime.now())}',
                          //             style: TextStyle(
                          //               letterSpacing: 0.4,
                          //               fontWeight: FontWeight.normal,
                          //               height: 1.5,
                          //               color: Colors.black87,
                          //               fontFamily: 'LeadsGo-Font',
                          //               fontSize: 14,
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     :
                          // Row(
                          //     children: [
                          //       Icon(
                          //         _info.totalDistanceValue > setDistance
                          //             ? MdiIcons.run
                          //             : MdiIcons.mapMarkerRadiusOutline,
                          //         size: 40,
                          //         color: _info.totalDistanceValue > setDistance
                          //             ? Colors.blueAccent
                          //             : Colors.green,
                          //       ),
                          //       _info.totalDistanceValue > setDistance
                          //           ? Container(
                          //               child: SpinKitThreeBounce(
                          //                 color: leadsGoColor,
                          //                 size: 14.0,
                          //               ),
                          //             )
                          //           : SizedBox(),

                          //       Container(
                          //         // padding: EdgeInsets.only(left: 3),
                          //         alignment: Alignment.centerLeft,
                          //         child: Container(
                          //           padding: const EdgeInsets.symmetric(
                          //             vertical: 5.0,
                          //             horizontal: 10.0,
                          //           ),
                          //           decoration: BoxDecoration(
                          //             color: Colors.transparent,
                          //             borderRadius: BorderRadius.circular(20.0),
                          //             border: Border.all(
                          //                 color: _info.totalDistanceValue < setDistance
                          //                     ? Colors.green
                          //                     : leadsGoColor,
                          //                 width: 1.5),
                          //           ),
                          //           child: Text(
                          //             'KCP $kantorCabang',
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               fontFamily: 'LeadsGo-Font',
                          //               color: _info.totalDistanceValue < setDistance
                          //                   ? Colors.green
                          //                   : leadsGoColor,
                          //               fontSize: 15,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // SizedBox(
                          //     width: 5,
                          //   ),

                          // (widget.imageFile != null)
                          // (_imageFile != null)
                          //     ? Container(
                          //         // height: 280,
                          //         // child: Image.file(imageFile),
                          //         child: Text(
                          //           '${_imageFile}',
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             color: Colors.black54,
                          //             fontFamily: 'LeadsGo-Font',
                          //             fontSize: 10,
                          //           ),
                          //         ),
                          //       )
                          //     : SizedBox(),
                        ],
                      ),
                    ),
                  )
                  // : Center(
                  //     child: SizedBox(
                  //       height: 19,
                  //       child: SpinKitThreeBounce(
                  //         color: leadsGoColor,
                  //         size: 30,
                  //       ),
                  //     ),
                  //   ),
                  ),
            )
            // : null,
            // bottomNavigationBar:
            //     // _info.totalDistanceValue < setDistance &&

            //     timeReady == true && _lokasiKamu != null && isAvailable == true
            //         ? FadeAnimation(
            //             1,
            //             Container(
            //               margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
            //               height: size.height * 0.1,
            //               child: Stack(
            //                 children: [
            //                   Container(
            //                     width: double.infinity,
            //                     child: TextButton(
            //                       onPressed: () {
            //                         modalNext();
            //                       },
            //                       style: ButtonStyle(
            //                         padding: MaterialStateProperty.all<EdgeInsets>(
            //                             EdgeInsets.symmetric(vertical: 12)),
            //                         backgroundColor: MaterialStateProperty.all<Color>(leadsGoColor),
            //                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //                           RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(123),
            //                           ),
            //                         ),
            //                       ),
            //                       child: isNext == true
            //                           ? SizedBox(
            //                               height: 19,
            //                               child: SpinKitThreeBounce(
            //                                 color: Colors.white,
            //                                 size: 20,
            //                               ),
            //                             )
            //                           : Text(
            //                               'LANJUTKAN',
            //                               style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontFamily: 'LeadsGo-Font',
            //                                 fontSize: 16,
            //                                 fontWeight: FontWeight.bold,
            //                                 letterSpacing: 0.5,
            //                               ),
            //                             ),
            //                     ),
            //                   ),
            //                   Align(
            //                     alignment: Alignment.bottomCenter,
            //                     child: Text(
            //                       'Absen $namaHari, ${DateFormat("dd").format(DateTime.now())} ${namaBulan(DateFormat("MM").format(DateTime.now()).toString())} ${DateFormat("yyyy").format(DateTime.now())}',
            //                       style: TextStyle(
            //                         // letterSpacing: 0.2,
            //                         color: leadsGoColor,
            //                         fontFamily: 'LeadsGo-Font',
            //                         fontSize: 14,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )
            //         : null,
            ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: SpinKitThreeBounce(
                    color: leadsGoColor.withOpacity(0.2),
                    size: 50.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  bool isNext;
  // String base64Image;
  Future modalNext() async {
    setState(() {
      isNext = true;
    });
    // base64Image = base64Encode(imageFile.readAsBytesSync());
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kirim Bukti Kehadiran',
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.30,
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: leadsGoColor,
                    // fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Mohon sertakan foto kamu bersama petugas di lokasi kantor cabang!',
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
              ],
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // (widget.imageFile != null)
                    (_imageFile != null)
                        ? Container(
                            height: 280,
                            // child: Image.file(File(widget.imageFile.path)),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                      image: AssetImage("assets/bg-cloud.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Image.file(
                                    widget.imageFile,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);

                                      Future.delayed(Duration(milliseconds: 50),
                                          () {
                                        deleteCacheDir();
                                        modalNext();
                                      });
                                      // modalNext();
                                      setState(() {
                                        isNext = false;
                                        _imageFile = null;
                                      });
                                    },
                                    icon: Icon(MdiIcons.closeCircleOutline),
                                    iconSize: 35,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ))
                        : InkWell(
                            child: Container(
                              color: Colors.grey.withOpacity(0.1),
                              height: 200,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(MdiIcons.camera,
                                      color: leadsGoColor, size: 50),
                                  Text(
                                    'Ambil Foto Selfie',
                                    style: TextStyle(
                                      color: leadsGoColor,
                                      fontFamily: 'LeadsGo-Font',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              Navigator.pop(context);
                              // imageFile = await Navigator.push<File>(
                              //     context, MaterialPageRoute(builder: (_) => Camera()));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          Camera(widget.username, widget.nik)));
                              setState(() {
                                isNext = true;
                              });
                            },
                          ),

                    SizedBox(
                      height: 20,
                    ),
                    // (widget.imageFile != null)
                    (_imageFile != null)
                        ? Container(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                // imageFile = await Navigator.push<File>(
                                // context, MaterialPageRoute(builder: (_) => Camera()));

                                getAbsence();
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(horizontal: 30)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        leadsGoColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(123),
                                  ),
                                ),
                              ),
                              child: Text(
                                'KIRIM ABSEN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'LeadsGo-Font',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          deleteCacheDir();
                          setState(() {
                            isNext = false;
                            _imageFile = null;
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 30)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(123),
                              side: BorderSide(color: leadsGoColor),
                            ),
                          ),
                        ),
                        child: Text(
                          'BATAL',
                          style: TextStyle(
                            color: leadsGoColor,
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void cekAbsensi() async {
  //   if (_info.totalDistanceValue >= setDistance) {
  //     Fluttertoast.showToast(msg: 'JARAK JAUH');
  //   } else {
  //     Fluttertoast.showToast(msg: 'JARAK DEKAT');
  //   }
  // }

  descJarak() {
    if (!isAvailable) {
      if (!cekLibur) {
        return 'Terima kasih hari ini kamu sudah absen,\nbesok jangan lupa absen ya!';
      } else {
        return 'Layanan absensi tidak tersedia di hari libur!';
      }
    } else {
      // if (value >= setDistance) {
      //   if (timeReady) {
      //     return 'Jarak kamu dengan kantor masih jauh.\nYuk..segera absen hadir ke kantor!';
      //   } else {
      //     return 'Layanan absensi tutup,\nbesok jangan terlambat absen ya!';
      //   }
      // } else {
      if (timeReady) {
        return 'Kamu sudah bisa absen sekarang!';
      } else {
        return 'Layanan absensi sudah tutup,\nbesok absen lagi ya dan dapetin pointnya!';
      }
      // }
    }
  }

  // ShowDialog Alert
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
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          'OKE',
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
  // .END ShowDialog Alert

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

// ----------------------------------------------------------------------------
  // GET WA
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

  // SCREEN ONLINE BACK TO HOME --------------------------------------------------------
  Future<bool> _onBackPressed(BuildContext context) async {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Column(
              children: [
                Icon(
                  MdiIcons.helpCircleOutline,
                  color: leadsGoColor,
                  size: 50.0,
                ),
                SizedBox(height: 15),
                Text(
                  'Apa kamu ingin kembali ke layar utama?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: leadsGoColor,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                          // Navigator.of(context).pop(false);
                        },
                        color: Colors.grey,
                        child: Container(
                          width: 60,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              'Tidak',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'LeadsGo-Font',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          userLogin();
                        },
                        color: leadsGoColor,
                        child: Container(
                          width: 60,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              'Ya !',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'LeadsGo-Font',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ) ??
        false;
  }

  var personalData = new List(38);
  bool isLoadBack;
  Future invalidLogin(message, error) async {
    return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Column(
              children: [
                Icon(
                  message == 'response'
                      ? MdiIcons.earth
                      : message == 'generalError'
                          ? MdiIcons.wifiCancel
                          : MdiIcons.timerOffOutline,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(height: 15),
                Text(
                  message == 'response'
                      ? 'Server Maintenance'
                      : message == 'generalError'
                          ? 'Tidak Terkoneksi'
                          : 'Koneksi Terlalu Lama',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message == 'response'
                      ? 'Mohon segera laporkan, karena terdapat pesan : "$error"'
                      : message == 'generalError'
                          ? 'Mohon periksa jaringan koneksi internet ponsel kamu !'
                          : 'Koneksi terlalu lambat, mohon periksa jaringan kamu !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          // Navigator.removeRoute(
                          //     context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                              (route) => false);
                        },
                        color: Colors.grey,
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              'Keluar',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'LeadsGo-Font',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (message == 'response') {
                            // Navigator.pop(context, false);
                            String teleponFix = '+62' + '082130345751';
                            String username = widget.username;
                            String messageError = error.toString();
                            launchWhatsApp(
                                phone: teleponFix,
                                message: username +
                                    ',\nmelaporkan adanya pesan bertuliskan "' +
                                    messageError +
                                    '" ketika ingin kembali dari menu pipeline ke menu utama !');
                          } else {
                            // Navigator.pop(context);
                            userLogin();
                          }
                        },
                        color:
                            message == 'response' ? Colors.red : leadsGoColor,
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              message == 'response'
                                  ? 'Laporkan !'
                                  : 'Coba Lagi !',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'LeadsGo-Font',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ) ??
        false;
  }

  Future userLogin() async {
    String username = widget.username;
    String password = widget.nik;

    setState(() {
      isLoadBack = true;
    });

    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSmartLogin');

    //starting web api call
    int timeout = 30;
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12.withOpacity(0.6),
      builder: (BuildContext context) {
        dialogContext = context;
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              child: Center(
                child: Container(
                  child: SpinKitThreeBounce(
                    color: leadsGoColor,
                    size: 50.0,
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );

    try {
      var response = await http.post(url,
          body: {'username': username, 'password': password}).catchError((e) {
        // SocketException would show up here, potentially after the timeout.
      }).timeout(Duration(seconds: timeout));

      if (username == '' || password == '') {
      } else {
        //if the response message is matched
        if (response.statusCode == 200) {
          Navigator.pop(context, false);
          var message = jsonDecode(response.body)['Daftar_Login'];
          print(message);
          if (message['message'].toString() == 'Login Success') {
            Navigator.pop(context, false);
            setState(() {
              isLoadBack = false;
            });
            if (message['status_account'] == 'SUSPEND') {
            } else {
              setState(() {
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

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      widget.username,
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
          } else {
            Navigator.pop(context, false);
          }
        } else {
          var message = 'response';
          var error = 'Status Code ${response.statusCode}';
          print('Status Code Error: $message');
          setState(() {
            isLoadBack = false;
          });
          Navigator.pop(context, false);
          Navigator.pop(dialogContext);
          // GAGAL LOGIN
          invalidLogin(message, error);
        }
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');

      Navigator.pop(context, false);
      Navigator.pop(dialogContext);

      var message = 'timeoutError';
      var error = e;
      invalidLogin(message, error);
    } on Error catch (e) {
      print('General Error: $e');

      Navigator.pop(context, false);
      Navigator.pop(dialogContext);
      // GAGAL LOGIN
      var message = 'generalError';
      var error = e;
      invalidLogin(message, error);
    }
  }

// ----------------------------------------------------------------------------
// GET ABSEN ------------------------------------------------------------------
// ----------------------------------------------------------------------------
  bool isGetAbsence;
  String addPoin;

  Future getAbsence() async {
    setState(() {
      isGetAbsence = true;
    });

    String fileName = _imageFile.path.split('/').last;
    String base64Image = base64Encode(_imageFile.readAsBytesSync());

    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getAbsenLog');
    try {
      var response = await http.post(url, body: {
        'nik_id': widget.nik,
        'username': widget.username,
        'location': '',
        // '$currentAddress ( ${currentLatitude.toString()}, ${currentLongitude.toString()} )',
        // 'selfie_pict': fileName,
        'file_name': 'absence',
        'image': base64Image,
        'name': fileName,
      }).catchError((e) {
        // SocketException would show up here, potentially after the timeout.
      }).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['absen_log'];
        var mpoit = jsonDecode(response.body)['add_poin'];
        var timeIn = jsonDecode(response.body)['time_in'];
        var image = jsonDecode(response.body)['image'];
        var notif = jsonDecode(response.body)['success'];

        if (message.toString() == 'Pend' && mpoit.toString() != '0') {
          modalShowGetAbsence(
              'PEND', '', timeIn.toString().substring(0, 5), '');
          setState(() {
            isGetAbsence = false;
            addPoin = '0';
            // _lokasiKamu = null;
            _imageFile = null;
            // onRoute = false;
            isNext = false;
          });
          cekAbsenceAvailable();
          deleteCacheDir();
          // _determinePosition();
          // getBranchLocation();
          getWaktuAbsen();
          userLogin();
        } else if (message.toString() == 'Success' && mpoit.toString() != '0') {
          modalShowGetAbsence('SUKSES', mpoit.toString(),
              timeIn.toString().substring(0, 5), image.toString());
          setState(() {
            isGetAbsence = false;
            addPoin = '0';
            // _lokasiKamu = null;
            _imageFile = null;
            // onRoute = false;
            isNext = false;
          });
          cekAbsenceAvailable();
          deleteCacheDir();
          // _determinePosition();
          // getBranchLocation();
          getWaktuAbsen();
          userLogin();
        }
        setState(() {
          isGetAbsence = false;
          addPoin = '0';
          // _lokasiKamu = null;
          _imageFile = null;
          // onRoute = false;
          isNext = false;
        });
        cekAbsenceAvailable();
        deleteCacheDir();
        // _determinePosition();
        // getBranchLocation();
        getWaktuAbsen();
        userLogin();
      } else {
        modalShowGetAbsence('GAGAL', '', '', '');
        setState(() {
          isGetAbsence = false;
          addPoin = '0';
          // _lokasiKamu = null;
          _imageFile = null;
          // onRoute = false;
          isNext = false;
        });
        cekAbsenceAvailable();
        deleteCacheDir();
        // _determinePosition();
        // getBranchLocation();
        getWaktuAbsen();
        userLogin();
      }
    } on TimeoutException catch (e) {
      // TIME OUT
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Gagal koneksi ke server',
          'Mohon periksa jaringan internet kamu, dan nyalakan paket data atau wifi.');
      setState(() {
        isGetAbsence = false;
        _imageFile = null;
        isNext = false;
      });
      cekAbsenceAvailable();
      deleteCacheDir();
      getWaktuAbsen();
      userLogin();
    } on Error catch (e) {
      // ERROR
      print('General Error: $e');
      alert(leadsGoColor, 'Aplikasi membutuhkan akses internet',
          'Mohon nyalakan paket data atau wifi untuk mengunakan aplikasi.');
      setState(() {
        isGetAbsence = false;
        _imageFile = null;
        isNext = false;
      });
      cekAbsenceAvailable();
      deleteCacheDir();
      getWaktuAbsen();
      userLogin();
    }
  }

  // ShowDialog Alert
  AnimationController _controller;
  Animation<double> _animation;
  Future modalShowGetAbsence(
      String status, String poin, String timein, String nameImage) async {
    setState(() {
      _controller = AnimationController(
          duration: const Duration(milliseconds: 1000),
          vsync: this,
          value: 0.1);
      _animation =
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
      _controller.forward();
    });
    String dd = DateFormat("dd").format(DateTime.now());
    String mm =
        namaBulan(DateFormat("MM").format(DateTime.now())).substring(0, 3);
    String yyyy = DateFormat("yyyy").format(DateTime.now());

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: ScaleTransition(
                      scale: _animation,
                      child: status == 'SUKSES'
                          ? Icon(
                              MdiIcons.checkCircleOutline,
                              color: Colors.green,
                              size: 60.0,
                            )
                          : Icon(
                              MdiIcons.closeCircleOutline,
                              color: Colors.red,
                              size: 60.0,
                            ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      status == 'SUKSES' ? 'Absen Berhasil' : 'Absen Gagal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.3,
                        letterSpacing: 0.30,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.bold,
                        color: status == 'SUKSES' ? Colors.green : Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      '$dd $mm $yyyy, $timein',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.4,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  status == 'SUKSES' && nameImage != ''
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage("assets/bg-cloud.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // alignment: Alignment.center,
                          width: double.infinity,
                          height: 250,
                          child: Image.network(
                            'https://tetranabasainovasi.com/marsit/' +
                                nameImage,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  if (status == 'PEND')
                    Center(
                      child: Text(
                        'Hari ini kamu sudah absen!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0.30,
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  if (poin != '' && status != 'PEND')
                    Center(
                      child: Text(
                        '+Leads Points ' + poin,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.3,
                          letterSpacing: 0.30,
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          color: leadsGoColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context, false);
                    deleteCacheDir();
                    setState(() {
                      _imageFile = null;
                      isNext = false;
                      isGetAbsence = false;
                      addPoin = '0';
                      _imageFile = null;
                      isNext = false;
                    });

                    cekAbsenceAvailable();
                    deleteCacheDir();
                    getWaktuAbsen();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 30)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(123),
                        side: BorderSide(color: leadsGoColor, width: 1.8),
                      ),
                    ),
                  ),
                  child: Text(
                    'Tutup',
                    style: TextStyle(
                      color: leadsGoColor,
                      fontFamily: 'LeadsGo-Font',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
