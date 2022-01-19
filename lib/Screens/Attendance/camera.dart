import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:leadsgo_apps/Screens/Attendance/attendance_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:camera/camera.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Camera extends StatefulWidget {
  String username;
  String nik;

  @override
  Camera(
    this.username,
    this.nik,
  );

  @override
  _Camera createState() => _Camera();
}

class _Camera extends State<Camera> {
  // Func. Open Camera
  CameraController controller;
  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    await controller.initialize();
  }

  Future<File> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/absen_picture';
    await Directory(directoryPath).create(recursive: true);

    String nameFile = DateFormat("yyyMMdd").format(DateTime.now());
    String initFile = DateFormat("HH:mm").format(DateTime.now());
    String filePath = '$directoryPath/${widget.nik}-$nameFile-$initFile.jpg';

    try {
      await controller.takePicture(filePath);
    } catch (e) {
      return null;
    }

    return File(filePath);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (_) => Attendance(widget.username, widget.nik, null))),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: standCamera(context),
          bottomSheet: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              onPressed: () {
                onCapture(context);
              },
              backgroundColor: Colors.blue,
              child: Icon(
                MdiIcons.cameraIris,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget standCamera(context) {
    return FutureBuilder(
      future: initializeCamera(),
      builder: (_, snapshot) => (snapshot.connectionState == ConnectionState.done)
          ? Stack(
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                )
              ],
            )
          : Container(
              child: Center(
                child: SizedBox(
                  child: SpinKitThreeBounce(
                    color: leadsGoColor,
                    size: 50.0,
                  ),
                ),
              ),
            ),
    );
  }

  onCapture(context) async {
    if (!controller.value.isTakingPicture) {
      try {
        await takePicture().then((value) {
          print(value);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => Attendance(widget.username, widget.nik, value)));
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
