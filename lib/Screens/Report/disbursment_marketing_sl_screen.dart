import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_add.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentMarketingScreen extends StatefulWidget {
  @override
  _DisbursmentMarketingScreen createState() => _DisbursmentMarketingScreen();

  String username;
  String nik;
  String nama;

  DisbursmentMarketingScreen(this.username, this.nik, this.nama);
}

class _DisbursmentMarketingScreen extends State<DisbursmentMarketingScreen> {
  bool _isLoading = false;
  final String apiUrl = 'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursment';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Disbursment'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Disbursment'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _debitur(dynamic user) {
    return user['debitur'];
  }

  String _nomorAkad(dynamic user) {
    return user['nomor_akad'];
  }

  String _plafond(dynamic user) {
    return user['plafond'];
  }

  String _nominal(dynamic user) {
    return user['nominal'];
  }

  String _nominal_os_akhir(dynamic user) {
    return user['nominal_os_akhir'];
  }

  String _cabang(dynamic user) {
    return user['cabang'];
  }

  String _tanggalAkad(dynamic user) {
    return user['tanggal_akad'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _noJanji(dynamic user) {
    return user['no_janji'];
  }

  String _jenisPencairan(dynamic user) {
    return user['jenis_pencairan'];
  }

  String _jenisProduk(dynamic user) {
    return user['jenis_produk'];
  }

  String _infoSales(dynamic user) {
    return user['info_sales'];
  }

  String _foto1(dynamic user) {
    return user['foto1'];
  }

  String _foto2(dynamic user) {
    return user['foto2'];
  }

  String _foto3(dynamic user) {
    return user['foto3'];
  }

  String _tanggalPencairan(dynamic user) {
    return user['tgl_pencairan'];
  }

  String _jamPencairan(dynamic user) {
    return user['jam_pencairan'];
  }

  String _statusPencairan(dynamic user) {
    return user['status_pencairan'];
  }

  String _statusBayar(dynamic user) {
    return user['status_bayar'];
  }

  String _approvalSl(dynamic user) {
    return user['approval_sl'];
  }

  String _namaTl(dynamic user) {
    return user['nama_tl'];
  }

  String _jabatanTl(dynamic user) {
    return user['jabatan_tl'];
  }

  String _teleponTl(dynamic user) {
    return user['telepon_tl'];
  }

  String _namaSales(dynamic user) {
    return user['namasales'];
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

  String _idPipeline(dynamic user) {
    return user['id_pipeline'];
  }

  String _tanggalPipeline(dynamic user) {
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

  String _statusPipeline(dynamic user) {
    return user['status'];
  }

  String _tanggalPenyerahan(dynamic user) {
    return user['tgl_penyerahan'];
  }

  String _namaPenerima(dynamic user) {
    return user['nama_penerima'];
  }

  String _teleponPenerima(dynamic user) {
    return user['telepon_penerima'];
  }

  String _kodeProduk(dynamic user) {
    return user['kode_produk'];
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
        appBar: AppBar(
          title: Text(
            'Pencairan',
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
            )),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DisbursmentViewScreen(
                            _debitur(_users[index]),
                            _alamat(_users[index]),
                            _telepon(_users[index]),
                            _tanggalAkad(_users[index]),
                            _nomorAkad(_users[index]),
                            _noJanji(_users[index]),
                            _plafond(_users[index]),
                            _nominal(_users[index]),
                            _nominal_os_akhir(_users[index]),
                            _jenisPencairan(_users[index]),
                            _jenisProduk(_users[index]),
                            _cabang(_users[index]),
                            _infoSales(_users[index]),
                            _foto1(_users[index]),
                            _foto2(_users[index]),
                            _foto3(_users[index]),
                            _tanggalPencairan(_users[index]),
                            _jamPencairan(_users[index]),
                            _namaTl(_users[index]),
                            _jabatanTl(_users[index]),
                            _teleponTl(_users[index]),
                            _namaSales(_users[index]),
                            _cabang(_users[index]),
                            _infoSales(_users[index]),
                            _statusPipeline(_users[index]),
                            _statusKredit(_users[index]),
                            _pengelolaPensiun(_users[index]),
                            _bankTakeover(_users[index]),
                            _tanggalPenyerahan(_users[index]),
                            _namaPenerima(_users[index]),
                            _teleponPenerima(_users[index]),
                            _tanggalPipeline(_users[index]),
                            _tempatLahir(_users[index]),
                            _tanggalLahir(_users[index]),
                            _jenisKelamin(_users[index]),
                            _noKtp(_users[index]),
                            _npwp(_users[index]),
                            _kodeProduk(_users[index]))));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        _debitur(_users[index]),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'LeadsGo-Font'),
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
                                style: TextStyle(fontFamily: 'LeadsGo-Font'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Tanggal Pencairan',
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${_tanggalPencairan(_users[index])}',
                                style: fontFamily,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Status Pencairan',
                                child: Icon(
                                  Icons.info,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                messageStatus(
                                  '${_statusPencairan(_users[index])}',
                                ),
                                style: fontFamily,
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Text(''),
                    ),
                  ),
                ),
              );
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
              'pencairan belum tersedia',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }

  messageStatus(String status) {
    if (status == 'waiting') {
      return 'Menunggu Sales Leader';
    } else if (status == 'success') {
      return 'Disetujui Sales Leader';
    } else if (status == 'failed') {
      return 'Ditolak Sales Leader ';
    } else {
      return 'Menunggu Sales Leader';
    }
  }

  iconStatus(String status) {
    if (status == 'waiting') {
      return Icons.info;
    } else if (status == 'success') {
      return Icons.check;
    } else if (status == 'failed') {
      return Icons.cancel;
    } else {
      return Icons.info;
    }
  }

  colorStatus(String status) {
    if (status == 'waiting') {
      return Colors.blue;
    } else if (status == 'success') {
      return Colors.green;
    } else if (status == 'failed') {
      return Colors.red;
    } else {
      return Colors.blue;
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
