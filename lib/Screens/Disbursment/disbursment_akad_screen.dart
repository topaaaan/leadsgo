import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_add.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_add_new.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_edit.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_akad_provider.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentAkadScreen extends StatefulWidget {
  @override
  _DisbursmentAkadScreen createState() => _DisbursmentAkadScreen();

  String username;
  String nik;

  DisbursmentAkadScreen(this.username, this.nik);
}

_showPopupMenu(
        String username,
        String nik,
        String idPipeline,
        String namaPensiun,
        String alamat,
        String telepon,
        String selectedJenisDebitur,
        String selectedJenisProduk,
        String tanggalAkad,
        String tanggalAkadX,
        String nomorRekening,
        String nomorPerjanjian,
        String selectedJenisCabang,
        String plafond,
        // String selectedJenisInfo,
        String selectedStatusKredit,
        String namaPetugasBank,
        String kodeAOPetugasBank,
        String teleponPetugasBank,
        String selectedPengelolaPensiun) =>
    PopupMenuButton<int>(
      padding: EdgeInsets.only(left: 2),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DisbursmentAddNewScreen(
                      username,
                      nik,
                      '',
                      namaPensiun,
                      alamat,
                      telepon,
                      selectedJenisDebitur,
                      selectedJenisProduk,
                      tanggalAkad,
                      tanggalAkadX,
                      nomorRekening,
                      nomorPerjanjian,
                      selectedJenisCabang,
                      plafond,
                      // selectedJenisInfo,
                      selectedStatusKredit,
                      namaPetugasBank,
                      kodeAOPetugasBank,
                      teleponPetugasBank,
                      selectedPengelolaPensiun,
                      idPipeline)));
            },
            child: Tooltip(
                message: 'Pencairan',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money_sharp,
                      color: leadsGoColor,
                      size: 20,
                    ),
                    Text('Pencairan')
                  ],
                )),
          ),
        ),
      ],
      icon: Icon(Icons.more_vert),
      offset: Offset(0, 20),
    );

class _DisbursmentAkadScreen extends State<DisbursmentAkadScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentAkad';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Disbursment_Akad'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Disbursment_Akad'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _idPipeline(dynamic user) {
    return user['id_pipeline'];
  }

  String _debitur(dynamic user) {
    return user['debitur'];
  }

  String _tanggalAkad(dynamic user) {
    return user['tanggal_akad'];
  }

  String _tanggalAkadX(dynamic user) {
    return user['tanggal_akad_x'];
  }

  String _nomorRekening(dynamic user) {
    return user['nomor_rekening'];
  }

  String _nomorPerjanjian(dynamic user) {
    return user['nomor_perjanjian'];
  }

  String _nominalPinjaman(dynamic user) {
    return user['nominal_pinjaman'];
  }

  String _jenisProduk(dynamic user) {
    return user['jenis_produk'];
  }

  // String _salesInfo(dynamic user) {
  //   return user['sales_info'];
  // }

  String _namaPetugasBank(dynamic user) {
    return user['nama_petugas_bank'];
  }

  String _kodeAOPetugasBank(dynamic user) {
    return user['kode_ao'];
  }

  String _teleponPetugasBank(dynamic user) {
    return user['telepon_petugas_bank'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _selectedJenisDebitur(dynamic user) {
    return user['selected_jenis_debitur'];
  }

  String _selectedJenisProduk(dynamic user) {
    return user['selected_jenis_produk'];
  }

  String _selectedJenisCabang(dynamic user) {
    return user['selected_jenis_cabang'];
  }

  // String _selectedJenisInfo(dynamic user) {
  //   return user['selected_jenis_info'];
  // }

  String _selectedStatusKredit(dynamic user) {
    return user['selected_status_kredit'];
  }

  String _selectedPengelolaPensiun(dynamic user) {
    return user['selected_pengelola_pensiun'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Siap Pencairan !',
            style: fontFamily,
          ),
          actions: [
            IconButton(
              icon: Icon(
                MdiIcons.helpCircleOutline,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Toast.show(
                  'Data Akad kredit\nyang siap untuk pencairan!',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.TOP,
                  backgroundColor: Colors.blue,
                );
              },
            ),
          ],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: Container(
          color: Color(0xfff3f3f3),
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        color: leadsGoColor,
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 1,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Tooltip(
                                  message: 'Debitur',
                                  child: Icon(
                                    MdiIcons.accountCircleOutline,
                                    color: leadsGoColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  setSubNama(_debitur(_users[index])),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.ticketConfirmationOutline,
                                  size: 20,
                                  color: leadsGoColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _nomorRekening(_users[index]),
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    color: leadsGoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(3, 10, 0, 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: leadsGoColor,
                              ))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Container(
                                              width: 110,
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              // padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Status Kredit',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              _selectedStatusKredit(_users[index]),
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 110,
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              // padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Nominal Plafond',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              formatRupiah(_nominalPinjaman(_users[index])),
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //TRACKING PIPELINE
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 9,
                                            ),
                                            height: 15,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: leadsGoColor,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                MdiIcons.calendarCheckOutline,
                                                color: leadsGoColor,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Telah dilakukan akad\npada tanggal ${_tanggalAkadX(_users[index])}',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // BUTTON LANJUT
                                      FlatButton(
                                        color: leadsGoColor,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => DisbursmentAddNewScreen(
                                                widget.username,
                                                widget.nik,
                                                '',
                                                _debitur(_users[index]),
                                                _alamat(_users[index]),
                                                _telepon(_users[index]),
                                                _selectedJenisDebitur(_users[index]),
                                                _selectedJenisProduk(_users[index]),
                                                _tanggalAkad(_users[index]),
                                                _tanggalAkadX(_users[index]),
                                                _nomorRekening(_users[index]),
                                                _nomorPerjanjian(_users[index]),
                                                _selectedJenisCabang(_users[index]),
                                                _nominalPinjaman(_users[index]),
                                                // _selectedJenisInfo(_users[index]),
                                                _selectedStatusKredit(_users[index]),
                                                _namaPetugasBank(_users[index]),
                                                _kodeAOPetugasBank(_users[index]),
                                                _teleponPetugasBank(_users[index]),
                                                _selectedPengelolaPensiun(_users[index]),
                                                _idPipeline(_users[index]),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              MdiIcons.currencyUsdCircleOutline,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'Pencairan !',
                                              style: TextStyle(
                                                fontFamily: "LeadsGo-Font",
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    MdiIcons.pound,
                                    size: 14,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    'Nomor Perjanjian : ',
                                    style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      color: Colors.black54,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    _nomorPerjanjian(_users[index]),
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ListTile(
                  //       title: Row(
                  //         children: [
                  //           Text(
                  //             _debitur(_users[index]),
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: 'LeadsGo-Font'),
                  //           ),
                  //         ],
                  //       ),
                  //       subtitle: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               Tooltip(
                  //                 message: 'Plafond',
                  //                 child: Icon(
                  //                   Icons.monetization_on_outlined,
                  //                   color: Colors.black54,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 formatRupiah(_nominalPinjaman(_users[index])),
                  //                 style: TextStyle(
                  //                   fontFamily: 'LeadsGo-Font',
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               Tooltip(
                  //                 message: 'Tanggal Akad',
                  //                 child: Icon(
                  //                   Icons.date_range_outlined,
                  //                   color: Colors.black54,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 _tanggalAkadX(_users[index]),
                  //                 style: TextStyle(
                  //                   fontFamily: 'LeadsGo-Font',
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               Tooltip(
                  //                 message: 'Nomor Rekening',
                  //                 child: Icon(
                  //                   Icons.confirmation_number_outlined,
                  //                   color: Colors.black54,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 _nomorRekening(_users[index]),
                  //                 style: TextStyle(
                  //                   fontFamily: 'LeadsGo-Font',
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       trailing: Wrap(
                  //         spacing: 12,
                  //         children: <Widget>[
                  //           _showPopupMenu(
                  //             widget.username,
                  //             widget.nik,
                  //             _idPipeline(_users[index]),
                  //             _debitur(_users[index]),
                  //             _alamat(_users[index]),
                  //             _telepon(_users[index]),
                  //             _selectedJenisDebitur(_users[index]),
                  //             _selectedJenisProduk(_users[index]),
                  //             _tanggalAkad(_users[index]),
                  //             _tanggalAkadX(_users[index]),
                  //             _nomorRekening(_users[index]),
                  //             _nomorPerjanjian(_users[index]),
                  //             _selectedJenisCabang(_users[index]),
                  //             _nominalPinjaman(_users[index]),
                  //             // _selectedJenisInfo(_users[index]),
                  //             _selectedStatusKredit(_users[index]),
                  //             _namaPetugasBank(_users[index]),
                  //             _kodeAOPetugasBank(_users[index]),
                  //             _teleponPetugasBank(_users[index]),
                  //             _selectedPengelolaPensiun(_users[index]),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        // return Center(
        //   child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        //     Container(
        //         decoration: BoxDecoration(
        //             color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
        //         child: Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Icon(
        //             Icons.hourglass_empty,
        //             size: 60,
        //             color: Colors.black54,
        //           ),
        //         )),
        //     Text(
        //       'Akad kredit belum tersedia',
        //       style: TextStyle(
        //         fontFamily: "LeadsGo-Font",
        //         fontSize: 14,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black54,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 50,
        //     ),
        //     Text(
        //       'Akad Kredit Yuk!',
        //       style: TextStyle(
        //           fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     Text(
        //       'Dapatkan insentif besar dari pencairanmu.',
        //       style: TextStyle(
        //         fontFamily: "LeadsGo-Font",
        //         fontSize: 12,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     FlatButton(
        //       color: leadsGoColor,
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => PipelineRootPage(widget.username, widget.nik)));
        //       },
        //       child: Text(
        //         'Lihat Pipeline',
        //         style: TextStyle(
        //           fontFamily: "LeadsGo-Font",
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ]),
        // );
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(width: 7.0, color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.hourglass_empty, size: 70, color: Colors.grey),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Akad Kredit\nBelum tersedia!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "LeadsGo-Font",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Text(
                  'Untuk mengajukan pencairan, selesaikan dokumen akad kredit terlebih dahulu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(123),
                ),
                color: leadsGoColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lihat Pipeline',
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PipelineRootPage(widget.username, widget.nik)));
                },
              ),
            ],
          ),
        );
      }
    }
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

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  setSubNama(String nama) {
    if (nama.length > 20) {
      for (int i = 17; i < nama.length; i++) {
        nama = replaceCharAt(nama, i, '.');
      }
      return nama.substring(0, 20);
    } else {
      return nama;
    }
  }
}
