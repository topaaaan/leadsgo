import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/Account/LogDiamond/lod_diamond_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class RedeemScreen extends StatefulWidget {
  String username;
  String nik;
  int diamond;
  String judul;
  String topup;
  String jenis;

  RedeemScreen(this.username, this.nik, this.diamond, this.judul, this.topup,
      this.jenis);
  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  bool _loading = false;
  bool _konfirmasi = false;
  String telepon;
  final formKey = GlobalKey<FormState>();
  List<dynamic> pricelist = [];
  var personalData = new List(38);

  //getting value from TextField widget.
  final teleponController = TextEditingController();

  formatPoint(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
          // symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return fmf.output.withoutFractionDigits;
  }

  Future dialogLoading(bool _loadingA) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 1), () {
            if (_loadingA == false) {
              Navigator.of(context).pop();
            }
          });

          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                height: 20,
                width: 20,
              )
            ])),
          );
        });
  }

  Future cekPulsa() async {
    setState(() {
      _loading = true;
      telepon = teleponController.text;
    });
    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/mobilepulsa/tes.php/getPricelist');
    telepon = teleponController.text;
    //starting web api call
    var response = await http.post(url, body: {
      'topup': widget.topup, //telkomsel,ovo,pln
      'telepon': telepon, //notelepon
      'jenis': widget.jenis, //etoll,pulsa,data,pln
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Pricelist'];
      if (message != '') {
        setState(() {
          pricelist = message;
          _loading = false;
          print(pricelist);
        });
      }
    }
  }

  Future konfirmasiPulsa(niksales, telepon, hargaBeli, kodeProduk) async {
    //showing CircularProgressIndicator
    setState(() {
      _konfirmasi = true;
    });
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/mobilepulsa/tes.php/getToupUpRequest');

    //starting web api call
    var response = await http.post(url, body: {
      'niksales': niksales,
      'telepon': telepon,
      'harga': hargaBeli.toString(),
      'pulsa_code': kodeProduk,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Request_Topup'];
      print(message['message']);
      if (message['message'].toString() == 'PROCESS') {
        setState(() {
          _konfirmasi = false;
        });
        Toast.show(
          'Berhasil.. Silahkan tunggu beberapa saat..',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: leadsGoColor,
        );
        sleep(const Duration(seconds: 1));
        userLogin();
      } else {
        setState(() {
          _konfirmasi = false;
        });
        Toast.show(
          message['message'],
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        sleep(const Duration(seconds: 1));
        userLogin();
      }
    } else {
      setState(() {
        _konfirmasi = false;
      });
      Toast.show(
        'Failed redeem pulsa',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
      );
      sleep(const Duration(seconds: 1));
      userLogin();
    }
  }

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSmartLogin');

    //starting web api call
    var response = await http
        .post(url, body: {'username': username, 'password': password});

    if (username == '' || password == '') {
    } else {
      //if the response message is matched
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Daftar_Login'];
        print(message);
        if (message['message'].toString() == 'Login Success') {
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
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
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
            } else {
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
          }
        } else {}
      } else {
        print('error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    formatPoint(String a) {
      FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
          amount: double.parse(a),
          settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            // symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
          ));
      return fmf.output.withoutFractionDigits;
    }

    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            widget.judul,
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(123)),
                            color: Colors.black45),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/star.svg",
                              width: 23.0,
                              semanticsLabel: 'Points',
                            ),
                            SizedBox(width: 4),
                            Tooltip(
                              message: 'Total Points',
                              child: Text(
                                formatPoint(widget.diamond.toString()),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'LeadsGo-Font',
                                ),
                              ),
                            ),
                          ],
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LogDiamondScreen(widget.nik)));
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Form(
          key: formKey,
          child: Container(
            color: grey,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.white,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: widget.jenis != 'pln'
                            ? fieldTelepon()
                            : fieldToken(),
                      ),
                      fieldKirim(),
                    ],
                  ),
                ),
                // Container(
                //   color: Colors.white,
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         left: 16.0, right: 16.0, bottom: 16.0),
                //     child: Text(
                //       '*untuk penukaran pulsa dengan nominal voucher dan nomor telepon yang sama hanya bisa dilakukan sekali dalam sehari.',
                //       style: TextStyle(
                //         fontFamily: 'LeadsGo-Font',
                //         color: Colors.red,
                //       ),
                //     ),
                //   ),
                // ),
                buildGridViewx(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGridViewx() {
    if (_loading == true) {
      return Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator()
          ],
        ),
      );
    } else {
      if (pricelist.length > 0) {
        return Container(
          padding: EdgeInsets.all(8.0),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: pricelist.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        bool konfirmasi = true;
                        if (widget.diamond < pricelist[i]['pulsa_price']) {
                          setState(() {
                            konfirmasi = false;
                          });
                        }
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: grey,
                              height: 400,
                              child: Column(
                                children: <Widget>[
                                  namaField('Informasi Pelanggan', '', 13.0,
                                      FontWeight.bold),
                                  namaField('Nomor Ponsel', setNull(telepon),
                                      12.0, FontWeight.normal),
                                  namaField(
                                      'Point Tersedia',
                                      setNull(formatPoint(
                                              widget.diamond.toString()) +
                                          ' Point'),
                                      12.0,
                                      FontWeight.normal),
                                  namaField(
                                      'Voucher',
                                      setNull(pricelist[i]['pulsa_nominal']
                                          .toString()),
                                      12.0,
                                      FontWeight.normal),
                                  namaField('Detail Pembayaran', '', 13.0,
                                      FontWeight.bold),
                                  namaField(
                                      'Harga Voucher',
                                      setNull(formatPoint(pricelist[i]
                                                  ['pulsa_price']
                                              .toString()) +
                                          ' Point'),
                                      12.0,
                                      FontWeight.normal),
                                  namaField('Biaya Transaksi', setNull('0'),
                                      12.0, FontWeight.normal),
                                  namaField(
                                      'Total Pembayaran',
                                      setNull(
                                        formatPoint(pricelist[i]['pulsa_price']
                                                .toString()) +
                                            ' Point',
                                      ),
                                      12.0,
                                      FontWeight.bold),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: Colors.red)),
                                            color: Colors.red,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'BATAL',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: konfirmasi
                                                        ? leadsGoColor
                                                        : Colors.redAccent)),
                                            color: konfirmasi
                                                ? leadsGoColor
                                                : Colors.redAccent,
                                            onPressed: () {
                                              if (konfirmasi) {
                                                dialogLoading(_konfirmasi);
                                                print(
                                                    pricelist[i]['pulsa_code']);
                                                konfirmasiPulsa(
                                                    widget.nik,
                                                    telepon,
                                                    pricelist[i]['pulsa_price'],
                                                    pricelist[i]['pulsa_code']
                                                        .toString());
                                              } else {
                                                Toast.show(
                                                  'Maaf, point anda tidak mencukupi',
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                );
                                              }
                                            },
                                            child: Text(
                                              'BELI',
                                              style: TextStyle(
                                                  color: konfirmasi
                                                      ? Colors.white
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 2,
                        child: ListTile(
                          leading: Image.network(
                              pricelist[i]['icon_url'].toString()),
                          title: Text(
                            pricelist[i]['pulsa_nominal'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Harga : ' +
                                formatPoint(
                                    pricelist[i]['pulsa_price'].toString()) +
                                ' Point',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return Text('');
      }
    }
  }

  Widget namaField(title, nama, double size, FontWeight weight) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                      color: Colors.black,
                      fontSize: size,
                      fontWeight: weight),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Text(
                    nama,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        color: Colors.black,
                        fontSize: size,
                        fontWeight: weight),
                  ))),
        ],
      ),
    );
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No Telepon minimal 10 angka...';
        } else if (value.length > 13) {
          return 'No Telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Telepon",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Telepon"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldToken() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No token wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Token",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Token"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKirim() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: RaisedButton(
        color: leadsGoColor,
        child: Text("CEK",
            style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.white)),
        onPressed: () {
          if (formKey.currentState.validate()) {
            cekPulsa();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
