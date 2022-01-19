import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class PipelineAddScreen extends StatefulWidget {
  String username;
  String nik;

  PipelineAddScreen(this.username, this.nik);
  @override
  _PipelineAddScreen createState() => _PipelineAddScreen();
}

class _PipelineAddScreen extends State<PipelineAddScreen> {
  bool loadingScreen = false;
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
  }

  String namaPensiun;
  String nomorKtp;
  String nomorNip;
  String telepon;
  String alamat;
  String tanggalLahir;
  String plafond;
  String salesFeedback;

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedJenisCabang;
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
  // String keterangan;
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
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final plafondController = TextEditingController();
  final salesFeedbackController = TextEditingController();

  // final tempatLahirController = TextEditingController();
  // final keteranganPensiunController = TextEditingController();
  // final nomorNpwpController = TextEditingController();

  // ignore: missing_return
  Future<String> getCabang() async {
    setState(() {
      loadingScreen = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res =
        await http.get(Uri.parse(url), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      setState(() {
        if (json.decode(res.body)['Daftar_Cabang'] == '') {
          loadingScreen = false;
        } else {
          var resBody = json.decode(res.body)['Daftar_Cabang'];
          loadingScreen = false;
          data = resBody;
        }
      });
    }
  }

  // Future<String> getBankTakeover() async {
  //   var res = await http
  //       .get(Uri.encodeFull(url2), headers: {'accept': 'application/json'});
  //   var resBody = json.decode(res.body)['Daftar_Bank_Takeover'];
  //   setState(() {
  //     data2 = resBody;
  //   });
  // }

  Future savePipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    namaPensiun = namaPensiunController.text;
    nomorKtp = nomorKtpController.text;
    nomorNip = nomorNipController.text;
    telepon = teleponController.text;
    alamat = alamatController.text;
    tanggalLahir = tanggalLahirController.text;
    plafond = plafondController.text;
    salesFeedback = salesFeedbackController.text;

    // tempatLahir = tempatLahirController.text;
    // nomorNpwp = nomorNpwpController.text;
    // keteranganPensiun = keteranganPensiunController.text;

    //server save api
    var url = Uri.parse(
        "https://tetranabasainovasi.com/api_marsit_v1/service.php/savePipeline");
    // String bankTakeovernya;
    // if (selectedBankTakeover == null) {
    //   bankTakeovernya = '';
    // } else {
    //   bankTakeovernya = selectedBankTakeover;
    // }

    //starting web api call

    var response = await http.post(url, body: {
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
      "keterangan": salesFeedback,
      // 'keterangan': selectedFeedBack,
      'file_name': 'pipeline',
      'image1': base64Image1,
      'name1': image1,

      // 'bank_takeover': bankTakeovernya, // TIDAK DI PAKAI SAAT TAMBAH PIPELINE
      // 'jenis_debitur': selectedJenisDebitur, // TIDAK DI PAKAI SAAT TAMBAH PIPELINE
      // 'tempat_lahir': tempatLahir,
      // 'nomor_npwp': nomorNpwp,
      // 'image2': base64Image2,
      // 'name2': image2,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Pipeline'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          re_send = false;
          namaPensiunController.clear(); // NAMA LENGKAP
          nomorKtpController.clear(); // NOMOR KTP
          nomorNipController.clear(); // NOMOR NIP
          teleponController.clear(); // NO TELEPON
          alamatController.clear(); // ALAMAT
          tanggalLahirController.clear(); // TANGGAL LAHIR
          selectedJenisKelamin = null; // JENIS KELAMIN
          plafondController.clear(); // RENCANA PINJAMAN (PLAFON)
          selectedJenisCabang = null; // CABANG
          selectedStatusKredit = null; // STATUS KREDIT
          selectedPengelolaPensiun = null; // PENGELOLAH PENSIUN
          selectedFeedBack = null; // FEEDBACK === KETERANGAN
          salesFeedbackController.clear();
          // selectedJenisDebitur = null;
          // keteranganPensiunController.clear();
        });
        Toast.show(
          'Sukses menambahkan data pipeline...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else if (message.toString() == 'Data Sama') {
        setState(() {
          visible = false;
          re_send = false;
        });
        Toast.show(
          'Nomor KTP atau Telepon Tidak Boleh Sama!',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
          re_send = false;
        });
        Toast.show(
          'Gagal menambahkan data pipeline...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).push(MaterialPageRoute(
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
                        'Proses simpan pipeline tertunda!',
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
                                                AlwaysStoppedAnimation<Color>(
                                                    leadsGoColor),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                savePipeline();
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
    return loadingScreen
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
              ),
            ),
          )
        : WillPopScope(
            // onWillPop: () async {
            //   visible
            //       ? Toast.show(
            //           'Mohon menunggu, sedang proses penyimpanan pipeline...',
            //           context,
            //           duration: Toast.LENGTH_LONG,
            //           gravity: Toast.BOTTOM,
            //           backgroundColor: Colors.red,
            //         )
            //       : Navigator.of(context).pop(true);
            // },
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
                    'Tambah Pipeline',
                    style: TextStyle(fontFamily: 'LeadsGo-Font'),
                  ),
                  actions: <Widget>[
                    re_send == true
                        ? Container(
                            padding:
                                const EdgeInsets.fromLTRB(0, 20.0, 10.0, 0),
                            child: Text(
                              'Proses Pending',
                              style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                                color: Colors.white54,
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                body: Container(
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
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
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
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
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
                                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                            child: Text(
                              'Dokumen Nasabah',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              padding: EdgeInsets.all(10),
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
                                      ? 'Simpan Pipeline'
                                      : 'Simpan Kembali!',
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
                                    barrierLabel: "Dialog", // label for barrier
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
                                                  AlwaysStoppedAnimation<Color>(
                                                      leadsGoColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  savePipeline();
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
            if (dateTime == null) {
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
          String titled;
          Color colored;
          // if (index == 0) {
          titled = 'Upload Foto KTP';
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
              ));
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
