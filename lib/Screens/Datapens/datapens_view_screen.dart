import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:leadsgo_apps/Screens/Planning/planning_screen.dart';
import 'package:leadsgo_apps/Screens/Interaction/planning_interaction_screen.dart';

class DatapensViewScreen extends StatefulWidget {
  String nik;
  String username;
  String hakAkses;
  String id;
  String nama;
  String tglLahir;
  String gajiPokok;
  String alamat;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String provinsi;
  String kodepos;
  String namaKantor;
  String tmtPensiun;
  String penerbitSkep;
  String telepon;
  String visitStatus;
  String notas;
  String ktp;
  String npwp;
  String namaPenerima;
  String tanggalLahirPenerima;
  String nomorSkep;
  String tanggalSkep;

  DatapensViewScreen(
    this.nik,
    this.username,
    this.hakAkses,
    this.id,
    this.nama,
    this.tglLahir,
    this.gajiPokok,
    this.alamat,
    this.kelurahan,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.kodepos,
    this.namaKantor,
    this.tmtPensiun,
    this.penerbitSkep,
    this.telepon,
    this.visitStatus,
    this.notas,
    this.ktp,
    this.npwp,
    this.namaPenerima,
    this.tanggalLahirPenerima,
    this.nomorSkep,
    this.tanggalSkep,
  );
  @override
  _DatapensViewScreenState createState() => _DatapensViewScreenState();
}

class _DatapensViewScreenState extends State<DatapensViewScreen> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  String telepon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      print(widget.telepon);
      if (widget.telepon == null ||
          widget.telepon == '' ||
          widget.telepon.isEmpty) {
        telepon = setNull(widget.telepon);
      } else {
        if (widget.telepon.substring(0, 1) != '0') {
          telepon = '0' + widget.telepon;
        }
      }
    });
  }

  bool _isLoading = false;
  bool _isFailed = false;

  Future saveDatapens() async {
    //showing CircularProgressIndicator
    setState(() {
      _isLoading = true;
    });

    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/saveDatapens');

    //starting web api call
    var response = await http.post(url, body: {
      // DATA TO RENCANA MARKETING
      'nik_sales': widget.nik,
      // DATA TO MST_DATAPENS
      '_id': setNull(widget.id),
      'nama': setNull(widget.nama),
      'tglLahir': setNull(widget.tglLahir),
      'gajiPokok': setNull(widget.gajiPokok),
      'alamat': setNull(widget.alamat),
      'kelurahan': setNull(widget.kelurahan),
      'kecamatan': setNull(widget.kecamatan),
      'kabupaten': setNull(widget.kabupaten),
      'provinsi': setNull(widget.provinsi),
      'kodepos': setNull(widget.kodepos),
      'namaKantor': setNull(widget.namaKantor),
      'tmtPensiun': setNull(widget.tmtPensiun),
      'penerbitSkep': setNull(widget.penerbitSkep),
      'telepon': setNull(widget.telepon),
      'notas': setNull(widget.notas),
      'ktp': setNull(widget.ktp),
      'npwp': setNull(widget.npwp),
      'namaPenerima': setNull(widget.namaPenerima),
      'tanggalLahirPenerima': setNull(widget.tanggalLahirPenerima),
      'nomorSkep': setNull(widget.nomorSkep),
      'tanggalSkep': setNull(widget.tanggalSkep),
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Datapens'];

      if (message['message'].toString() == 'Save Success') {
        // Toast.show(
        //   'Sukses menambahkan database...',
        //   context,
        //   duration: Toast.LENGTH_LONG,
        //   gravity: Toast.CENTER,
        //   backgroundColor: Colors.green,
        // );
        // _onInfoPressed();
        // setState(() {
        //   _isLoading = false;
        // });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PlanningScreen(widget.username, widget.nik, widget.hakAkses)));
        Toast.show(
          'Sukses menambahkan database...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
        );
        setState(() {
          _isLoading = false;
        });
      } else if (message['message'].toString() == 'Data Already') {
        Toast.show(
          'Data ini sudah ada!',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        // _onInfoPressed();
        setState(() {
          _isFailed = true;
          _isLoading = false;
        });
      } else if (message['message'].toString() == 'Data Limit') {
        Toast.show(
          'Tidak boleh lebih dari 50 data disimpan!',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        _onInfoPressed();
        setState(() {
          _isFailed = true;
          _isLoading = false;
        });
      } else {
        Toast.show(
          'Gagal menambahkan database...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        _onInfoPressed();
        setState(() {
          _isFailed = true;
          _isLoading = false;
        });
      }
    } else {
      Toast.show(
        'Gagal menambahkan database...',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red,
      );
      setState(() {
        _isFailed = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            '${setNull(widget.nama)}',
            // 'Detail Data',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     if (widget.telepon != '') {
            //       String teleponFix = '+62' + telepon.substring(1);
            //       launchWhatsApp(phone: teleponFix, message: 'Tes');
            //     } else {
            //       Toast.show(
            //         'No telepon kosong...',
            //         context,
            //         duration: Toast.LENGTH_LONG,
            //         gravity: Toast.BOTTOM,
            //         backgroundColor: Colors.red,
            //       );
            //     }
            //   },
            //   icon: Icon(MdiIcons.whatsapp),
            //   iconSize: 25,
            // ),
            // IconButton(
            //   onPressed: () {
            //     if (widget.telepon.length >= 10) {
            //       _makePhoneCall('tel:$telepon');
            //     } else {
            //       Toast.show(
            //         'No telepon kosong...',
            //         context,
            //         duration: Toast.LENGTH_LONG,
            //         gravity: Toast.BOTTOM,
            //         backgroundColor: Colors.red,
            //       );
            //     }
            //   },
            //   icon: Icon(Icons.call),
            //   iconSize: 20,
            // )
          ],
        ),
        body: _buildList(),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(
            // horizontal: 15,
            vertical: 10,
          ),
          // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 76,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
              ),
            ],
          ),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.20,
                      child: IconButton(
                        // icon: Icon(MdiIcons.dotsHorizontalCircle),
                        icon: Icon(MdiIcons.informationOutline),
                        iconSize: 40,
                        color: Colors.black45,
                        onPressed: () {
                          setState(() {
                            _isFailed = false;
                          });
                          _onInfoPressed();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: FlatButton(
                        height: 46,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.green[500],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Simpan Data',
                            style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        onPressed: () {
                          saveDatapens();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
      ));
    } else {
      return Container(
        // alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(bottom: 75),
        color: Colors.grey[200],
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 16),
              color: Colors.white,
              child: Text(
                'Data Pensiun',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      fieldDebitur('Notas', setNull(widget.notas.trimLeft())),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Nama Lengkap', setNull(widget.nama)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Tanggal Lahir', setNull_d(widget.tglLahir)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Gaji Pokok',
                          setNull(formatRupiah(widget.gajiPokok))),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('KTP', setKTP(widget.ktp)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('NPWP', setNPWP(widget.npwp)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Telepon', setTelepon(telepon)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur(
                          'Tanggal Pensiun', setNull_d(widget.tmtPensiun)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 16),
              color: Colors.white,
              child: Text(
                'Info Alamat',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      fieldDebitur('Alamat', setAlamat(widget.alamat)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Kelurahan', setNull_d(widget.kelurahan)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Kecamatan', setNull_d(widget.kecamatan)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Kota', setNull_d(widget.kabupaten)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Propinsi', setNull_d(widget.provinsi)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Kodepos', setNull_d(widget.kodepos)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 16),
              color: Colors.white,
              child: Text(
                'Info Penerima',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      fieldDebitur(
                          'Nama Penerima', setNull_d(widget.namaPenerima)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Tanggal Lahir',
                          setNull_d(widget.tanggalLahirPenerima)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 16),
              color: Colors.white,
              child: Text(
                'Info Lainnya',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      fieldDebitur(
                          'Kantor Bayar', setNull_d(widget.namaKantor)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Nomor SKEP', setNull_d(widget.nomorSkep)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur(
                          'Tanggal SKEP', setNull_d(widget.tanggalSkep)),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur(
                          'Penerbit SKEP', setNull_d(widget.penerbitSkep)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _onInfoPressed() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              // height: 500,

              height: _isFailed == true
                  ? MediaQuery.of(context).size.height * 0.45
                  : MediaQuery.of(context).size.height * 0.40,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(123)),
                                // border: Border.all(width: 2, color: Colors.black),
                              ),
                              child: _isFailed == true
                                  ? Icon(
                                      MdiIcons.cancel,
                                      size: 40,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      MdiIcons.informationOutline,
                                      size: 40,
                                      color: Colors.blue,
                                    ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 25),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _isFailed == true
                                      ? 'Tidak bisa simpan data?'
                                      : 'Syarat & Ketentuan',
                                  style: TextStyle(
                                    fontFamily: "LeadsGo-Font",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    // decoration: TextDecoration.underline,
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 50,
                              child: IconButton(
                                icon: Icon(MdiIcons.close),
                                iconSize: 30,
                                color: Colors.black54,
                                onPressed: () => {Navigator.pop(context)},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(123)),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Align(
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          width: MediaQuery.of(context).size.height * 0.40,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _isFailed == true
                                  ? 'Itu karena kamu sudah menyimpan database pribadi lebih dari 50 data.'
                                  : 'Database master yang boleh disimpan hanya 50 data.',
                              // textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                // height: 1.30,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(123)),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Align(
                            child: Text(
                              '2',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          width: MediaQuery.of(context).size.height * 0.40,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _isFailed == true
                                  ? 'Sekarang rencanakan interaksimu melalui menu database pribadi.'
                                  : 'Perhatikan kualitas data yang disimpan, karena data yang sudah tersimpan tidak dapat dihapus.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                // height: 1.30,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(123)),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Align(
                            child: Text(
                              '3',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          width: MediaQuery.of(context).size.height * 0.40,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _isFailed == true
                                  ? 'Selesaikan tugas interaksimu melaluimenu interaksi.'
                                  : 'Interaksikan database pribadimu setelah disimpan, agar kamu dapat menyimpan data baru.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                height: 1.30,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _isFailed == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0, color: leadsGoColor)),
                                  // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: FlatButton(
                                    // height: 36,
                                    shape: RoundedRectangleBorder(
                                        // borderRadius: BorderRadius.circular(5),
                                        ),
                                    // color: leadsGoColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Lihat database pribadi saya',
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            color: leadsGoColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    onPressed: () {
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
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0, color: leadsGoColor)),
                                  // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: FlatButton(
                                    // height: 36,
                                    shape: RoundedRectangleBorder(
                                        // borderRadius: BorderRadius.circular(5),

                                        ),
                                    // color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Lihat tugas interaksi saya',
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            color: leadsGoColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    onPressed: () {
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
                                )
                              ])
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10.0,
                      ),
                    ]),
              ),
            );
          });
        });
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setNull_x(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return '';
    } else {
      return data;
    }
  }

  setNull_d(String data) {
    if (data == null ||
        data == '' ||
        data.isEmpty ||
        data == 'NULL' ||
        data == '0000-00-00') {
      return '-';
    } else {
      return data;
    }
  }

  setColorStatusVisit(String nilai) {
    if (nilai == '1') {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  setStatusVisit(String nilai) {
    if (nilai == '1') {
      return 'BELUM DI INTERAKSI';
    } else {
      return 'SUDAH DI INTERAKSI';
    }
  }

  formatRupiah(String a) {
    if (a.substring(0, 1) != '0') {
      FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
          amount: double.parse(a.replaceAll(',', '')),
          settings: MoneyFormatterSettings(
            symbol: 'IDR',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
          ));
      return 'IDR ' + fmf.output.withoutFractionDigits;
    } else {
      return a;
    }
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  setAlamat(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'Tidak tersedia!';
    } else {
      for (int i = 20; i < data.length; i++) {
        data = replaceCharAt(data, i, '×');
      }
      return data;
    }
  }

  setKTP(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'Tidak tersedia!';
    } else {
      for (int i = 8; i < data.length; i++) {
        data = replaceCharAt(data, i, '×');
      }
      return data;
    }
  }

  setNPWP(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'Tidak tersedia!';
    } else {
      for (int i = 8; i < data.length; i++) {
        data = replaceCharAt(data, i, '×');
      }
      return data;
    }
  }

  setTelepon(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'Tidak tersedia!';
    } else {
      for (int i = 8; i < data.length; i++) {
        data = replaceCharAt(data, i, '×');
      }
      return data;
    }
  }

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          width: 130,
          // decoration: new BoxDecoration(
          //   color: Colors.red,
          //   borderRadius: BorderRadius.circular(5.0),
          // ),

          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          // padding: const EdgeInsets.all(10),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.black54,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          width: 10,
        ),
        // Text(
        //   ': ',
        //   textAlign: TextAlign.left,
        //   style: TextStyle(
        //     fontFamily: 'LeadsGo-Font',
        //     color: Colors.black,
        //   ),
        // ),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: MediaQuery.of(context).size.width * 0.58,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ))),
      ],
    );
  }
}
