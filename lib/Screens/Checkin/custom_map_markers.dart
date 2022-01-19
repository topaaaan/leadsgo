import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:toast/toast.dart';

class MapSample extends StatefulWidget {
  @override
  String username;
  String nik;
  String position;
  String latitudeYour;
  String longitudeYour;

  MapSample(
    this.username,
    this.nik,
    this.position,
    this.latitudeYour,
    this.longitudeYour,
  );

  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final usernameController = TextEditingController();
  final positionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.setData();
  }

  Future setData() async {
    setState(() {
      usernameController.text = widget.username;
      positionController.text = widget.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

    final LatLng _kMapCenter = LatLng(-6.253496, 106.96887849999999);

    final LatLng _kMapYour =
        LatLng(double.parse(widget.latitudeYour), double.parse(widget.longitudeYour));

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(-6.253496, 106.96887849999999),
      zoom: 20.0,
    );

    final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(-6.253496, 106.96887849999999),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    Set<Marker> _createMarker() {
      return {
        Marker(
          markerId: MarkerId("marker_1"),
          position: _kMapCenter,
          infoWindow: InfoWindow(title: 'KC BEKASI'),
        ),
        Marker(
          markerId: MarkerId("marker_2"),
          position: _kMapYour,
          infoWindow: InfoWindow(title: 'Your here'),
        ),
      };
    }

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: leadsGoColor,
        title: Text(
          'Check In',
          style: TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                height: 300,
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: _createMarker(),
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                padding: EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                child: Column(
                  children: <Widget>[
                    fieldNama(),
                    fieldPosisi(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _cekAbsensi,
        label: Text('Check In'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _cekAbsensi() async {
    // double distanceInMeters = await Geolocator().distanceBetween(double.parse(widget.latitudeYour),
    // double.parse(widget.longitudeYour), -6.253496, 106.96887849999999);

    // if (double.parse(distanceInMeters.toStringAsFixed(2)) > 1.00) {
    //   Toast.show(
    //     'Jarak jauh',
    //     context,
    //     duration: Toast.LENGTH_LONG,
    //     gravity: Toast.BOTTOM,
    //     backgroundColor: Colors.red,
    //   );
    // } else {
    //   Toast.show(
    //     'Jarak dekat',
    //     context,
    //     duration: Toast.LENGTH_LONG,
    //     gravity: Toast.BOTTOM,
    //     backgroundColor: Colors.blue,
    //   );
    // }
  }

  Widget fieldNama() {
    return TextFormField(
        controller: usernameController,
        decoration: InputDecoration(labelText: 'Username'),
        readOnly: true,
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }

  Widget fieldPosisi() {
    return TextFormField(
        controller: positionController,
        decoration: InputDecoration(labelText: 'Posisi'),
        readOnly: true,
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }
}
