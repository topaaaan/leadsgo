import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Planning/next_planning_screen.dart';
import 'package:leadsgo_apps/Screens/Planning/planning_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/planning_provider.dart';
import 'package:leadsgo_apps/Screens/Interaction/planning_interaction_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Datapens/datapens_screen.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_add.dart';

import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreen createState() => _PlanningScreen();

  String username;
  String nik;
  String hakAkses;

  PlanningScreen(this.username, this.nik, this.hakAkses);
}

class _PlanningScreen extends State<PlanningScreen> {
  int plan = 0;
  List<bool> inputs = new List<bool>();
  List<String> notass = new List<String>();
  List<String> namaa = new List<String>();
  int counter = 0;
  String tglInteraksi;
  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getPlanning';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result =
        await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Planning'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Planning'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _nopen(dynamic user) {
    return user['nopen'];
  }

  String _nama(dynamic user) {
    return user['namapensiunan'];
  }

  String _tglLahir(dynamic user) {
    return user['tgl_lahir_pensiunan'];
  }

  String _gajiPokok(dynamic user) {
    return user['penpok'];
  }

  String _alamat(dynamic user) {
    return user['alm_peserta'];
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

  String _provinsi(dynamic user) {
    return user['provinsi'];
  }

  String _kodepos(dynamic user) {
    return user['kodepos'];
  }

  String _namaKantor(dynamic user) {
    return user['nmkanbyr'];
  }

  String _tmtPensiun(dynamic user) {
    return user['tmtpensiun'];
  }

  String _penerbitSkep(dynamic user) {
    return user['penerbit_skep'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _visitStatus(dynamic user) {
    return user['visit_status'];
  }

  String _ktp(dynamic user) {
    return user['ktp'];
  }

  String _npwp(dynamic user) {
    return user['npwp'];
  }

  String _namaPenerima(dynamic user) {
    return user['nama_penerima'];
  }

  String _tanggalLahirPenerima(dynamic user) {
    return user['tgl_lahir_penerima'];
  }

  String _nomorSkep(dynamic user) {
    return user['nomor_skep'];
  }

  String _tanggalSkep(dynamic user) {
    return user['tanggal_skep'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  void initState() {
    super.initState();
    fetchUsers();
    setState(() {
      for (int i = 0; i < 100; i++) {
        inputs.add(false);
      }
    });
  }

  void ItemChange(bool val, int index, String notas, String nama) {
    setState(() {
      inputs[index] = val;
      if (val == true) {
        notass.add(notas);
        namaa.add(nama);
      } else {
        notass.remove(notas);
        namaa.remove(nama);
      }
    });
  }

  int _bottomNavCurrentIndex = 0;
  int itemSelected = 0;

  //Getting value from TextField Widget
  final tglInteraksiController = TextEditingController();

  Future interactionMax(BuildContext context) {
    Toast.show(
      'Maaf, maksimal rencana interaksi per hari hanya 3 saja...',
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  Future interactionNull(BuildContext context) {
    Toast.show(
      'Maaf, silahkan pilih rencana interaksi terlebih dahulu...',
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  Future interactionDate(BuildContext context) {
    Toast.show(
      'Maaf, silahkan pilih tanggal interaksi terlebih dahulu...',
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Database Pribadi',
            style: fontFamily,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                MdiIcons.humanGreetingProximity,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlanningInteractionScreen(
                            widget.username, widget.nik, widget.hakAkses)));
              },
              // onPressed: () => _onButtonSearchPressed(),
            ),
          ],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: Container(
          // padding: const EdgeInsets.only(bottom: 140),
          color: Color(0xfff3f3f3),
          child: _buildList(),
        ),
        // bottomSheet: Container(
        //   decoration: BoxDecoration(color: Colors.white,
        //       // borderRadius: BorderRadius.only(
        //       //   topLeft: Radius.circular(20.0),
        //       //   topRight: Radius.circular(20.0),
        //       // ),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey,
        //           blurRadius: 2.0,
        //         ),
        //       ]),
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 15,
        //     vertical: 15,
        //   ),
        //   height: 140,
        //   child: Form(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: [
        //         Row(
        //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Container(
        //               // width: MediaQuery.of(context).size.width * 0.50,
        //               child: itemSelected != 0
        //                   ? Text(
        //                       itemSelected.toString() + ' data dipilih untuk interaksi',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 18,
        //                         color: Colors.red,
        //                       ),
        //                     )
        //                   : Text(
        //                       'Tentukan jadwal interaksi mu!',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 18,
        //                       ),
        //                     ),
        //               // child: Text(
        //               //   itemSelected.toString() + ' data dipilih',
        //               //   style: TextStyle(
        //               //       color: Colors.red,
        //               //       fontFamily: 'LeadsGo-Font',
        //               //       fontWeight: FontWeight.bold),
        //               // ),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             // Container(width: MediaQuery.of(context).size.width * 0.30, child: null)
        //           ],
        //         ),
        //         SizedBox(height: 20),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Container(
        //               width: MediaQuery.of(context).size.width * 0.50,
        //               child: fieldTanggal(),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Container(
        //               width: MediaQuery.of(context).size.width * 0.30,
        //               child: FlatButton(
        //                 height: 45,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(5.0),
        //                   // side: BorderSide(color: Colors.red),
        //                 ),
        //                 color: Colors.green,
        //                 onPressed: () {
        //                   tglInteraksi = tglInteraksiController.text;
        //                   if (notass.length > 3) {
        //                     interactionMax(context);
        //                   } else if (notass.length == 0) {
        //                     interactionNull(context);
        //                   } else {
        //                     if (tglInteraksi == '') {
        //                       interactionDate(context);
        //                     } else {
        //                       Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                           builder: (context) => NextPlanningScreen(
        //                             widget.username,
        //                             widget.nik,
        //                             notass,
        //                             namaa,
        //                             tglInteraksi,
        //                           ),
        //                         ),
        //                       );
        //                     }
        //                   }
        //                 },
        //                 child: Text(
        //                   'Lanjut',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontFamily: 'LeadsGo-Font',
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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
              return Card(
                margin: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlanningViewScreen(
                              widget.username,
                              widget.nik,
                              _nama(_users[index]),
                              _tglLahir(_users[index]),
                              _gajiPokok(_users[index]),
                              _alamat(_users[index]),
                              _kelurahan(_users[index]),
                              _kecamatan(_users[index]),
                              _kabupaten(_users[index]),
                              _provinsi(_users[index]),
                              _kodepos(_users[index]),
                              _namaKantor(_users[index]),
                              _tmtPensiun(_users[index]),
                              _penerbitSkep(_users[index]),
                              _telepon(_users[index]),
                              _visitStatus(_users[index]),
                              _nopen(_users[index]),
                              _ktp(_users[index]),
                              _npwp(_users[index]),
                              _namaPenerima(_users[index]),
                              _tanggalLahirPenerima(_users[index]),
                              _nomorSkep(_users[index]),
                              _tanggalSkep(_users[index]),
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            setSubNama(_nama(_users[index])),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'LeadsGo-Font'),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Gaji Pokok',
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatRupiah(
                                    setSubNama(_gajiPokok(_users[index]))
                                        .toString()),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LeadsGo-Font'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Umur',
                                child: Icon(
                                  MdiIcons.accountCircleOutline,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                setNull(umur(int.parse(_tglLahir(_users[index])
                                            .substring(0, 4)))
                                        .toString()) +
                                    ' TAHUN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LeadsGo-Font'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // trailing: Container(
                      //   // constraints: BoxConstraints(maxWidth: 130.0, minHeight: 50.0),
                      //   width: MediaQuery.of(context).size.width * 0.33,
                      //   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      //   child: TextButton(
                      //       onPressed: () {
                      //         if (_visitStatus(_users[index]) == '1') {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => InteractionAddScreen(
                      //                 widget.username,
                      //                 widget.nik,
                      //                 _nama(_users[index]),
                      //                 _alamat(_users[index]),
                      //                 '',
                      //                 _telepon(_users[index]),
                      //                 'Database ',
                      //                 _kelurahan(_users[index]),
                      //                 _kecamatan(_users[index]),
                      //                 _provinsi(_users[index]),
                      //                 _kabupaten(_users[index]),
                      //                 _nopen(_users[index]),
                      //               ),
                      //             ),
                      //           );
                      //         } else {
                      //           Toast.show(
                      //             'Nasabah sudah di interaksi...',
                      //             context,
                      //             duration: Toast.LENGTH_LONG,
                      //             gravity: Toast.CENTER,
                      //             backgroundColor: Colors.red,
                      //           );
                      //         }
                      //       },
                      //       child: Container(
                      //         child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             // crossAxisAlignment: CrossAxisAlignment.end,
                      //             children: [
                      //               Text(
                      //                 'Interakasikan',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   fontFamily: 'LeadsGo-Font',
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 12,
                      //                   color:
                      //                       _visitStatus(_users[index]) == '1'
                      //                           ? leadsGoColor
                      //                           : Colors.green,
                      //                 ),
                      //               ),
                      //               Icon(
                      //                 _visitStatus(_users[index]) == '1'
                      //                     ? MdiIcons.arrowTopRight
                      //                     : MdiIcons.checkCircleOutline,
                      //                 size: 18,
                      //                 color: _visitStatus(_users[index]) == '1'
                      //                     ? leadsGoColor
                      //                     : Colors.green,
                      //               ),
                      //             ]),
                      //       )),
                      // ),
                      trailing: Wrap(
                        spacing: 20,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                      'Apakah Anda ingin menghapus Database Pribadi ini ?'),
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
                                        deleteRencanaInteraksi(
                                            _id(_users[index]),
                                            _nopen(_users[index]));
                                      },
                                      child: Text('Ya'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Hapus',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _visitStatus(_users[index]) == '1'
                                      ? leadsGoColor
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InteractionAddScreen(
                                    widget.username,
                                    widget.nik,
                                    _nama(_users[index]),
                                    _alamat(_users[index]),
                                    '',
                                    _telepon(_users[index]),
                                    'Database ',
                                    _kelurahan(_users[index]),
                                    _kecamatan(_users[index]),
                                    _provinsi(_users[index]),
                                    _kabupaten(_users[index]),
                                    _nopen(_users[index]),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Interakasikan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _visitStatus(_users[index]) == '1'
                                      ? leadsGoColor
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Checkbox(
                      //   value: inputs[index],
                      //   onChanged: (bool value) {
                      //     ItemChange(value, index, _nopen(_users[index]), _nama(_users[index]));
                      //     if (value == true) {
                      //       setState(() {
                      //         itemSelected += 1;
                      //       });
                      //     } else {
                      //       setState(() {
                      //         itemSelected -= 1;
                      //       });
                      //     }
                      //   },
                      // ),
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
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(width: 7.0, color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(MdiIcons.databaseOffOutline,
                        size: 70, color: Colors.grey),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Database Pribadi\nBelum tersedia!',
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              //   child: Text(
              //     'Cari Database di menu Data',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.w100),
              //   ),
              // ),
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
                    'Cari Database',
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
                          builder: (context) => DatapensScreen(
                              widget.username, widget.nik, widget.hakAkses)));
                },
              ),
            ],
          ),
        );
      }
    }
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return 'NULL';
    } else {
      return data;
    }
  }

  umur(int tglLahir) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    return int.parse(formatted) - tglLahir;
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  setSubNama(String nama) {
    if (nama.length > 23) {
      for (int i = 20; i < nama.length; i++) {
        nama = replaceCharAt(nama, i, '.');
      }
      return nama.substring(0, 22);
    } else {
      return nama;
    }
  }

  Widget fieldTanggal() {
    final format = DateFormat("yyyy-MM-dd");
    // final format = DateFormat("dd-MM-yyyy");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tglInteraksiController,
          validator: (DateTime dateTime) {
            if (dateTime == null) {
              return 'Tanggal interaksi wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: '*Pilih Tanggal Interaksi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            ),
          ),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontSize: 14, fontFamily: 'LeadsGo-Font')),
    ]);
  }

  formatRupiah(String a) {
    if (a.substring(0, 1) != '0') {
      FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
          amount: double.parse(a.replaceAll(',', '')),
          settings: MoneyFormatterSettings(
            symbol: 'IDR',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
          ));
      return 'IDR ' + fmf.output.withoutFractionDigits;
    } else {
      return a;
    }
  }

  Future deleteRencanaInteraksi(String id, String notas) async {
    //showing CircularProgressIndicator
    print(id);
    // setState(() {
    //   visible = true;
    // });
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/deleteDatabasePribadi');
    var response = await http.post(url, body: {'id': id, 'notas': notas});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Rencana_Interaksi'];
      if (message.toString() == 'Delete Success') {
        // setState(() {
        //   visible = false;
        // });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PlanningScreen(widget.username, widget.nik, widget.hakAkses)));
        Toast.show(
          'Sukses delete database pribadi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        // setState(() {
        //   visible = false;
        // });
        Toast.show(
          'Gagal delete database pribadi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
