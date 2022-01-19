import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_interaksi_screen.dart';
import 'package:leadsgo_apps/Screens/Disbursment/view_image.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

class ApprovalInteractionViewScreen extends StatefulWidget {
  String username;
  String nik;
  String hakAkses;
  String nikSdm;
  String id;
  String calonDebitur;
  String alamat;
  String email;
  String telepon;
  String rencanaPinjaman;
  String salesFeedback;
  String foto;
  String tanggalInteraksi;
  String jamInteraksi;
  String status;
  String namaSales;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String propinsi;

  ApprovalInteractionViewScreen(
    this.username,
    this.nik,
    this.hakAkses,
    this.nikSdm,
    this.id,
    this.calonDebitur,
    this.alamat,
    this.email,
    this.telepon,
    this.rencanaPinjaman,
    this.salesFeedback,
    this.foto,
    this.tanggalInteraksi,
    this.jamInteraksi,
    this.status,
    this.namaSales,
    this.kelurahan,
    this.kecamatan,
    this.kabupaten,
    this.propinsi,
  );
  @override
  _ApprovalInteractionViewScreenState createState() => _ApprovalInteractionViewScreenState();
}

class _ApprovalInteractionViewScreenState extends State<ApprovalInteractionViewScreen> {
  bool _loadingA = false;
  bool _loadingR = false;

  Future dialogLoading(bool _loadingA) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            if (_loadingA == false) {
              Navigator.of(context).pop();
            }
          });

          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                ),
                height: 20,
                width: 20,
              )
            ])),
          );
        });
  }

  Future approvalInteraksi() async {
    //showing CircularProgressIndicator
    setState(() {
      _loadingA = true;
    });
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/ApprovalInteraction');

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'approval_sl': '1',
      'rekom_sl': 'approve',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Approval_Interaction'];
      print(message);
      if (message == 'Save Success') {
        setState(() {
          _loadingA = false;
          print(_loadingA);
        });
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ApprovalInteractionScreen(
        //         widget.username, widget.nik, widget.hakAkses, widget.nikSdm)));
      } else {
        setState(() {
          _loadingA = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Interaksi gagal disetujui...'),
            //content: Text('We hate to see you leave...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future rejectInteraksi() async {
    setState(() {
      _loadingR = true;
    });
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/RejectInteraction');

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'approval_sl': '11',
      'rekom_sl': 'reject',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Reject_Interaction'];
      if (message.toString() == 'Save Success') {
        setState(() {
          _loadingR = false;
        });
      } else {
        setState(() {
          _loadingR = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Interaksi gagal ditolak...'),
            //content: Text('We hate to see you leave...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String foto = 'https://tetranabasainovasi.com/marsit/' + widget.foto;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            '${widget.calonDebitur}',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: grey,
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Dokumen Interaksi',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImageView(foto, 'Foto Interaksi')));
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(foto),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Interaksi',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Alamat', setNull(widget.alamat), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Kelurahan', setNull(widget.kelurahan), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Kecamatan', setNull(widget.kecamatan), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Kabupaten',
                      setNull(widget.kabupaten),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Propinsi',
                      setNull(widget.propinsi),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur('Email', setNull(widget.email), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('No Telepon', setNull(widget.telepon), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Rencana Pinjaman', formatRupiah(setNull(widget.rencanaPinjaman)), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Sales Feedback', setNull(widget.salesFeedback), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Tanggal', setNull(widget.tanggalInteraksi), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Jam', setNull(widget.jamInteraksi), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Status', setStatusInteraksi(setNull(widget.status)), 120.0),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    dialogLoading(_loadingA);
                    approvalInteraksi();
                  },
                  child: Text(
                    'Setuju',
                    style: TextStyle(color: Colors.white, fontFamily: 'LeadsGo-Font'),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    dialogLoading(_loadingR);
                    rejectInteraksi();
                  },
                  child: Text(
                    'Tolak',
                    style: TextStyle(color: Colors.white, fontFamily: 'LeadsGo-Font'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldDebitur(title, value, size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          decoration: new BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: TextStyle(fontFamily: 'LeadsGo-Font'),
                    ),
                  ],
                ))),
      ],
    );
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setColorStatusInteraksi(String nilai) {
    if (nilai == '0') {
      return Colors.blue;
    } else if (nilai == '1') {
      return Colors.green;
    } else if (nilai == '11') {
      return Colors.red;
    }
  }

  setStatusInteraksi(String nilai) {
    if (nilai == '0') {
      return 'Menunggu Persetujuan';
    } else if (nilai == '1') {
      return 'Disetujui Sales Leader';
    } else if (nilai == '11') {
      return 'Ditolak Sales Leader ';
    }
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'IDR ' + fmf.output.withoutFractionDigits;
  }
}
