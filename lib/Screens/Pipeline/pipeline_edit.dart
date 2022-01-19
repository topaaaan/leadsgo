import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class PipelineEditScreen extends StatefulWidget {
  String username;
  String nik;
  String idPipeline;

  PipelineEditScreen(this.username, this.nik, this.idPipeline);
  @override
  _PipelineEditScreen createState() => _PipelineEditScreen();
}

class _PipelineEditScreen extends State<PipelineEditScreen> {
  bool loadingScreen;
  String image1;
  // String image2;
  String base64Image1;
  // String base64Image2;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;
  bool _isVisible = false;
  bool re_send = false;
  @override
  void initState() {
    // TODO: implement initState
    images.add("Add Image");
    // images.add("Add Image");
    super.initState();
    this.getCabang();
    // this.getBankTakeover();
    this.getDataPipeline();
  }

  String idFoto;
  String nomorKtp;
  String nomorNip;
  String namaPensiun;
  // String tempatLahir;
  String tanggalLahir;
  String alamat;
  String telepon;
  String plafond;
  String keteranganPensiun;
  String path1;
  // String path2;
  String path3;
  String salesFeedback;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedJenisCabang;
  // var selectedJenisDebitur;
  // var selectedBankTakeover;
  // List<String> _jenisDebiturType = <String>[
  //   'Prapensiun',
  //   'Pensiun',
  //   'Take over Kredit Aktif BTPN',
  //   'Pegawai Aktif PNS',
  //   'Pegawai Aktif BUMN',
  //   'Pegawai Perguruan Tinggi'
  // ];
  var selectedJenisKelamin;
  List<String> _jenisKelaminType = <String>['LAKI-LAKI', 'PEREMPUAN'];
  var selectedStatusKredit;
  List<String> _jenisStatusKreditType = <String>[
    'NEW LOAN',
    'TOP UP',
    'TAKEOVER'
  ];

  var selectedPengelolaPensiun;
  List<String> _jenisPengelolaPensiunType = <String>[
    'TASPEN',
    'ASABRI',
    'BUMN / BUMD',
    'DANA PENSIUN'
  ];

  var selectedFeedBack;
  List<String> _selectfeedback = <String>[
    'MASIH PIKIR-PIKIR (50%)',
    'BERMINAT, BUTUH DISKUSI KELUARGA (75%)',
    'SUDAH SIMULASI DAN BERMINAT (100%)'
  ];

  // String nomorNpwp;
  String keterangan;
  var personalData = new List(34);

  final String url =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getCabang';
  List data =
      List(); //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY
  // final String url2 =
  //     'https://tetranabasainovasi.com/api_marsit_v1/service.php/getBankTakeover';
  // List data2 =
  //     List(); //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY
  bool visible = false;
  final nomorKtpController = TextEditingController();
  final nomorNipController = TextEditingController();
  final namaPensiunController = TextEditingController();
  // final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  // final keteranganPensiunController = TextEditingController();
  final plafondController = TextEditingController();
  // final nomorNpwpController = TextEditingController();
  final idFotoController = TextEditingController();
  final salesFeedbackController = TextEditingController();

  Future getDataPipeline() async {
    loadingScreen = true;
    String idPipeline = widget.idPipeline;
    String nikSales = widget.nik;
    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDataPipeline');
    //starting web api call
    var response = await http
        .post(url, body: {'id_pipeline': idPipeline, 'nik_sales': nikSales});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Data_Pipeline'];
      print(message);
      setState(() {
        loadingScreen = false;
        tanggalLahir = message[0]['tgl_lahir'];
        idFotoController.text = message[0]['id_foto'];
        nomorKtpController.text = message[0]['no_ktp'];
        nomorNipController.text = message[0]['no_nip'];
        namaPensiunController.text = message[0]['cadeb'];
        teleponController.text = message[0]['telepon'];
        alamatController.text = message[0]['alamat'];
        salesFeedbackController.text = message[0]['keterangan'];
        // tempatLahirController.text = message[0]['tempat_lahir'];
        tanggalLahirController.text = message[0]['tgl_lahir'];
        // nomorNpwpController.text = message[0]['npwp'];
        if (message[0]['jenis_kelamin'].toString() == '0') {
          selectedJenisKelamin = 'LAKI-LAKI';
        } else {
          selectedJenisKelamin = 'PEREMPUAN';
        }
        plafondController.text = message[0]['nominal'];
        // keteranganPensiunController.text = message[0]['keterangan'];
        // if (message[0]['jenis_produk'] == '0') {
        //   selectedJenisDebitur = 'Prapensiun';
        // } else if (message[0]['jenis_produk'] == '1') {
        //   selectedJenisDebitur = 'Pensiun';
        // } else if (message[0]['jenis_produk'] == '2') {
        //   selectedJenisDebitur = 'Take over Kredit Aktif BTPN';
        // } else if (message[0]['jenis_produk'] == '3') {
        //   selectedJenisDebitur = 'Pegawai Aktif PNS';
        // } else if (message[0]['jenis_produk'] == '4') {
        //   selectedJenisDebitur = 'Pegawai Aktif BUMN';
        // } else if (message[0]['jenis_produk'] == '5') {
        //   selectedJenisDebitur = 'Pegawai Perguruan Tinggi';
        // }
        selectedJenisCabang = message[0]['cabang'];
        selectedStatusKredit = message[0]['status_kredit'];
        // if (selectedStatusKredit == 'TAKEOVER') {
        //   String bankTakeovernya = '';
        //   bankTakeovernya = message[0]['bank_takeover'];
        //   selectedBankTakeover = bankTakeovernya;
        // }
        selectedPengelolaPensiun = message[0]['pengelola_pensiun'];
        // selectedFeedBack = message[0]['keterangan'];
        path1 = 'https://tetranabasainovasi.com/marsit/' +
            message[0]['foto1'].toString();
        // path2 = 'https://tetranabasainovasi.com/marsit/' +
        //     message[0]['foto2'].toString();
        images.replaceRange(0, 0 + 1, [path1]);
        image1 = 'https://tetranabasainovasi.com/marsit/' +
            message[0]['foto1'].toString();
        // images.replaceRange(1, 1 + 1, [path2]);
        // image2 = 'https://tetranabasainovasi.com/marsit/' +
        //     message[0]['foto2'].toString();
      });
    } else {
      setState(() {
        loadingScreen = false;
      });
      print('error');
    }
  }

  // ignore: missing_return
  Future<String> getCabang() async {
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res =
        await http.get(Uri.parse(url), headers: {'accept': 'application/json'});
    var resBody = json.decode(res.body)['Daftar_Cabang'];
    setState(() {
      data = resBody;
      print(data);
    });
  }

  // Future<String> getBankTakeover() async {
  //   var res = await http
  //       .get(Uri.encodeFull(url2), headers: {'accept': 'application/json'});
  //   var resBody = json.decode(res.body)['Daftar_Bank_Takeover'];
  //   setState(() {
  //     data2 = resBody;
  //   });
  // }

  Future updatePipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    idFoto = idFotoController.text;
    nomorKtp = nomorKtpController.text;
    nomorNip = nomorNipController.text;
    namaPensiun = namaPensiunController.text;
    telepon = teleponController.text;
    alamat = alamatController.text;
    // tempatLahir = tempatLahirController.text;
    tanggalLahir = tanggalLahirController.text;
    // nomorNpwp = nomorNpwpController.text;
    plafond = plafondController.text;
    salesFeedback = salesFeedbackController.text;
    // keteranganPensiun = keteranganPensiunController.text;

    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/editPipeline');
    var response;
    // String bankTakeovernya;
    // if (selectedBankTakeover == null) {
    //   bankTakeovernya = '';
    // } else {
    //   bankTakeovernya = selectedBankTakeover;
    // }
    // if (path1 != '' && path2 != '') {
    if (path1 != '') {
      response = await http.post(url, body: {
        'id_pipeline': widget.idPipeline,
        'niksales': widget.nik,
        'nama_pensiun': namaPensiun,
        'nomor_ktp': nomorKtp,
        'nomor_nip': nomorNip,
        'telepon': telepon,
        'alamat': alamat,
        'tanggal_lahir': tanggalLahir,
        'jenis_kelamin': selectedJenisKelamin,
        'plafond': plafond,
        'jenis_cabang': selectedJenisCabang,
        'status_kredit': selectedStatusKredit,
        'pengelola_pensiun': selectedPengelolaPensiun,
        'keterangan': salesFeedback,
        // 'keterangan': selectedFeedBack,
        'image': '1',
        'id_foto': idFoto
      });
    } else {
      response = await http.post(url, body: {
        'id_pipeline': widget.idPipeline,
        'niksales': widget.nik,
        'nama_pensiun': namaPensiun,
        'nomor_ktp': nomorKtp,
        'nomor_nip': nomorNip,
        'telepon': telepon,
        'alamat': alamat,
        'tanggal_lahir': tanggalLahir,
        'jenis_kelamin': selectedJenisKelamin,
        'plafond': plafond,
        'jenis_cabang': selectedJenisCabang,
        'status_kredit': selectedStatusKredit,
        'pengelola_pensiun': selectedPengelolaPensiun,
        'keterangan': salesFeedback,
        // 'keterangan': selectedFeedBack,
        'file_name': 'pipeline',
        'image1': base64Image1,
        'name1': image1,
        'image': '0',
        'id_foto': idFoto
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Pipeline'];
      if (message.toString() == 'Update Success') {
        setState(() {
          visible = false;
          re_send = false;
          namaPensiunController.clear();
          alamatController.clear();
          teleponController.clear();
          // selectedJenisDebitur = null;
          selectedJenisCabang = null;
          selectedStatusKredit = null;
          selectedPengelolaPensiun = null;
          plafondController.clear();
          // keteranganPensiunController.clear();
        });
        Toast.show(
          'Sukses update pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
          re_send = false;
        });
        Toast.show(
          'Gagal update pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      }
    } else {
      setState(() {
        re_send = true;
      });
      Navigator.pop(context, false);
      await _onBackPressed(context);
    }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                        'Apakah anda ingin membatalkan pengisian?',
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
                        MdiIcons.cancel,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Proses ubah pipeline tertunda!',
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
                                  if (selectedJenisKelamin == null) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Mohon pilih jenis kelamin...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (selectedJenisCabang == null) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Mohon pilih kantor cabang...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (selectedStatusKredit == null) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Mohon pilih status kredit...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (selectedPengelolaPensiun == null) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Mohon pilih pengelola pensiun...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (image1 == null) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Mohon pilih foto ktp...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else {
                                    showGeneralDialog(
                                      context: context,
                                      barrierColor: Colors.black12
                                          .withOpacity(0.6), // background color
                                      barrierDismissible:
                                          false, // should dialog be dismissed when tapped outside
                                      barrierLabel:
                                          "Dialog", // label for barrier
                                      transitionDuration: Duration(
                                          milliseconds:
                                              400), // how long it takes to popup dialog after button click
                                      pageBuilder: (_, __, ___) {
                                        // your widget implementation
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircularProgressIndicator(
                                                //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(leadsGoColor),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    updatePipeline();
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
                                    'Simpan Kembali!',
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
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: leadsGoColor,
              title: Text(
                'Ubah Pipeline',
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
                //           if (formKey.currentState.validate()) {
                //             if (selectedJenisKelamin == null) {
                //               _scaffoldKey.currentState.showSnackBar(SnackBar(
                //                 content: Text('Mohon pilih jenis kelamin...'),
                //                 duration: Duration(seconds: 3),
                //               ));
                //               // } else if (selectedJenisDebitur == null) {
                //               //   _scaffoldKey.currentState.showSnackBar(SnackBar(
                //               //     content: Text('Mohon pilih jenis produk...'),
                //               //     duration: Duration(seconds: 3),
                //               //   ));
                //             } else if (selectedJenisCabang == null) {
                //               _scaffoldKey.currentState.showSnackBar(SnackBar(
                //                 content: Text('Mohon pilih kantor cabang...'),
                //                 duration: Duration(seconds: 3),
                //               ));
                //             } else if (selectedStatusKredit == null) {
                //               _scaffoldKey.currentState.showSnackBar(SnackBar(
                //                 content: Text('Mohon pilih status kredit...'),
                //                 duration: Duration(seconds: 3),
                //               ));
                //             } else if (selectedPengelolaPensiun == null) {
                //               _scaffoldKey.currentState.showSnackBar(SnackBar(
                //                 content: Text('Mohon pilih pengelola pensiun...'),
                //                 duration: Duration(seconds: 3),
                //               ));
                //             } else if (image1 == null || image1 == '') {
                //               _scaffoldKey.currentState.showSnackBar(SnackBar(
                //                 content: Text('Mohon pilih foto ktp...'),
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
                //                       // TEST REQUEST
                //                       // new Text(
                //                       //   widget.nik,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   namaPensiunController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   nomorKtpController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   nomorNipController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   teleponController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   alamatController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   tanggalLahirController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   selectedJenisKelamin,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   plafondController.text,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   selectedJenisCabang,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   selectedStatusKredit,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   selectedPengelolaPensiun,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   selectedFeedBack,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                       // new Text(
                //                       //   image1,
                //                       //   style: TextStyle(
                //                       //       color: leadsGoColor, fontSize: 12),
                //                       // ),
                //                     ],
                //                   );
                //                 },
                //               );
                //               updatePipeline();
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
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                            child: Text(
                              'Data Nasabah',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  fieldDebitur(),
                                  fieldKtp(),
                                  fieldNip(),
                                  // fieldNomorNpwp(),
                                  fieldTelepon(),
                                  fieldAlamat(),
                                  // fieldTempatLahir(),
                                  fieldTanggalLahir(),
                                  fieldJenisKelamin(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                            child: Text(
                              'Data Kredit',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  fieldPlafond(),
                                  // fieldKeterangan(),
                                  // fieldJenisDebitur(),
                                  fieldKantorCabang(),
                                  fieldStatusKredit(),
                                  // Visibility(
                                  //     visible: _isVisible,
                                  //     child: fieldBankTakeOver()),
                                  fieldPengelolaPensiun(),
                                  // fieldFeedBack(),
                                  fieldSalesFeedbackString(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 8.0,
                                  right: 16.0,
                                  bottom: 8.0),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Dokumen Nasabah',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 20),
                                    ),
                                  ),
                                  // path1 != null && path1 != ''
                                  //     ? Align(
                                  //         alignment: Alignment.centerRight,
                                  //         child: InkWell(
                                  //             onTap: () {
                                  //               setState(() {
                                  //                 path1 = '';
                                  //                 image1 = '';
                                  //                 // image2 = '';
                                  //               });
                                  //             },
                                  //             child: Tooltip(
                                  //               message: 'Reset Photo',
                                  //               child: Icon(
                                  //                 Icons.remove_circle,
                                  //                 color: Colors.red,
                                  //               ),
                                  //             )))
                                  //     : Text('')
                                ],
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              //color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: buildGridView())
                                ],
                              ),
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
                              re_send == false
                                  ? 'Simpan Perubahan'
                                  : 'Simpan Kembali Perubahan',
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
                            if (selectedJenisKelamin == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih jenis kelamin...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedJenisCabang == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih kantor cabang...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedStatusKredit == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih status kredit...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedPengelolaPensiun == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text('Mohon pilih pengelola pensiun...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (image1 == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih foto ktp...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else {
                              showGeneralDialog(
                                context: context,
                                barrierColor: Colors.black12
                                    .withOpacity(0.6), // background color
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(
                                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  leadsGoColor),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              updatePipeline();
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

  Widget fieldKtp() {
    return TextFormField(
      controller: nomorKtpController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor KTP wajib diisi...';
        } else if (value.length < 16 && value.length > 16) {
          return 'Nomor KTP harus 16 digit...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor KTP'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
      // enabled: false,
    );
  }

  Widget fieldNip() {
    return TextFormField(
      controller: nomorNipController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor NIP/NOPEN/NRP wajib diisi...';
        } else if (value.length < 6) {
          return 'Nomor NIP/NOPEN/NRP minimal 6 digit...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor NIP/NOPEN/NRP'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  // Widget fieldTempatLahir() {
  //   return TextFormField(
  //     controller: tempatLahirController,
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'Tempat lahir wajib diisi...';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(labelText: 'Tempat Lahir'),
  //     textCapitalization: TextCapitalization.characters,
  //     style: TextStyle(fontFamily: 'LeadsGo-Font'),
  //   );
  // }

  Widget fieldTanggalLahir() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalLahirController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalLahir == null) {
              return 'Tanggal Lahir wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Lahir'),
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

  Widget fieldJenisKelamin() {
    return DropdownButtonFormField(
        items: _jenisKelaminType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisKelaminType) {
          setState(() {
            selectedJenisKelamin = selectedJenisKelaminType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Kelamin',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedJenisKelamin,
        isExpanded: true);
  }

  // Widget fieldNomorNpwp() {
  //   return TextFormField(
  //     controller: nomorNpwpController,
  //     decoration: InputDecoration(labelText: 'Nomor NPWP'),
  //     keyboardType: TextInputType.number,
  //     inputFormatters: <TextInputFormatter>[
  //       WhitelistingTextInputFormatter.digitsOnly
  //     ],
  //     style: TextStyle(fontFamily: 'LeadsGo-Font'),
  //   );
  // }

  Widget fieldDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama lengkap...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama Lengkap'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldAlamat() {
    return TextFormField(
      controller: alamatController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Alamat wajib diisi...';
        } else if (value.length < 10) {
          return 'Alamat minimal 10 karakter...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Alamat'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
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
      decoration: InputDecoration(labelText: 'No Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  // Widget fieldJenisDebitur() {
  //   return DropdownButtonFormField(
  //       items: _jenisDebiturType
  //           .map((value) => DropdownMenuItem(
  //                 child: Text(
  //                   value,
  //                   style: TextStyle(
  //                     fontFamily: 'LeadsGo-Font',
  //                   ),
  //                 ),
  //                 value: value,
  //               ))
  //           .toList(),
  //       onChanged: (selectedJenisDebiturType) {
  //         setState(() {
  //           selectedJenisDebitur = selectedJenisDebiturType;
  //         });
  //       },
  //       decoration: InputDecoration(
  //           labelText: 'Jenis Produk',
  //           contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //           labelStyle: TextStyle(
  //             fontFamily: 'LeadsGo-Font',
  //           )),
  //       value: selectedJenisDebitur,
  //       isExpanded: true);
  // }

  Widget fieldKantorCabang() {
    return DropdownButtonFormField(
        items: data
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value['NAMA'],
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                    ),
                  ),
                  value: value['NAMA'].toString(),
                ))
            .toList(),
        onChanged: (selectedJenisCabangType) {
          setState(() {
            selectedJenisCabang = selectedJenisCabangType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Kantor Cabang',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedJenisCabang,
        isExpanded: true);
  }

  Widget fieldPlafond() {
    return TextFormField(
        controller: plafondController,
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Rencana pinjaman wajib diisi...';
        //   } else if (value.length < 8) {
        //     return 'Rencana pinjaman minimal 8 digit...';
        //   } else if (value.length > 9) {
        //     return 'Rencana pinjaman maksimal 9 digit...';
        //   }
        //   return null;
        // },
        decoration: InputDecoration(labelText: 'Rencana Pinjaman'),
        keyboardType: TextInputType.number,
        inputFormatters: [DecimalFormatter()],
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }

  // Widget fieldKeterangan() {
  //   return TextFormField(
  //     controller: keteranganPensiunController,
  //     decoration: InputDecoration(labelText: 'Keterangan'),
  //     textCapitalization: TextCapitalization.characters,
  //     style: TextStyle(fontFamily: 'LeadsGo-Font'),
  //   );
  // }

  Widget fieldStatusKredit() {
    return DropdownButtonFormField(
        items: _jenisStatusKreditType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedStatusKreditType) {
          setState(() {
            selectedStatusKredit = selectedStatusKreditType;
            if (selectedStatusKredit == 'TAKEOVER') {
              _isVisible = true;
            } else {
              _isVisible = false;
            }
            // print(selectedBankTakeover);
          });
        },
        decoration: InputDecoration(
            labelText: 'Status Kredit',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedStatusKredit,
        isExpanded: true);
  }

  // Widget fieldBankTakeOver() {
  //   return DropdownButtonFormField(
  //       items: data2
  //           .map((value) => DropdownMenuItem(
  //                 child: Text(
  //                   value['nama'],
  //                   style: TextStyle(
  //                     fontFamily: 'LeadsGo-Font',
  //                   ),
  //                 ),
  //                 value: value['nama'].toString(),
  //               ))
  //           .toList(),
  //       onChanged: (selectedBankTakeoverType) {
  //         setState(() {
  //           selectedBankTakeover = selectedBankTakeoverType;
  //         });
  //       },
  //       decoration: InputDecoration(
  //           labelText: 'Bank Takeover',
  //           contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //           labelStyle: TextStyle(
  //             fontFamily: 'LeadsGo-Font',
  //           )),
  //       value: selectedBankTakeover,
  //       isExpanded: true);
  // }

  Widget fieldPengelolaPensiun() {
    return DropdownButtonFormField(
        items: _jenisPengelolaPensiunType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisPengelolaPensiunType) {
          setState(() {
            selectedPengelolaPensiun = selectedJenisPengelolaPensiunType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Pengelola Pensiun',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedPengelolaPensiun,
        isExpanded: true);
  }

  Widget fieldSalesFeedbackString() {
    return TextFormField(
      controller: salesFeedbackController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Sales Feedback wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Sales Feedback'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldFeedBack() {
    return DropdownButtonFormField(
        items: _selectfeedback
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedExFeedBack) {
          setState(() {
            selectedFeedBack = selectedExFeedBack;
          });
        },
        decoration: InputDecoration(
            labelText: 'Feedback',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedFeedBack,
        isExpanded: true);
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
            shape: RoundedRectangleBorder(
                side: new BorderSide(color: leadsGoColor, width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
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
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
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
                      size: 25,
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
          // if (path1 != '' && path2 != '') {
          if (path1 != '') {
            return Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: leadsGoColor, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
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
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
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
                  Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              path1 = '';
                              image1 = '';
                              // image2 = '';
                            });
                          },
                          child: Tooltip(
                            message: 'Reset Photo',
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ))),
                ],
              ),
            );
          } else {
            String titled;
            Color colored;
            // if (index == 0) {
            titled = 'Foto KTP';
            colored = leadsGoColor;
            // } else if (index == 1) {
            //   titled = 'Foto NPWP';
            //   colored = leadsGoColor;
            // }
            return Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: colored, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titled,
                    style:
                        TextStyle(fontSize: 14.0, fontFamily: 'LeadsGo-Font'),
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
          String base64Image =
              base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          // if (index == 0) {
          image1 = fileName;
          base64Image1 = base64Image;
          // } else if (index == 1) {
          //   image2 = fileName;
          //   base64Image2 = base64Image;
          // }
        }
      });
    });
  }
}

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9\.]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > this.decimalDigits)) {
        return oldValue;
      } else
        return newValue;
    }

    //in case if input is empty or zero
    if (newText.trim() == '' || newText.trim() == '0') {
      return newValue.copyWith(text: '');
    } else if (int.parse(newText) < 1) {
      return newValue.copyWith(text: '');
    }

    double newDouble = double.parse(newText);
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = NumberFormat("#,##0.##").format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
