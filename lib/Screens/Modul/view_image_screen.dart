import 'package:leadsgo_apps/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class ImageApp extends StatefulWidget {
  @override
  _ImageApp createState() => _ImageApp();

  String path;
  String title;

  ImageApp(this.path, this.title);
}

class _ImageApp extends State<ImageApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            child: PhotoView(
              imageProvider: NetworkImage('https://tetranabasainovasi.com/marsit/' + widget.path),
            ),
          )),
    );
  }
}
