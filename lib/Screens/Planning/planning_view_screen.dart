import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_add.dart';

class PlanningViewScreen extends StatefulWidget {
  String username;
  String nik;
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

  PlanningViewScreen(
    this.username,
    this.nik,
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
  _PlanningViewScreenState createState() => _PlanningViewScreenState();
}

class _PlanningViewScreenState extends State<PlanningViewScreen> {
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
            IconButton(
              onPressed: () {
                if (widget.telepon != '') {
                  String teleponFix = '+62' + telepon.substring(1);
                  launchWhatsApp(phone: teleponFix, message: 'Tes');
                } else {
                  Toast.show(
                    'No telepon kosong...',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              icon: Icon(MdiIcons.whatsapp),
              iconSize: 25,
            ),
            IconButton(
              onPressed: () {
                if (widget.telepon.length >= 10) {
                  _makePhoneCall('tel:$telepon');
                } else {
                  Toast.show(
                    'No telepon kosong...',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              icon: Icon(MdiIcons.phone),
              iconSize: 20,
            )
          ],
        ),
        body: _buildList(),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(
            // horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: FlatButton(
                    height: 46,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(123),
                    ),
                    color: widget.visitStatus == '1'
                        ? Colors.green[600]
                        : Colors.grey,
                    child: Container(
                      child: Center(
                        child: Text(
                          widget.visitStatus == '1'
                              ? 'Yuk Interaksi Sekarang!'
                              : 'Sudah Di Interkasikan',
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
                      if (widget.visitStatus == '1') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InteractionAddScreen(
                                    widget.username,
                                    widget.nik,
                                    widget.nama,
                                    widget.alamat,
                                    '',
                                    widget.telepon,
                                    'Database ',
                                    widget.kelurahan,
                                    widget.kecamatan,
                                    widget.provinsi,
                                    widget.kabupaten,
                                    widget.notas)));
                      } else {
                        Toast.show(
                          'Nasabah sudah di interaksi...',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.CENTER,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      // alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 60),
      color: Colors.grey[200],
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                    SizedBox(
                      height: 5,
                    ),
                    fieldDebitur('Notas', setNull(widget.notas.trimLeft())),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Nama Lengkap', setNull(widget.nama)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Tanggal Lahir', setNull_d(widget.tglLahir)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur(
                        'Gaji Pokok', setNull(formatRupiah(widget.gajiPokok))),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('KTP', setNull_d(widget.ktp)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('NPWP', setNull_d(widget.npwp)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Telepon', setNull_d(telepon)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur(
                        'Tanggal Pensiun', setNull_d(widget.tmtPensiun)),
                    SizedBox(
                      height: 1,
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
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                    SizedBox(
                      height: 5,
                    ),
                    fieldDebitur('Alamat', setNull_d(widget.alamat)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Kelurahan', setNull_d(widget.kelurahan)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Kecamatan', setNull_d(widget.kecamatan)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Kota', setNull_d(widget.kabupaten)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Propinsi', setNull_d(widget.provinsi)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Kodepos', setNull_d(widget.kodepos)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                    SizedBox(
                      height: 5,
                    ),
                    fieldDebitur(
                        'Nama Penerima', setNull_d(widget.namaPenerima)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Tanggal Lahir',
                        setNull_d(widget.tanggalLahirPenerima)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                    SizedBox(
                      height: 5,
                    ),
                    fieldDebitur('Kantor Bayar', setNull_d(widget.namaKantor)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Nomor SKEP', setNull_d(widget.nomorSkep)),
                    SizedBox(
                      height: 1,
                    ),
                    fieldDebitur('Tanggal SKEP', setNull_d(widget.tanggalSkep)),
                    SizedBox(
                      height: 1,
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

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
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

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          width: 130,

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
          width: 5,
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
