import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SimulationImageScreen extends StatefulWidget {
  Uint8List bytes1;
  Uint8List bytes2;
  Uint8List bytes3;
  SimulationImageScreen(this.bytes1, this.bytes2, this.bytes3);
  @override
  _SimulationImageScreenState createState() => _SimulationImageScreenState();
}

class _SimulationImageScreenState extends State<SimulationImageScreen> {
  bool visible = false;

  Future saveImage() async {
    // setState(() {
    //   visible = true;
    // });
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1//saveImageSimulasi');
    var response = await http.post(url, body: {
      'nik_sales': '5000120',
      'image': widget.bytes1.toString(),
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Simulasi'];
      if (message.toString() == 'Save Success') {
        // setState(() {
        //   visible = false;
        // });
        Toast.show(
          'Sukses download simulasi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        Toast.show(
          'Gagal download simulasi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.bytes1);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Save to Image',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            visible
                ? CircularProgressIndicator(
                    //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : IconButton(
                    icon: Icon(Icons.file_download),
                    onPressed: () async {
                      saveImage();
                    },
                    color: Colors.white,
                  )
          ],
        ),
        body: Container(
          color: grey,
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
          child: ListView(
            children: <Widget>[
              Image.memory(widget.bytes1),
              Image.memory(widget.bytes2),
              Image.memory(widget.bytes3),
            ],
          ),
        ),
      ),
    );
  }
}
