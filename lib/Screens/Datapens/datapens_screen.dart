import 'dart:convert';
// import 'dart:ffi';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:leadsgo_apps/Screens/Datapens/datapens_next_planning_screen.dart';
import 'package:leadsgo_apps/Screens/Datapens/datapens_view_screen.dart';
import 'package:leadsgo_apps/Screens/Planning/planning_screen.dart';
// import 'package:leadsgo_apps/Screens/provider/planning_provider.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class DatapensScreen extends StatefulWidget {
  @override
  _DatapensScreen createState() => _DatapensScreen();

  String username;
  String nik;
  String hakAkses;

  DatapensScreen(this.username, this.nik, this.hakAkses);
}

class _DatapensScreen extends State<DatapensScreen>
    with SingleTickerProviderStateMixin {
  bool loadingScreen = false;
  int plan = 0;
  List<bool> inputs = [];
  List<String> notass = [];
  List<String> namaa = [];

  int counter = 0;
  String tglInteraksi;
  bool _isLoading = false;

// FILTER PROVINSI
  List dataProvinces = [];
  String selectedProvince;
  final String urlProvinces =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/provinces';
  void getProvinces() async {
    // setState(() {
    //   // _isLoading = true;
    //   selectedCities = null;
    //   dataCities = List();
    // });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.get(Uri.parse((urlProvinces)));
    if (res.statusCode == 200) {
      setState(() {
        // if (json.decode(res.body)['Daftar_Provinsi'] == '') {
        //   _isLoading = false;
        // } else {
        var resBody = json.decode(res.body)['Daftar_Provinsi'];
        // _isLoading = false;
        dataProvinces = resBody;
        // }
      });
    }
  }

// FILTER KOTA
  List dataCities = [];
  String selectedCities;
  final String urlCities =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/cities';
  void getCities(data) async {
    // setState(() {
    //   _isLoading = true;
    // });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res =
        await http.post(Uri.parse(urlCities), body: {'province_name': data});
    if (res.statusCode == 200) {
      setState(() {
        var resBody = json.decode(res.body)['Daftar_Kota'];
        // _isLoading = false;
        dataCities = resBody;
      });
    }
  }

// FILTER USIA
  var selectedUsia;
  List<String> _selectUsia = <String>[
    'Semua Usia',
    '> 60 Tahun',
    '50 - 60 Tahun',
    '< 50 Tahun',
  ];

// FETCH DATAPENS
  int currentPage = 1;
  int totalPages;
  List<dynamic> _users = [];
  bool _undefined = false;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> fetchDatapens({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;

      setState(() {
        itemSelected = 0;
        inputs.add(false);
      });
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri apiUrl = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/datapens');

    String pages = currentPage.toString();

    var res;
    res = await http.post(apiUrl, body: {
      'nik_sales': widget.nik,
      "province": selectedProvince,
      "city": setEmpty(selectedCities),
      "age": setEmpty(selectedUsia),
      "page": pages,
      "limit": "10",
    });

    if (res.statusCode == 200) {
      setState(() {
        if (json.decode(res.body)['Daftar_Datapens'] == 'DATA TIDAK TERSEDIA') {
          // _isLoading = false;
          _undefined = true;

          Toast.show(
            'DATA TIDAK TERSEDIA',
            context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red,
          );
        } else {
          if (isRefresh) {
            _users = json.decode(res.body)['Daftar_Datapens'];
          } else {
            _users.addAll(json.decode(res.body)['Daftar_Datapens']);
          }
          // _users = json.decode(res.body)['Daftar_Datapens'];
          currentPage++;
          totalPages = _users.length;
          _undefined = false;
        }
      });
      return true;
    } else {
      setState(() {
        _undefined = true;
      });
      return false;
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
    return user['no_ktp'];
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
      // fetchDatapens();
    });
  }

  AnimationController _controller;
  BorderRadiusTween borderRadius;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  double _height, min = 0.1, initial = 0.7, max = 0.7;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();

    setState(() {
      for (int i = 0; i < 100; i++) {
        inputs.add(false);
      }
    });
    // getProvinces();
    _controller = AnimationController(vsync: this, duration: _duration);
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(10.0),
      end: BorderRadius.circular(0.0),
    );
    // fetchDatapens();

    // Future.delayed(Duration(seconds: 1)).then((_) {
    //   _onButtonSearchPressed();
    // });
  }

  void ItemChange(
    bool val,
    int index,
    String notas,
    String nama,
  ) {
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
        backgroundColor: Color(0xfff3f3f3),
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: selectedProvince != null
              ? Text(
                  selectedProvince,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'LeadsGo-Font',
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : Text(
                  'Database Master',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'LeadsGo-Font',
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                MdiIcons.database,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanningScreen(
                        widget.username, widget.nik, widget.hakAkses),
                  ),
                );
              },
              // onPressed: () => _onButtonSearchPressed(),
            ),
          ],
        ),

        floatingActionButton: GestureDetector(
          child: FloatingActionButton(
            child: AnimatedIcon(
                icon: AnimatedIcons.menu_close, progress: _controller),
            elevation: 5,
            backgroundColor: leadsGoColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              if (_controller.isDismissed) {
                _controller.forward();
                getProvinces();
              } else if (_controller.isCompleted) {
                _controller.reverse();
                // selectedProvince = null;
                // selectedCities = null;
                // selectedUsia = null;
              }
            },
          ),
        ),
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              // SizedBox(
              Container(
                child: _buildList(),
              ),
              // ),
              SizedBox.expand(
                child: SlideTransition(
                  position: _tween.animate(_controller),
                  child: DraggableScrollableSheet(
                    minChildSize: min,
                    maxChildSize: max,
                    initialChildSize: initial,
                    builder:
                        (BuildContext context, ScrollController controller) {
                      if (controller.hasClients) {
                        var dimension = controller.position.viewportDimension;
                        _height ??= dimension / initial;
                        if (dimension >= _height * max * 0.7)
                          _onWidgetDidBuild(() {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('ON TOP'),
                              duration: Duration(seconds: 3),
                            ));
                          });
                        else if (dimension <= _height * min * 0.1)
                          _onWidgetDidBuild(() {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('ON BOTTOM'),
                              duration: Duration(seconds: 3),
                            ));
                          });
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                              ),
                            ]),
                        child: ListView(
                          controller: controller,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 7,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Mau interaksi ke mana?',
                              style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Divider(
                              color: Colors.black38,
                              thickness: 1,
                            ),
                            SizedBox(height: 10),
                            fieldProvince(),
                            SizedBox(height: 20),
                            fieldCities(),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.black38,
                              thickness: 1,
                            ),
                            SizedBox(height: 10),
                            fieldAge(),
                            SizedBox(height: 20),
                            FlatButton(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: leadsGoColor),
                                padding: EdgeInsets.all(2.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Terapkan Pencarian',
                                    style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_controller.isDismissed)
                                  _controller.forward();
                                else if (_controller.isCompleted)
                                  _controller.reverse();
                                fetchDatapens(isRefresh: true);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
        //                           builder: (context) => DatapensNextPlanningScreen(
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

  _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _onButtonSearchPressed() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              // height: 500,
              height: MediaQuery.of(context).size.height * 0.75,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: _buildSearch(),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10.0,
                      ),
                    ]),
              ),
            );
          });
        });
  }

  Widget _buildSearch() {
    return Stack(
      children: <Widget>[
        Container(
            height: 50.0,
            // width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.only(right: 50.0, left: 50.0),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            )),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'Mau interaksi ke mana?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(top: 60.0),
          height: 1000,
          child: ListView(
            children: <Widget>[
              fieldProvince(),
              SizedBox(height: 10),
              fieldCities(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    // if (_isLoading == true) {
    //   return Center(
    //       child: CircularProgressIndicator(
    //     valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
    //   ));
    // } else {
    if (_users.length > 0 && _undefined != true) {
      return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        // enablePullDown: true,
        // onRefresh: _getData,
        onRefresh: () async {
          final result = await fetchDatapens(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await fetchDatapens();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 1.0),
              // margin: const EdgeInsets.all(t: 3.0),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(10.0),
                  ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DatapensViewScreen(
                            widget.nik,
                            widget.username,
                            widget.hakAkses,
                            _id(_users[index]),
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
                  padding: const EdgeInsets.all(8.0),
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
                              'Gaji Pokok : ' +
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
                                Icons.person_outline,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Usia : ' +
                                  setNull(umur(int.parse(
                                          _tglLahir(_users[index])
                                              .substring(0, 4)))
                                      .toString()) +
                                  ' Tahun',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'LeadsGo-Font'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // trailing: Checkbox(
                    //   value: inputs[index],
                    //   onChanged: (bool value) {
                    //     ItemChange(
                    //       value,
                    //       index,
                    //       _nopen(_users[index]),
                    //       _nama(_users[index]),
                    //     );
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
      );
    } else {
      if (_undefined == true) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(width: 7.0, color: Colors.red),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      MdiIcons.databaseOff,
                      size: 70,
                      color: Colors.red,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Belum tersedia!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "LeadsGo-Font",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Text(
                  selectedCities != null
                      ? 'PROVINSI ' + selectedProvince + ' -> ' + selectedCities
                      : 'PROVINSI ' + selectedProvince,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "LeadsGo-Font",
                      fontSize: 16,
                      fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 50,
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
                    'Cari Lagi Yuk! ',
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                onPressed: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                    getProvinces();
                  } else if (_controller.isCompleted) {
                    _controller.reverse();
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontFamily: 'LeadsGo-Font',
                      color: leadsGoColor,
                      fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlanningScreen(
                              widget.username, widget.nik, widget.hakAkses)));
                },
                child: const Text('Lihat Database Saya'),
              ),
            ],
          ),
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
                  child: Icon(
                    MdiIcons.databaseSearch,
                    size: 70,
                    color: leadsGoColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Pencarian Database',
                style: TextStyle(
                    fontFamily: "LeadsGo-Font",
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
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
                    'Mulai Pencarian',
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                onPressed: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                    getProvinces();
                  } else if (_controller.isCompleted) {
                    _controller.reverse();
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontFamily: 'LeadsGo-Font',
                      color: leadsGoColor,
                      fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlanningScreen(
                              widget.username, widget.nik, widget.hakAkses)));
                },
                child: const Text('Lihat Database Saya'),
              ),
            ],
          ),
        );
      }
    }
    // }
  }

  Widget fieldProvince() {
    return DropdownButtonFormField(
      items: dataProvinces
          .map((value) => DropdownMenuItem(
                child: Text(
                  value['province_name'],
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
                ),
                value: value['province_name'],
              ))
          .toList(),
      onChanged: (newValueProvince) {
        setState(() {
          selectedCities = null;
          getCities(newValueProvince);
          selectedProvince = newValueProvince;
        });
      },
      decoration: InputDecoration(
        labelText: '*Pilih Provinsi',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 0),
        // contentPadding: EdgeInsets.all(5),
        labelStyle: TextStyle(
          fontFamily: 'LeadsGo-Font',
        ),
      ),
      value: selectedProvince,
      isExpanded: true,
    );
  }

  Widget fieldCities() {
    return DropdownButtonFormField(
      items: dataCities
          .map((value) => DropdownMenuItem(
                child: Text(
                  value['city_name'],
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
                ),
                value: value['city_name'],
              ))
          .toList(),
      onChanged: (newValueCity) {
        setState(() {
          selectedCities = newValueCity;
        });
      },
      decoration: InputDecoration(
        labelText: 'Pilih Kota',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 0),
        // contentPadding: EdgeInsets.all(5),
        labelStyle: TextStyle(
          fontFamily: 'LeadsGo-Font',
        ),
      ),
      value: selectedCities,
      // isExpanded: true,
    );
  }

  Widget fieldAge() {
    return DropdownButtonFormField(
      items: _selectUsia
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
          selectedUsia = selectedExFeedBack;
        });
      },
      decoration: InputDecoration(
        labelText: 'Pilih Usia',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 0),
        // contentPadding: EdgeInsets.all(5),
        labelStyle: TextStyle(
          fontFamily: 'LeadsGo-Font',
        ),
      ),
      value: selectedUsia,
      isExpanded: true,
    );
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return 'NULL';
    } else {
      return data;
    }
  }

  setEmpty(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return '';
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
    if (nama.length > 25) {
      for (int i = 21; i < nama.length; i++) {
        nama = replaceCharAt(nama, i, '.');
      }
      return nama.substring(0, 25);
    } else {
      return nama;
    }
  }

  Widget fieldTanggal() {
    // final format = DateFormat("yyyy-MM-dd");
    final format = DateFormat("dd-MM-yyyy");
    return Column(
      children: <Widget>[
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
          style: TextStyle(fontSize: 14, fontFamily: 'LeadsGo-Font'),
        ),
      ],
    );
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
}
