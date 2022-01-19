import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_add.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:leadsgo_apps/Screens/Interaction/not_aktif_screen.dart';
import 'package:leadsgo_apps/Screens/Interaction/planning_interaction_screen.dart';
import 'package:leadsgo_apps/Screens/provider/interaction_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class InteractionScreen extends StatefulWidget {
  @override
  _InteractionScreen createState() => _InteractionScreen();

  String username;
  String nik;
  String hakAkses;

  InteractionScreen(this.username, this.nik, this.hakAkses);
}

class _InteractionScreen extends State<InteractionScreen> {
  bool visible = false;
  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteraction';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result =
        await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
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

  String _notas(dynamic user) {
    return user['notas'];
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Hasil Interaksi',
            style: fontFamily,
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: Container(
          color: grey,
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
      ));
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
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
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
                    padding: const EdgeInsets.all(8.0),
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
                                  iconStatus(_statusInteraksi(_users[index])),
                                  color: colorStatus(
                                      _statusInteraksi(_users[index])),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                // _notas(_users[index]),
                                messageStatus(_statusInteraksi(_users[index])),
                                style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                    color: colorStatus(
                                        _statusInteraksi(_users[index]))),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          (_statusInteraksi(_users[index]) == '0')
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(
                                            'Apakah Anda ingin menghapus interaksi ini ?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Tidak'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              deleteInteraksi(
                                                  _notas(_users[index]),
                                                  _telepon(_users[index]));
                                            },
                                            child: Text('Ya'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              : SizedBox(
                                  width: 10.0,
                                )
                        ],
                      ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.directions_walk_outlined, size: 70),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Interaksi Yuk!',
                style: TextStyle(
                    fontFamily: "LeadsGo-Font",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Dapatkan keuntungan besar di setiap interaksimu.',
                style: TextStyle(
                  fontFamily: "LeadsGo-Font",
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                color: leadsGoColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlanningInteractionScreen(
                              widget.username, widget.nik, widget.hakAkses)));
                },
                child: Text(
                  'Lihat Rencana Interaksi',
                  style: TextStyle(
                    fontFamily: "LeadsGo-Font",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
      return MdiIcons.informationOutline;
    } else if (status == '1') {
      return MdiIcons.checkCircleOutline;
    } else if (status == '11') {
      return MdiIcons.cancel;
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

  Future deleteInteraksi(String notas, String telepon) async {
    //showing CircularProgressIndicator
    print(notas);
    print(telepon);
    print(widget.nik);
    setState(() {
      visible = true;
    });
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/deleteInteraksi');
    var response = await http.post(url,
        body: {'notas': notas, 'nik': widget.nik, 'telepon': telepon});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Interaksi'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PlanningInteractionScreen(
                widget.username, widget.nik, widget.hakAkses)));
        Toast.show(
          'Sukses delete interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal delete interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
