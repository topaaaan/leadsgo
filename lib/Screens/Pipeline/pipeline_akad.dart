import 'dart:convert';
import 'dart:io';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
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

import 'package:leadsgo_apps/Screens/Disbursment/disbursment_screen.dart';

// ignore: must_be_immutable
class PipelineAkadScreen extends StatefulWidget {
  String idIM;
  String username;
  String nik;
  String id;
  String status;
  // String statusKredit;
  String debitur;
  String noKtp;
  String noNip;
  String telepon;
  String nominal;
  String cabang;
  String tanggalPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String tanggalAkad;
  // String nomorAplikasi;
  String nomorRekening;
  String nomorPerjanjian;
  String nominalPinjaman;
  String finalOS;
  String nominalTopUp;
  String jenisProduk;
  String informasiSales;
  String namaPetugasBank;
  // String jabatanPetugasBank;
  String kodeAO;
  String teleponPetugasBank;
  String fotoAkad1;
  String fotoAkad2;

  PipelineAkadScreen(
    this.idIM,
    this.username,
    this.nik,
    this.id,
    this.status,
    // this.statusKredit,
    this.debitur,
    this.noKtp,
    this.noNip,
    this.telepon,
    this.nominal,
    this.cabang,
    this.tanggalPenyerahan,
    this.namaPenerima,
    this.teleponPenerima,
    this.tanggalAkad,
    // this.nomorAplikasi,
    this.nomorRekening,
    this.nomorPerjanjian,
    this.nominalPinjaman,
    this.finalOS,
    this.nominalTopUp,
    this.jenisProduk,
    this.informasiSales,
    this.namaPetugasBank,
    // this.jabatanPetugasBank,
    this.kodeAO,
    this.teleponPetugasBank,
    this.fotoAkad1,
    this.fotoAkad2,
  );
  @override
  _PipelineAkadScreen createState() => _PipelineAkadScreen();
}

class _PipelineAkadScreen extends State<PipelineAkadScreen> {
  bool visible = false;
  bool re_send = false;
  bool _isVisible = false;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String image1, image2;
  String base64Image1, base64Image2;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;

  // var selectedJenisProduk;
  // List<String> _jenisProdukType = <String>[
  //   'Fleksi BNI',
  //   'KP74 BTPN',
  //   'KP74 BJB'
  // ];
  // var selectedJenisInfo;
  // List<String> _jenisInfoType = <String>[
  //   'REFERAL',
  //   'WALK IN',
  //   'INTERAKSI',
  //   'SMS BLAST PUSAT',
  //   'SOSIAL MEDIA',
  //   'SOSIALISASI INSTANSI',
  //   'TELEMARKETING PUSAT'
  // ];
  var selectedStatusKredit;
  List<String> _jenisStatusKreditType = <String>[
    'NEW LOAN',
    'TOP UP',
    'TAKEOVER'
  ];

  @override
  void initState() {
    // TODO: implement initState
    images.add("Add Image");
    images.add("Add Image");
    super.initState();
    this.setDataPipeline();
  }

  String tanggalAkad;
  String nomorRekening;
  String nomorPerjanjian;
  String plafond;
  String finalOS;
  String nominalTopUp;
  String namaPetugasBank;
  // String jabatanPetugasBank;
  String kodeAO;
  String teleponPetugasBank;
  String valueJenisProduk;
  String path1 = '';
  String path2 = '';
  String action = 'Simpan';

  final tanggalPerjanjianController = TextEditingController();
  final nomorRekeningController = TextEditingController();
  final nomorPerjanjianController = TextEditingController();
  final plafondController = TextEditingController();
  final finalOSController = TextEditingController();
  final nominalTopUpController = TextEditingController();

  final namaPetugasBankController = TextEditingController();
  // final jabatanPetugasBankController = TextEditingController();
  final kodeAOController = TextEditingController();
  final teleponPetugasBankController = TextEditingController();
  final valueJenisProdukController = TextEditingController();

  Future setDataPipeline() async {
    String idPipeline = widget.id;
    String nikSales = widget.nik;
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDataPipeline');
    //starting web api call
    var response = await http
        .post(url, body: {'id_pipeline': idPipeline, 'nik_sales': nikSales});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Data_Pipeline'];
      print(message);
      setState(() {
        print(widget.tanggalAkad);
        if (widget.tanggalAkad == null || widget.tanggalAkad == 'null') {
          plafondController.text = widget.nominal;
          selectedStatusKredit = message[0]['status_kredit'];
        } else {
          selectedStatusKredit = message[0]['status_kredit'];
          tanggalPerjanjianController.text = widget.tanggalAkad;
          nomorRekeningController.text = widget.nomorRekening;
          nomorPerjanjianController.text = widget.nomorPerjanjian;
          plafondController.text = widget.nominalPinjaman;
          finalOSController.text = widget.finalOS;
          nominalTopUpController.text = widget.nominalTopUp;
          namaPetugasBankController.text = widget.namaPetugasBank;
          kodeAOController.text = widget.kodeAO;
          kodeAOController.text = widget.kodeAO;
          teleponPetugasBankController.text = widget.teleponPetugasBank;
          // if (widget.jenisProduk == 'Flexi') {
          //   selectedJenisProduk = 'Fleksi BNI';
          // } else if (widget.jenisProduk == 'KP74') {
          //   selectedJenisProduk = 'KP74 BTPN';
          // } else {
          //   selectedJenisProduk = 'KP74 BJB';
          // }
          // selectedJenisInfo = widget.informasiSales;
          // jabatanPetugasBankController.text = widget.jabatanPetugasBank;
          if (widget.status == '2') {
            path1 = 'https://tetranabasainovasi.com/marsit/' + widget.fotoAkad1;
            path2 = 'https://tetranabasainovasi.com/marsit/' + widget.fotoAkad2;
          } else {
            path1 =
                'https://tetranabasainovasi.com/marsit/assets/images/pencairan_sales/' +
                    widget.fotoAkad1;
            path2 =
                'https://tetranabasainovasi.com/marsit/assets/images/pencairan_sales/' +
                    widget.fotoAkad2;
          }
          ;

          // images.replaceRange(0, 0 + 1, [path1]);
          images.replaceRange(0, 0 + 1, [path1]);
          image1 =
              'https://tetranabasainovasi.com/marsit/assets/images/pencairan_sales/' +
                  widget.fotoAkad1;
          // images.replaceRange(1, 1 + 1, [path2]);
          images.replaceRange(1, 1 + 1, [path2]);
          image2 =
              'https://tetranabasainovasi.com/marsit/assets/images/pencairan_sales/' +
                  widget.fotoAkad2;
          action = 'Ubah';
        }

        if (selectedStatusKredit == 'TOP UP') {
          _isVisible = true;
        } else {
          _isVisible = false;
        }
      });
    } else {
      print('error');
    }
  }

  Future submitPipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
      re_send = false;
    });

    //getting value from controller
    tanggalAkad = tanggalPerjanjianController.text;
    nomorRekening = nomorRekeningController.text;
    nomorPerjanjian = nomorPerjanjianController.text;

    plafond = plafondController.text;
    finalOS = finalOSController.text;
    nominalTopUp = nominalTopUpController.text;
    namaPetugasBank = namaPetugasBankController.text;
    // jabatanPetugasBank = jabatanPetugasBankController.text;
    kodeAO = kodeAOController.text;
    teleponPetugasBank = teleponPetugasBankController.text;

    valueJenisProduk = widget.jenisProduk;
    if (widget.jenisProduk == '1') {
      valueJenisProduk = 'Pegawai Aktif PNS / TNI / POLRI';
    } else if (widget.jenisProduk == '2') {
      valueJenisProduk = 'Prapensiun';
    } else if (widget.jenisProduk == '3') {
      valueJenisProduk = 'Pensiun';
    } else if (widget.jenisProduk == '4') {
      valueJenisProduk = 'Kredit Insidentil';
    } else if (widget.jenisProduk == '5') {
      valueJenisProduk = 'Kredit Platinum 74 (BTPN)';
    } else if (widget.jenisProduk == '6') {
      valueJenisProduk = 'Kredit Platinum 74 (BJB)';
    } else {
      valueJenisProduk = 'Tidak Ada';
    }

    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/akadPipeline_2');

    //starting web api call
    var response;

    if (widget.status == '2' && widget.idIM != '') {
      print('THIS PENCAIRAN!');
      if (path1 != '' && path2 != '') {
        // EDIT DATA
        print('PENCAIRAN->EDIT_AKAD_NO_PICT');
        response = await http.post(url, body: {
          'im_id': widget.idIM,
          'status': widget.status,
          'niksales': widget.nik,
          'telepon': widget.telepon,
          'id_pipeline': widget.id,
          'tanggal_akad': tanggalAkad,
          'nomor_rekening': nomorRekening,
          'nomor_perjanjian': nomorPerjanjian,
          'nominal_pinjaman': plafond,
          'nominal_os_akhir': finalOS,
          'nominal_top_up': nominalTopUp,
          'jenis_produk': valueJenisProduk,
          'status_kredit': selectedStatusKredit,
          'nama_petugas_bank': namaPetugasBank,
          'kode_ao': kodeAO,
          'telepon_petugas_bank': teleponPetugasBank,
          'image': '1'
        });
      } else {
        // UPDATE DATA + PICT
        print('PENCAIRAN->CREATE_AKAD_PICT');
        response = await http.post(url, body: {
          'status': widget.status,
          'niksales': widget.nik,
          'telepon': widget.telepon,
          'id_pipeline': widget.id,
          'tanggal_akad': tanggalAkad,
          'nomor_rekening': nomorRekening,
          'nomor_perjanjian': nomorPerjanjian,
          'nominal_pinjaman': plafond,
          'nominal_os_akhir': finalOS,
          'nominal_top_up': nominalTopUp,
          'jenis_produk': valueJenisProduk,
          'status_kredit': selectedStatusKredit,
          'nama_petugas_bank': namaPetugasBank,
          'kode_ao': kodeAO,
          'telepon_petugas_bank': teleponPetugasBank,
          'file_name': 'akad',
          'image1': base64Image1,
          'name1': image1,
          'image2': base64Image2,
          'name2': image2,
          'image': '0'
        });
      }
    } else {
      print('THIS AKAD PIPELINE');
      if (path1 != '' && path2 != '') {
        // EDIT DATA
        print('PENCAIRAN->EDIT_AKAD');
        response = await http.post(url, body: {
          'status': widget.status,
          'niksales': widget.nik,
          'telepon': widget.telepon,
          'id_pipeline': widget.id,
          'tanggal_akad': tanggalAkad,
          'nomor_rekening': nomorRekening,
          'nomor_perjanjian': nomorPerjanjian,
          'nominal_pinjaman': plafond,
          'nominal_os_akhir': finalOS,
          'nominal_top_up': nominalTopUp,
          'jenis_produk': valueJenisProduk,
          'status_kredit': selectedStatusKredit,
          'nama_petugas_bank': namaPetugasBank,
          'kode_ao': kodeAO,
          'telepon_petugas_bank': teleponPetugasBank,
          'image': '1'
        });
      } else {
        // BUAT DATA
        print('PENCAIRAN->CREATE_AKAD');
        response = await http.post(url, body: {
          'status': widget.status,
          'niksales': widget.nik,
          'telepon': widget.telepon,
          'id_pipeline': widget.id,
          'tanggal_akad': tanggalAkad,
          'nomor_rekening': nomorRekening,
          'nomor_perjanjian': nomorPerjanjian,
          'nominal_pinjaman': plafond,
          'nominal_os_akhir': finalOS,
          'nominal_top_up': nominalTopUp,
          'jenis_produk': valueJenisProduk,
          'status_kredit': selectedStatusKredit,
          'nama_petugas_bank': namaPetugasBank,
          'kode_ao': kodeAO,
          'telepon_petugas_bank': teleponPetugasBank,
          'file_name': 'akad',
          'image1': base64Image1,
          'name1': image1,
          'image2': base64Image2,
          'name2': image2,
          'image': '0'
        });
      }
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Akad'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          re_send = false;
          namaPetugasBankController.clear();
          kodeAOController.clear();
          teleponPetugasBankController.clear();
          // jabatanPetugasBankController.clear();
        });
        Toast.show(
          'Sukses akad kredit debitur ' + widget.debitur,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
        );
        if (widget.status != '2') {
          // Navigator.of(context).push();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PipelineRootPage(widget.username, widget.nik)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DisbursmentScreen(widget.username, widget.nik, '', '')));
        }
      } else {
        setState(() {
          visible = false;
          re_send = false;
        });
        Toast.show(
          'Gagal akad kredit debitur ' + widget.debitur,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
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
                        MdiIcons.alertCircleOutline,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Proses $action akad kredit tertunda!',
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

                                submitPipeline();
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
                      SizedBox(height: 20),
                      Column(children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 10.0),
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
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 5.0),
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
    // valueJenisProduk = widget.jenisProduk;
    // if (widget.jenisProduk == '1') {
    //   valueJenisProduk = 'Pegawai Aktif PNS / TNI / POLRI';
    // } else if (widget.jenisProduk == '2') {
    //   valueJenisProduk = 'Prapensiun';
    // } else if (widget.jenisProduk == '3') {
    //   valueJenisProduk = 'Pensiun';
    // } else if (widget.jenisProduk == '4') {
    //   valueJenisProduk = 'Kredit Insidentil';
    // } else if (widget.jenisProduk == '5') {
    //   valueJenisProduk = 'Kredit Platinum 74 (BTPN)';
    // } else if (widget.jenisProduk == '6') {
    //   valueJenisProduk = 'Kredit Platinum 74 (BJB)';
    // } else {
    //   valueJenisProduk = 'Tidak Ada';
    // }
    return WillPopScope(
      onWillPop: () async {
        print('Back Button pressed!');
        final shouldPop = await _onBackPressed(context);
        return shouldPop;
      },
      // onWillPop: () async {
      // visible == true
      //     ? Toast.show(
      //         'Mohon menunggu, sedang proses akad kredit...' + widget.debitur,
      //         context,
      //         duration: Toast.LENGTH_LONG,
      //         gravity: Toast.BOTTOM,
      //         backgroundColor: Colors.red,
      //       )
      //     : Navigator.of(context).pop();
      // },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              action == 'Ubah' ? 'Ubah Akad Kredit' : 'Akad Kredit',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
            actions: <Widget>[
              re_send == true
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(0, 20.0, 10.0, 0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Informasi Pipeline',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              fieldDebitur('No KTP', widget.noKtp, 70),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('No NIP', widget.noNip, 70),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Debitur', widget.debitur, 70),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Telepon', widget.telepon, 70),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Nominal', formatRupiah(widget.nominal), 70),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Cabang', widget.cabang, 70),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Informasi Submit',
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
                              fieldDebitur(
                                  'Penyerahan', widget.tanggalPenyerahan, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Jenis Produk',
                                  setJenisProduk(setNull(widget.jenisProduk)),
                                  120),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                      child: Text(
                        'Data Akad',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            fieldTanggalAkad(),
                            fieldNomorRekening(),
                            fieldNomorPerjanjian(),
                            fieldNominalPinjaman(),
                            fieldStatusKredit(),
                            Visibility(
                                visible: _isVisible, child: fieldFinalOS()),
                            Visibility(
                                visible: _isVisible,
                                child: fieldNominalTopUp()),
                            // fieldKodeProduk(),
                            // fieldSalesInfo(),
                            // Text(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                      child: Text(
                        'Data Petugas Bank',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            // fieldJabatanBank(),
                            fieldKodeAO(),
                            fieldPetugasBank(),
                            fieldNoTeleponBank(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Dokumen Akad',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 20),
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
                                            image2 = '';
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
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        //color: Colors.white,
                        child: Row(
                          children: <Widget>[Expanded(child: buildGridView())],
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
                            visible == false
                                ? '$action Akad'
                                : '$action Kembali!',
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
                              content: Text('Mohon pilih skk...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (image2 == null || image2 == '') {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih tanda tangan akad...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            if (visible == false) {
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
                              submitPipeline();
                            } else {
                              null;
                            }
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
      ),
    );
  }

  Widget fieldDebitur(title, value, double size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
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
            // fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget fieldTanggalAkad() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPerjanjianController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalAkad == null) {
              return 'Tanggal akad wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Akad'),
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

  Widget fieldNomorRekening() {
    return TextFormField(
        controller: nomorRekeningController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nomor rekening wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nomor Rekening'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }

  Widget fieldNomorPerjanjian() {
    return TextFormField(
      controller: nomorPerjanjianController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor perjanjian wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor Perjanjian'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

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
          finalOSController.clear();
          nominalTopUpController.clear();

          setState(() {
            selectedStatusKredit = selectedStatusKreditType;
            if (selectedStatusKredit == 'TOP UP') {
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

  Widget fieldNominalPinjaman() {
    return TextFormField(
        controller: plafondController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nominal pinjaman wajib diisi...';
          } else if (value.length < 7) {
            return 'Nominal pinjaman minimal 7 digit...';
          } else if (value.length > 9) {
            return 'Nominal pinjaman maksimal 9 digit';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nominal Pinjaman'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          finalOSController.clear();
          nominalTopUpController.clear();
        },
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }

  Widget fieldFinalOS() {
    return TextFormField(
        controller: finalOSController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nominal O/S terakhir wajib diisi...';
          } else if (value.length < 5) {
            return 'Nominal O/S terakhir minimal 8 digit...';
          } else if (value.length > 9) {
            return 'Nominal O/S terakhir maksimal 9 digit';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nominal O/S Terakhir'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          String inNominal = plafondController.text;

          int nominal = int.parse(inNominal.isNotEmpty ? inNominal : "0");
          int os_akhir = int.parse(value.isNotEmpty ? value : "0");

          int tipAmount = nominal - os_akhir;
          nominalTopUpController.text = tipAmount.toString();
        },
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }

  Widget fieldNominalTopUp() {
    return TextFormField(
        controller: nominalTopUpController,
        readOnly: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nominal Top Up wajib diisi...';
          } else if (value.length < 5) {
            return 'Nominal Top Up minimal 5 digit...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nominal Top Up'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontFamily: 'LeadsGo-Font'));
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setJenisProduk(String produk) {
    switch (produk) {
      case "1":
        return 'Pegawai Aktif PNS / TNI / POLRI';
        break;
      case "2":
        return 'Prapensiun';
        break;
      case "3":
        return 'Pensiun';
        break;
      case "4":
        return 'Kredit Insidentil';
        break;
      case "5":
        return 'Kredit Platinum 74 (BTPN)';
        break;
      case "6":
        return 'Kredit Platinum 74 (BJB)';
        break;
    }
  }
  // Widget fieldKodeProduk() {
  //   return DropdownButtonFormField(
  //       items: _jenisProdukType
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
  //       onChanged: (selectedJenisProdukType) {
  //         setState(() {
  //           selectedJenisProduk = selectedJenisProdukType;
  //         });
  //       },
  //       decoration: InputDecoration(
  //           labelText: 'Jenis Produk',
  //           contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //           labelStyle: TextStyle(
  //             fontFamily: 'LeadsGo-Font',
  //           )),
  //       value: selectedJenisProduk,
  //       isExpanded: true);
  // }

  // Widget fieldSalesInfo() {
  //   return DropdownButtonFormField(
  //       items: _jenisInfoType
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
  //       onChanged: (selectedJenisInfoType) {
  //         setState(() {
  //           selectedJenisInfo = selectedJenisInfoType;
  //         });
  //       },
  //       decoration: InputDecoration(
  //           labelText: 'Informasi Sales',
  //           contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //           labelStyle: TextStyle(
  //             fontFamily: 'LeadsGo-Font',
  //           )),
  //       value: selectedJenisInfo,
  //       isExpanded: true);
  // }

  Widget fieldPetugasBank() {
    return TextFormField(
      controller: namaPetugasBankController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKodeAO() {
    return TextFormField(
      controller: kodeAOController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kode AO wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kode AO'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  // Widget fieldJabatanBank() {
  //   return TextFormField(
  //     controller: jabatanPetugasBankController,
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'Kode AO wajib diisi...';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(labelText: 'Kode AO'),
  //     textCapitalization: TextCapitalization.characters,
  //     style: TextStyle(fontFamily: 'LeadsGo-Font'),
  //   );
  // }

  Widget fieldNoTeleponBank() {
    return TextFormField(
      controller: teleponPetugasBankController,
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
      decoration: InputDecoration(labelText: 'No. Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
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
          if (path1 != '' && path2 != '') {
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
                ],
              ),
            );
          } else {
            String titled;
            Color colored;
            if (index == 0) {
              titled = 'Foto Lembar\n Pertama SPPK';
              colored = leadsGoColor;
            } else {
              titled = 'Foto Tanda\n Tangan Akad';
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
                      textAlign: TextAlign.center,
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
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          } else {
            image2 = fileName;
            base64Image2 = base64Image;
          }
        }
      });
    });
  }
}
