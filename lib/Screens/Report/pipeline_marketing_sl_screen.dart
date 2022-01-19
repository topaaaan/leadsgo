import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_akad.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_edit.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_submit.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PipelineMarketingScreen extends StatefulWidget {
  @override
  _PipelineMarketingScreen createState() => _PipelineMarketingScreen();

  String username;
  String nik;
  String nama;

  PipelineMarketingScreen(this.username, this.nik, this.nama);
}

class _PipelineMarketingScreen extends State<PipelineMarketingScreen> {
  bool visible = false;
  bool _isLoading = false;
  final String apiUrl = 'https://tetranabasainovasi.com/api_marsit_v1/service.php/getPipeline';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Pipeline'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Pipeline'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _tglPipeline(dynamic user) {
    return user['tgl_pipeline'];
  }

  String _tempatLahir(dynamic user) {
    return user['tempat_lahir'];
  }

  String _tanggalLahir(dynamic user) {
    return user['tgl_lahir'];
  }

  String _jenisKelamin(dynamic user) {
    return user['jenis_kelamin'];
  }

  String _noKtp(dynamic user) {
    return user['no_ktp'];
  }

  String _npwp(dynamic user) {
    return user['npwp'];
  }

  String _namaNasabah(dynamic user) {
    return user['cadeb'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _jenisProduk(dynamic user) {
    return user['jenis_produk'];
  }

  String _plafond(dynamic user) {
    return user['nominal'];
  }

  String _cabang(dynamic user) {
    return user['cabang'];
  }

  String _keterangan(dynamic user) {
    return user['keterangan'];
  }

  String _status(dynamic user) {
    return user['status'];
  }

  String _statusKredit(dynamic user) {
    return user['status_kredit'];
  }

  String _pengelolaPensiun(dynamic user) {
    return user['pengelola_pensiun'];
  }

  String _bankTakeover(dynamic user) {
    return user['bank_takeover'];
  }

  String _tglPenyerahan(dynamic user) {
    return user['tgl_penyerahan'];
  }

  String _namaPenerima(dynamic user) {
    return user['nama_penerima'];
  }

  String _teleponPenerima(dynamic user) {
    return user['telepon_penerima'];
  }

  String _foto1(dynamic user) {
    return user['foto1'];
  }

  // String _foto2(dynamic user) {
  //   return user['foto2'];
  // }

  String _fotoTandaTerima(dynamic user) {
    return user['foto_tanda_submit'];
  }

  String _tanggalAkad(dynamic user) {
    return user['tanggal_akad'];
  }

  String _nomorAplikasi(dynamic user) {
    return user['nomor_aplikasi'];
  }

  String _nomorPerjanjian(dynamic user) {
    return user['nomor_perjanjian'];
  }

  String _nominalPinjaman(dynamic user) {
    return user['nominal_pinjaman'];
  }

  String _akadProduk(dynamic user) {
    return user['akad_produk'];
  }

  String _salesInfo(dynamic user) {
    return user['sales_info'];
  }

  String _namaPetugasBank(dynamic user) {
    return user['nama_petugas_bank'];
  }

  String _jabatanPetugasBank(dynamic user) {
    return user['jabatan_petugas_bank'];
  }

  String _teleponPetugasBank(dynamic user) {
    return user['telepon_petugas_bank'];
  }

  String _fotoAkad1(dynamic user) {
    return user['foto_akad1'];
  }

  String _fotoAkad2(dynamic user) {
    return user['foto_akad2'];
  }

  String _keluhan(dynamic user) {
    return user['keluhan'];
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
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String periode = bulan + ' ' + tahun;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pipeline',
            style: fontFamily,
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Nama Sales', widget.nama, 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Periode', periode, 120.0),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: _buildList(),
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

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PipelineViewScreen(
                                    _namaNasabah(_users[index]),
                                    _tglPipeline(_users[index]),
                                    _alamat(_users[index]),
                                    _telepon(_users[index]),
                                    _jenisProduk(_users[index]),
                                    _plafond(_users[index]),
                                    _cabang(_users[index]),
                                    _keterangan(_users[index]),
                                    _status(_users[index]),
                                    _tempatLahir(_users[index]),
                                    _tanggalLahir(_users[index]),
                                    _jenisKelamin(_users[index]),
                                    _noKtp(_users[index]),
                                    _npwp(_users[index]),
                                    _tglPenyerahan(_users[index]),
                                    _tanggalAkad(_users[index]),
                                    _statusKredit(_users[index]),
                                    _pengelolaPensiun(_users[index]),
                                    _bankTakeover(_users[index]),
                                    _foto1(_users[index]),
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          _namaNasabah(_users[index]),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LeadsGo-Font'),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Plafond',
                                  child: Icon(
                                    Icons.monetization_on_outlined,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${formatRupiah(_plafond(_users[index]))}',
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font', fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Tanggal Input',
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${_tglPipeline(_users[index])}',
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font', fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Status Pipeline',
                                  child: Icon(
                                    Icons.info_outline,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  messageStatus('${_status(_users[index])}'),
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.bold,
                                      color: colorStatus('${_status(_users[index])}')),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Kondisi Pipeline',
                                  child: Icon(
                                    MdiIcons.tag,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${_keluhan(_users[index])}',
                                  style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Text(
                          '',
                        ),
                      ),
                    ),
                  ));
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Pipeline belum tersedia',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Pipeline';
    } else if (status == '2') {
      return 'Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.orangeAccent;
    } else if (status == '2') {
      return Colors.greenAccent;
    } else if (status == '3') {
      return Colors.blueAccent;
    } else if (status == '4') {
      return Colors.blueAccent;
    }
  }

  namaBulan(String bulan) {
    switch (bulan) {
      case '1':
        return 'Januari';
        break;
      case '2':
        return 'Februari';
        break;
      case '3':
        return 'Maret';
        break;
      case '4':
        return 'April';
        break;
      case '5':
        return 'Mei';
        break;
      case '6':
        return 'Juni';
        break;
      case '7':
        return 'Juli';
        break;
      case '8':
        return 'Agustus';
        break;
      case '9':
        return 'September';
        break;
      case '10':
        return 'Oktober';
        break;
      case '11':
        return 'November';
        break;
      case '12':
        return 'Desember';
        break;
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
