import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class RedeemScreen extends StatefulWidget {
  String username;
  String nik;
  int diamond;

  RedeemScreen(this.username, this.nik, this.diamond);
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
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getPricelist');
    telepon = teleponController.text;
    //starting web api call
    var response = await http.post(url, body: {'telepon': telepon});
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
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/konfirmasiPulsa');

    //starting web api call
    var response = await http.post(url, body: {
      'niksales': niksales,
      'telepon': telepon,
      'harga_beli': hargaBeli.toString(),
      'kode_produk': kodeProduk,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Daftar_Transaksi'];
      if (message.toString() == 'Save Success') {
        Toast.show(
          'Success redeem pulsa',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        sleep(const Duration(seconds: 5));
        userLogin();
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
      }
    }
  }

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

    //server login api
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getLogin');

    //starting web api call
    var response = await http.post(url, body: {'username': username, 'password': password});

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
              personalData[36] = message['rating'];
              personalData[37] = message['tgl_cut_off'];
            });

            if (message['hak_akses'] == '5') {
              setState(() {
                _konfirmasi = false;
              });
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Tukar Pulsa',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
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
                        child: fieldTelepon(),
                      ),
                      fieldKirim(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: Text(
                      '*untuk penukaran pulsa dengan nominal voucher dan nomor telepon yang sama hanya bisa dilakukan sekali dalam sehari.',
                      style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
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
                  itemCount: pricelist.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        bool konfirmasi = true;
                        if (widget.diamond < pricelist[i]['harga_jual']) {
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
                                  namaField('Informasi Pelanggan', '', 13.0, FontWeight.bold),
                                  namaField(
                                      'Nomor Ponsel', setNull(telepon), 12.0, FontWeight.normal),
                                  namaField(
                                      'Diamond Tersedia',
                                      setNull(widget.diamond.toString() + ' DIAMOND'),
                                      12.0,
                                      FontWeight.normal),
                                  namaField(
                                      'Voucher ' +
                                          pricelist[i]['provider'].toString().substring(0, 1) +
                                          pricelist[i]['provider']
                                              .toString()
                                              .substring(1)
                                              .toLowerCase(),
                                      setNull(pricelist[i]['code'].toString() + ',000'),
                                      12.0,
                                      FontWeight.normal),
                                  namaField('Detail Pembayaran', '', 13.0, FontWeight.bold),
                                  namaField(
                                      'Harga Voucher',
                                      setNull(pricelist[i]['harga_jual'].toString() + ' DIAMOND'),
                                      12.0,
                                      FontWeight.normal),
                                  namaField(
                                      'Biaya Transaksi', setNull('0'), 12.0, FontWeight.normal),
                                  namaField(
                                      'Total Pembayaran',
                                      setNull(
                                        pricelist[i]['harga_jual'].toString() + ' DIAMOND',
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
                                                borderRadius: BorderRadius.circular(10.0),
                                                side: BorderSide(color: Colors.orangeAccent)),
                                            color: Colors.orangeAccent,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'UBAH',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: konfirmasi
                                                        ? leadsGoColor
                                                        : Colors.redAccent)),
                                            color: konfirmasi ? leadsGoColor : Colors.redAccent,
                                            onPressed: () {
                                              if (konfirmasi) {
                                                dialogLoading(_konfirmasi);
                                                konfirmasiPulsa(
                                                    widget.nik,
                                                    telepon,
                                                    pricelist[i]['harga_jual'],
                                                    pricelist[i]['codex'].toString());
                                              } else {
                                                Toast.show(
                                                  'Maaf, diamond anda tidak mencukupi',
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
                                                  color: konfirmasi ? Colors.white : Colors.white),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 2,
                        child: ListTile(
                          leading: Text(
                            pricelist[i]['provider'].toString(),
                          ),
                          title: Text(
                            pricelist[i]['code'].toString() + ',000',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Harga : ' + pricelist[i]['harga_jual'].toString() + ' DIAMOND',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKirim() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text("CEK", style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.white)),
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
