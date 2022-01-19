import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_screen.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

// ignore: must_be_immutable
class DisbursmentEditNewScreen extends StatefulWidget {
  String username;
  String nik;
  String nama;
  String namaPensiun;
  String alamat;
  String telepon;
  String selectedJenisDebitur;
  String selectedJenisProduk;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String selectedJenisCabang;
  String plafond;
  String selectedJenisInfo;
  String selectedStatusKredit;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String selectedPengelolaPensiun;
  String idPipeline;
  String tanggalPencairan;
  String path1;

  DisbursmentEditNewScreen(
      this.username,
      this.nik,
      this.nama,
      this.namaPensiun,
      this.alamat,
      this.telepon,
      this.selectedJenisDebitur,
      this.selectedJenisProduk,
      this.tanggalAkad,
      this.nomorAplikasi,
      this.nomorPerjanjian,
      this.selectedJenisCabang,
      this.plafond,
      this.selectedJenisInfo,
      this.selectedStatusKredit,
      this.namaPetugasBank,
      this.jabatanPetugasBank,
      this.teleponPetugasBank,
      this.selectedPengelolaPensiun,
      this.idPipeline,
      this.tanggalPencairan,
      this.path1);
  @override
  _DisbursmentEditNewScreen createState() => _DisbursmentEditNewScreen();
}

class _DisbursmentEditNewScreen extends State<DisbursmentEditNewScreen> {
  bool loadingScreen;
  var personalData = new List(38);
  String image1;
  String base64Image1;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;
  String path1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      getDataPencairan();
    });
  }

  String id;
  String namaPensiun;
  String alamat;
  String telepon;
  String selectedJenisDebitur;
  String selectedJenisProduk;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String selectedJenisCabang;
  String plafond;
  String selectedJenisInfo;
  String selectedStatusKredit;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String selectedPengelolaPensiun;
  String tanggalPencairan;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool visible = false;
  bool re_send = false;

  final tanggalPencairanController = TextEditingController();

  Future getDataPencairan() async {
    loadingScreen = true;
    String noAkad = widget.nomorAplikasi;
    String nikSales = widget.nik;
    bool re_send = false;
    //server login api
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getDataPencairan');
    //starting web api call
    var response = await http.post(url, body: {'no_akad': noAkad, 'nik_sales': nikSales});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Data_Pencairan'];
      print(message);
      setState(() {
        loadingScreen = false;
        tanggalPencairan = message[0]['tgl_pencairan'];
        id = message[0]['id'].toString();
        path1 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto3'].toString();
        images.replaceRange(0, 0 + 1, [path1]);
        image1 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto3'].toString();
        tanggalPencairanController.text = message[0]['tgl_pencairan'];
        print(images);
      });
    } else {
      setState(() {
        loadingScreen = false;
      });
      print('error');
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

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisbursmentScreen(
                        widget.username, message['nik_marsit'], message['status_karyawan'], '')));

            // if (message['hak_akses'] == '5') {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => LandingScreen(
            //           widget.username,
            //           message['nik_marsit'],
            //           message['income'],
            //           message['pict'],
            //           message['divisi'],
            //           message['greeting'],
            //           message['full_name'],
            //           message['hak_akses'],
            //           personalData,
            //           message['tarif'],
            //           message['diamond'])));
            // } else {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => LandingMrScreen(
            //           widget.username,
            //           message['nik_marsit'],
            //           message['income'],
            //           message['pict'],
            //           message['divisi'],
            //           message['greeting'],
            //           message['full_name'],
            //           message['hak_akses'],
            //           personalData,
            //           message['tarif'],
            //           message['diamond'])));
            // }
          }
        } else {}
      } else {
        print('error');
      }
    }
  }

  Future updateDisbursment() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
      re_send = false;
    });

    //getting value from controller
    tanggalPencairan = tanggalPencairanController.text;
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/updateDisbursmentNewXXXX');
    var response;
    if (path1 != '') {
      response = await http.post(url, body: {
        'id': id,
        'tanggal_pencairan': tanggalPencairan,
        'nik_sales': widget.nik,
        'telepon': widget.telepon,
        'image': '1'
      });
    } else {
      response = await http.post(url, body: {
        'id': id,
        'tanggal_pencairan': tanggalPencairan,
        'file_name': 'disbursment',
        'image1': base64Image1,
        'name1': image1,
        'nik_sales': widget.nik,
        'telepon': widget.telepon,
        'image': '0'
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Disbursment'];
      if (message.toString() == 'Update Success') {
        setState(() {
          visible = false;
          re_send = false;
          tanggalPencairanController.clear();
          image1 = null;
        });
        userLogin();
        Toast.show(
          'Sukses ubah data pencairan kredit...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
        );
      } else if (message.toString() == 'Nomor Aplikasi') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Maaf, nomor aplikasi sudah terdaftar, mohon masukkan nomor aplikasi yang lain...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
          re_send = false;
        });
        Toast.show(
          'Gagal ubah data pencairan kredit...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } else {
      re_send = true;
      Navigator.pop(context, false);
      await _onBackPressed(context);
    }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: visible == false
                ? Column(
                    children: [
                      Icon(
                        MdiIcons.informationOutline,
                        color: leadsGoColor,
                        size: 50.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Apakah anda ingin membatalkan perubahan?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          color: leadsGoColor,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Icon(
                        MdiIcons.alertCircleOutline,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Proses update pencairan tertunda!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 15),
                      re_send == false
                          ? SizedBox(height: 0)
                          : RaisedButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                                if (formKey.currentState.validate()) {
                                  if (image1 == null || image1 == '') {
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text('Mohon pilih foto bukti dana cair...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else {
                                    showGeneralDialog(
                                      context: context,
                                      barrierColor:
                                          Colors.black12.withOpacity(0.6), // background color
                                      barrierDismissible:
                                          false, // should dialog be dismissed when tapped outside
                                      barrierLabel: "Dialog", // label for barrier
                                      transitionDuration: Duration(
                                          milliseconds:
                                              400), // how long it takes to popup dialog after button click
                                      pageBuilder: (_, __, ___) {
                                        // your widget implementation
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircularProgressIndicator(
                                                //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                                valueColor:
                                                    AlwaysStoppedAnimation<Color>(leadsGoColor),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    updateDisbursment();
                                  }
                                }
                              },
                              color: Colors.blue,
                              child: Container(
                                width: 150,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(123),
                                  // color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Coba Lagi!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'LeadsGo-Font',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 20),
                      Column(children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                                child: Divider(
                                  color: Colors.black54,
                                  // height: 10,
                                )),
                          ),
                          Text(
                            'atau',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'LeadsGo-Font',
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                                child: Divider(
                                  color: Colors.black54,
                                  // height: 50,
                                )),
                          ),
                        ]),
                      ])
                    ],
                  ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  visible == false
                      ? SizedBox(height: 0)
                      : Text(
                          'Ingin membatalkan proses?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                  SizedBox(height: 15),
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
                          Navigator.pop(context, true);
                          // Navigator.of(context).pop(true);
                        },
                        color: visible == false ? leadsGoColor : Colors.red,
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

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          print('Back Button pressed!');
          final shouldPop = await _onBackPressed(context);
          return shouldPop;
        },
        // onWillPop: () async {
        //   visible
        //       ? showDialog(
        //           context: context,
        //           builder: (BuildContext context) => AlertDialog(
        //             title: Text('Mohon menunggu, sedang proses ubah pencairan kredit...'),
        //             //content: Text('We hate to see you leave...'),
        //             actions: <Widget>[
        //               FlatButton(
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: Text('OK'),
        //               ),
        //             ],
        //           ),
        //         )
        //       : Navigator.of(context).pop();
        // },
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: leadsGoColor,
              title: Text(
                'Ubah Pencairan',
                style: TextStyle(fontFamily: 'LeadsGo-Font'),
              ),
              actions: <Widget>[
                // loadingScreen
                //     ? Text('')
                //     : FlatButton(
                //         //LAKUKAN PENGECEKAN, JIKA _ISLOADING TRUE MAKA TAMPILKAN LOADING
                //         //JIKA FALSE, MAKA TAMPILKAN ICON SAVE
                //         child: Container(
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(4), color: Colors.white),
                //           padding: EdgeInsets.all(2.0),
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               'Ubah',
                //               style: TextStyle(
                //                   fontFamily: 'LeadsGo-Font',
                //                   color: leadsGoColor,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //         onPressed: () {
                //           print(image1);
                //           if (formKey.currentState.validate()) {
                //             if (image1 == null || image1 == '') {
                //               _scaffoldKey.currentState.showSnackBar(SnackBar(
                //                 content: Text('Mohon pilih foto bukti dana cair...'),
                //                 duration: Duration(seconds: 3),
                //               ));
                //             } else {
                //               showGeneralDialog(
                //                 context: context,
                //                 barrierColor: Colors.black12.withOpacity(0.6), // background color
                //                 barrierDismissible:
                //                     false, // should dialog be dismissed when tapped outside
                //                 barrierLabel: "Dialog", // label for barrier
                //                 transitionDuration: Duration(
                //                     milliseconds:
                //                         400), // how long it takes to popup dialog after button click
                //                 pageBuilder: (_, __, ___) {
                //                   // your widget implementation
                //                   return Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: <Widget>[
                //                       SizedBox(
                //                         height: 50,
                //                         width: 50,
                //                         child: CircularProgressIndicator(
                //                           //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                //                           valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                //                         ),
                //                       ),
                //                     ],
                //                   );
                //                 },
                //               );
                //               updateDisbursment();
                //             }
                //           }
                //         })
              ],
            ),
            body: loadingScreen
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    child: Form(
                      key: formKey,
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 100),
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Informasi Akad',
                              style: TextStyle(color: Colors.grey[600], fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    fieldDebitur('Tanggal Akad', setNull(widget.tanggalAkad), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    fieldDebitur(
                                        'Nomor Aplikasi', setNull(widget.nomorAplikasi), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    fieldDebitur(
                                        'Nomor Perjanjian', setNull(widget.nomorPerjanjian), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    fieldDebitur('Plafond', formatRupiah(widget.plafond), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    fieldDebitur(
                                        'Jenis Produk', setNull(widget.selectedJenisProduk), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    //   fieldDebitur(
                                    //       'Informasi Sales', setNull(widget.selectedJenisInfo), 120),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Informasi Petugas Bank',
                              style: TextStyle(color: Colors.grey[600], fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    fieldDebitur('Nama', setNull(widget.namaPetugasBank), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    fieldDebitur(
                                        'Jabatan', setNull(widget.jabatanPetugasBank), 120),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    fieldDebitur(
                                        'Telepon', setNull(widget.teleponPetugasBank), 120),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Data Pencairan',
                              style: TextStyle(color: Colors.grey[600], fontSize: 20),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                fieldTanggalPencairan(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Dokumen Pencairan',
                                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                                    ),
                                  ),
                                  path1 != null && path1 != ''
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  path1 = '';
                                                  image1 = '';
                                                  print(path1);
                                                });
                                              },
                                              child: Tooltip(
                                                message: 'Reset Photo',
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                              )))
                                      : Text('')
                                ],
                              )),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            //color: Colors.white,
                            child: Row(
                              children: <Widget>[Expanded(child: buildGridView())],
                            ),
                          ),
                        ],
                      ),
                    )),
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
                        color: leadsGoColor,
                        child: Container(
                          child: Center(
                            child: Text(
                              re_send == false ? 'Simpan Perubahan' : 'Simpan Kembali Perubahan',
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
                          if (formKey.currentState.validate()) {
                            if (image1 == null || image1 == '') {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih foto bukti dana cair...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else {
                              showGeneralDialog(
                                context: context,
                                barrierColor: Colors.black12.withOpacity(0.6), // background color
                                barrierDismissible:
                                    false, // should dialog be dismissed when tapped outside
                                barrierLabel: "Dialog", // label for barrier
                                transitionDuration: Duration(
                                    milliseconds:
                                        400), // how long it takes to popup dialog after button click
                                pageBuilder: (_, __, ___) {
                                  // your widget implementation
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(
                                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              updateDisbursment();
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'Rp ' + fmf.output.withoutFractionDigits;
  }

  Widget fieldDebitur(title, value, double size) {
    return Row(
      children: <Widget>[
        Container(
          width: 135,
          decoration: new BoxDecoration(
            color: leadsGoColor,
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
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: PhotoView(
                          imageProvider: FileImage(uploadModel.imageFile),
                          backgroundDecoration: BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    uploadModel.imageFile,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          if (path1 != '') {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: PhotoView(
                            imageProvider: NetworkImage(images[index]),
                            backgroundDecoration: BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      images[index],
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
            );
          } else {
            String titled;
            Color colored;
            if (index == 0) {
              titled = 'Foto Bukti Dana Cair';
              colored = leadsGoColor;
            }
            return Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: colored, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titled,
                    style: TextStyle(fontSize: 8.0, fontFamily: 'LeadsGo-Font'),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                ],
              ),
            );
          }
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker().pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        if (file == null) {
        } else {
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = File(file.path);
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          String base64Image = base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          }
        }
      });
    });
  }

  Widget fieldTanggalPencairan() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPencairanController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalPencairan == null) {
              return 'Tanggal pencairan wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Pencairan'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'LeadsGo-Font')),
    ]);
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'NULL';
    } else {
      return data;
    }
  }
}
