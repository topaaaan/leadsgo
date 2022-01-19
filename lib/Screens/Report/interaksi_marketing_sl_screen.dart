import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

// ignore: must_be_immutable
class InteraksiMarketingScreen extends StatefulWidget {
  @override
  _InteraksiMarketingScreen createState() => _InteraksiMarketingScreen();

  String username;
  String nik;
  String nama;

  InteraksiMarketingScreen(this.username, this.nik, this.nama);
}

class _InteraksiMarketingScreen extends State<InteraksiMarketingScreen> {
  bool visible = false;
  bool _isLoading = false;
  final String apiUrl = 'https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteraction';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Interaction'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Interaction'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _calonDebitur(dynamic user) {
    return user['calon_debitur'];
  }

  String _plafond(dynamic user) {
    return user['plafond'];
  }

  String _tanggalInteraksi(dynamic user) {
    return user['tanggal_interaksi'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _email(dynamic user) {
    return user['email'];
  }

  String _salesFeedback(dynamic user) {
    return user['sales_feedback'];
  }

  String _foto(dynamic user) {
    return user['foto'];
  }

  String _statusInteraksi(dynamic user) {
    return user['approval_sl'];
  }

  String _jamInteraksi(dynamic user) {
    return user['jam_kunj'];
  }

  String _kelurahan(dynamic user) {
    return user['kelurahan'];
  }

  String _kecamatan(dynamic user) {
    return user['kecamatan'];
  }

  String _kabupaten(dynamic user) {
    return user['kota_kab'];
  }

  String _propinsi(dynamic user) {
    return user['provinsi'];
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
            'Interaksi',
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
                              builder: (context) => InteractionViewScreen(
                                    _calonDebitur(_users[index]),
                                    _alamat(_users[index]),
                                    _email(_users[index]),
                                    _telepon(_users[index]),
                                    _plafond(_users[index]),
                                    _salesFeedback(_users[index]),
                                    _foto(_users[index]),
                                    _tanggalInteraksi(_users[index]),
                                    _jamInteraksi(_users[index]),
                                    _statusInteraksi(_users[index]),
                                    _kelurahan(_users[index]),
                                    _kecamatan(_users[index]),
                                    _kabupaten(_users[index]),
                                    _propinsi(_users[index]),
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          _calonDebitur(_users[index]),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LeadsGo-Font'),
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(
                              height: 5,
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
                                  formatRupiah(_plafond(_users[index])),
                                  style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Tanggal Jam Interaksi',
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _tanggalInteraksi(_users[index]) +
                                      ' ' +
                                      _jamInteraksi(_users[index]),
                                  style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Tooltip(
                                  message: 'Status',
                                  child: Icon(
                                    Icons.info_outline,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  messageStatus(_statusInteraksi(_users[index])),
                                  style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                          ],
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
              'Interaksi belum tersedia',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Menunggu Persetujuan';
    } else if (status == '1') {
      return 'Disetujui Sales Leader';
    } else if (status == '11') {
      return 'Ditolak Sales Leader ';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Icons.info;
    } else if (status == '1') {
      return Icons.check;
    } else if (status == '11') {
      return Icons.cancel;
    }
  }

  colorStatus(String status) {
    if (status == '0') {
      return Colors.blue;
    } else if (status == '1') {
      return Colors.green;
    } else if (status == '11') {
      return Colors.red;
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
