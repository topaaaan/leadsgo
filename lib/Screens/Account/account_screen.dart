import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadsgo_apps/Screens/Help/help_screen.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/Modul/modul_screen.dart';
import 'package:leadsgo_apps/Screens/Modul/view_image_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/profile_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/slip_gaji_screen.dart';
import 'package:leadsgo_apps/Screens/Redeem/redeem_screen.dart';
import 'package:leadsgo_apps/Screens/Utility/utility_screen.dart';
import 'package:leadsgo_apps/Screens/Voucher/voucher_screen.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();

  String username;
  String fotoProfil;
  String divisi;
  List personalData;
  String nik;
  String tarif;
  String hakAkses;
  int diamond;

  AccountScreen(this.username, this.fotoProfil, this.divisi, this.personalData,
      this.nik, this.tarif, this.hakAkses, this.diamond);
}

class _SettingScreenState extends State<AccountScreen> {
  var personalData = new List(38);
  bool visible = false;
  bool icon = false;
  String image1;
  String base64Image1;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;
  String path1 = '';
  @override
  void initState() {
    // SystemChrome.restoreSystemUIOverlays();
    images.add("Add Image");
    super.initState();
    String foto = 'https://tetranabasainovasi.com/marsit/' + widget.fotoProfil;
    setState(() {
      path1 = foto;
    });
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    super.dispose();
  }

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getLogin');

    //starting web api call
    var response = await http
        .post(url, body: {'username': username, 'password': password});

    if (username == '' || password == '') {
    } else {
      //if the response message is matched
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Daftar_Login'];
        print(message);
        if (message['message'].toString() == 'Login Success') {
          if (message['status_account'] == 'SUSPEND') {
          } else {
            setState(() {
              personalData[0] = message['nik'];
              personalData[1] = message['full_name'];
              personalData[2] = message['marital_status'];
              personalData[3] = message['date_of_birth'];
              personalData[4] = message['place_of_birth'];
              personalData[5] = message['no_ktp'];
              personalData[6] = message['gender'];
              personalData[7] = message['religion'];
              personalData[8] = message['email_address'];
              personalData[9] = message['phone_number'];
              personalData[10] = message['education'];
              personalData[11] = message['alamat'];
              personalData[12] = message['kelurahan'];
              personalData[13] = message['kecamatan'];
              personalData[14] = message['kabupaten'];
              personalData[15] = message['kode_pos'];
              personalData[16] = message['propinsi'];
              personalData[17] = message['no_rekening'];
              personalData[18] = message['nama_bank'];
              personalData[19] = message['nama_rekening'];
              personalData[20] = message['divisi_karyawan'];
              personalData[21] = message['jabatan_karyawan'];
              personalData[22] = message['wilayah_karyawan'];
              personalData[23] = message['branch'];
              personalData[24] = message['status_karyawan'];
              personalData[25] = message['grade_karyawan'];
              personalData[26] = message['gaji_pokok'];
              personalData[27] = message['tunjangan_tkd'];
              personalData[28] = message['tunjangan_jabatan'];
              personalData[29] = message['tunjangan_perumahan'];
              personalData[30] = message['tunjangan_telepon'];
              personalData[31] = message['tunjangan_kinerja'];
              personalData[32] = message['nik_marsit'];
              personalData[33] = message['diamond'];
              personalData[34] = message['total_pencairan'];
              personalData[35] = message['total_interaksi'];
              personalData[36] = message['total_interaksi'];
              personalData[37] = message['tgl_cut_off'];
            });
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                      widget.username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['full_name'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      widget.username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['full_name'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            }
          }
        } else {}
      } else {
        print('error');
      }
    }
  }

  Future uploadProfil() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/uploadProfil');

    //starting web api call
    var response;
    response = await http.post(url, body: {
      'nik': widget.nik,
      'file_name': 'profil',
      'image1': base64Image1,
      'name1': image1,
      'image': '0'
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Profil'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          icon = true;
        });
        Toast.show(
          'Sukses upload profil',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
        );
        Navigator.of(context).pop();
        userLogin();
      } else {
        setState(() {
          visible = false;
          icon = true;
        });
        Toast.show(
          'Gagal upload profil',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pop();
        userLogin();
      }
    }
  }

  Future userLogout() async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getLogout');
    int timeout = 30;
    try {
      var res = await http
          .post(url, body: {'nik': widget.nik})
          .catchError((e) {})
          .timeout(Duration(seconds: timeout));

      if (res.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // status bar color
          statusBarBrightness: Brightness.dark, //status bar brigtness
          statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
        ));
      } else {
        alert(leadsGoColor, 'Aplikasi sedang maintenance',
            'Untuk sementara waktu aplikasi sedang ada perbaikan.');
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Gagal koneksi ke server',
          'Mohon periksa jaringan internet kamu, dan nyalakan paket data atau wifi.');
    } on Error catch (e) {
      print('Timeout Error: $e');
      alert(leadsGoColor, 'Aplikasi membutuhkan akses internet',
          'Mohon nyalakan paket data atau wifi untuk mengunakan aplikasi.');
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: leadsGoColor, // status bar color
      statusBarBrightness: Brightness.light, //status bar brigtness
      statusBarIconBrightness: Brightness.light, //status barIcon Brightness
    ));
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 140,
          backgroundColor: leadsGoColor,
          title: Container(
            child: Column(
              children: <Widget>[
                Container(
                    color: leadsGoColor,
                    margin: EdgeInsets.only(bottom: 0, top: 0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          buildGridView(),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Toast.show(
                                        'Jenis Kelamin ' +
                                            widget.personalData[6],
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.blue,
                                      );
                                    },
                                    child: widget.personalData[6] == 'WANITA'
                                        ? SvgPicture.asset(
                                            "assets/images/woman_b.svg",
                                            width: 30.0,
                                            semanticsLabel: 'Wanita',
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/man_b.svg",
                                            width: 30.0,
                                            semanticsLabel: 'Pria',
                                          ),
                                    // child: Icon(
                                    //   MdiIcons.chessQueen,
                                    //   color: setColor(widget.personalData[36]),
                                    // ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.personalData[1]}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Marketing Representative Tipe ${widget.personalData[36]}',
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            // fontStyle: FontStyle.italic,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 3,
                              // ),
                              // Text(
                              //   widget.personalData[24] == 'MARKETING AGENT'
                              //       ? 'MARKETING REPRESENTATIVE'
                              //       : '${widget.personalData[24]}',
                              //   style: TextStyle(
                              //       fontFamily: 'LeadsGo-Font',
                              //       fontStyle: FontStyle.italic,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 12),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    //   // color: Color(0xFF98B4D4),
                                    //   color: Colors.green,
                                    // ),
                                    // padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Tooltip(
                                          message:
                                              'Total pencairan selama bergabung',
                                          child: SvgPicture.asset(
                                            "assets/images/badge.svg",
                                            width: 30.0,
                                            semanticsLabel: 'Points',
                                          ),
                                          // child: Icon(
                                          //   MdiIcons.bank,
                                          //   size: 20,
                                          // ),
                                        ),
                                        Text(
                                          ' ${formatRupiah(setKosong(widget.personalData[34]))}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'LeadsGo-Font',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 33,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          //                   <--- left side
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // padding: EdgeInsets.all(4.0),
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    //     // color: Color(0xFF98B4D4)),
                                    //     color: Colors.blue),
                                    child: Row(
                                      children: <Widget>[
                                        Tooltip(
                                          message:
                                              'Total interaksi selama bergabung',
                                          child: SvgPicture.asset(
                                            "assets/images/suitcase.svg",
                                            width: 28.0,
                                            semanticsLabel: 'Points',
                                          ),
                                          // child: Icon(
                                          //   Icons.directions_walk_outlined,
                                          //   size: 20,
                                          // ),
                                        ),
                                        Text(
                                          ' ${setKosong(widget.personalData[35])} Interaksi  ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'LeadsGo-Font',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ])),
              ],
            ),
          ),
          automaticallyImplyLeading: false),
      body: WillPopScope(
        child: Container(
            decoration: BoxDecoration(color: Colors.white54),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                // PROFIL
                Container(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileScreen(widget.personalData)));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.person),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Profil',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: 22,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),

                // SLIP GAJIH
                // Container(
                //   padding: EdgeInsets.only(
                //       left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(
                //     color: Colors.black12,
                //   ))),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: FlatButton(
                //             color: Colors.white,
                //             padding: EdgeInsets.only(left: 0.0),
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => SlipGajiScreen()));
                //             },
                //             child: Stack(
                //               children: <Widget>[
                //                 Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Row(
                //                       children: <Widget>[
                //                         Icon(Icons.notes_outlined),
                //                         SizedBox(width: 10),
                //                         Expanded(
                //                           child: Text(
                //                             'Slip Gaji',
                //                             style: TextStyle(
                //                                 fontFamily: 'LeadsGo-Font',
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16.0),
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //                 Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Icon(
                //                     Icons.chevron_right,
                //                     size: 22,
                //                   ),
                //                 ),
                //               ],
                //             )),
                //       ),
                //     ],
                //   ),
                // ),

                // Berita
                // Container(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(
                //     color: Colors.black12,
                //   ))),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: FlatButton(
                //             color: Colors.white,
                //             padding: EdgeInsets.only(left: 0.0),
                //             onPressed: () {
                //               Navigator.push(context,
                //                   MaterialPageRoute(builder: (context) => ModulScreen()));
                //             },
                //             child: Stack(
                //               children: <Widget>[
                //                 Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Row(
                //                       children: <Widget>[
                //                         Icon(
                //                           MdiIcons.fileDocumentOutline,
                //                         ),
                //                         SizedBox(width: 10),
                //                         Expanded(
                //                           child: Text(
                //                             'Berita',
                //                             style: TextStyle(
                //                                 fontFamily: 'LeadsGo-Font',
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16.0),
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //                 Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Icon(
                //                     Icons.chevron_right,
                //                     size: 22,
                //                   ),
                //                 ),
                //               ],
                //             )),
                //       ),
                //     ],
                //   ),
                // ),

                // INSENTIF
                // (widget.personalData[24] == 'MARKETING AGENT')
                //     ? Container(
                //         padding: EdgeInsets.only(
                //             left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                //         decoration: BoxDecoration(
                //           border: Border(
                //             bottom: BorderSide(
                //               color: Colors.black12,
                //             ),
                //           ),
                //         ),
                //         child: Column(
                //           children: <Widget>[
                //             Container(
                //               child: FlatButton(
                //                   color: Colors.white,
                //                   padding: EdgeInsets.only(left: 0.0),
                //                   onPressed: () {
                //                     Navigator.push(
                //                         context,
                //                         MaterialPageRoute(
                //                             builder: (context) => VoucherScreen(
                //                                 widget.username,
                //                                 widget.nik,
                //                                 widget.tarif)));
                //                   },
                //                   child: Stack(
                //                     children: <Widget>[
                //                       Align(
                //                           alignment: Alignment.centerLeft,
                //                           child: Row(
                //                             children: <Widget>[
                //                               Icon(
                //                                 Icons.monetization_on_outlined,
                //                               ),
                //                               SizedBox(width: 10),
                //                               Expanded(
                //                                 child: Text(
                //                                   'Insentif',
                //                                   style: TextStyle(
                //                                       fontFamily:
                //                                           'LeadsGo-Font',
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       fontSize: 16.0),
                //                                 ),
                //                               ),
                //                             ],
                //                           )),
                //                       Align(
                //                         alignment: Alignment.centerRight,
                //                         child: Icon(
                //                           Icons.chevron_right,
                //                           size: 22,
                //                         ),
                //                       ),
                //                     ],
                //                   )),
                //             ),
                //           ],
                //         ),
                //       )
                //     : SizedBox(height: 0),

                // BANTUAN
                // Container(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(
                //     color: Colors.black12,
                //   ))),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: FlatButton(
                //             color: Colors.white,
                //             padding: EdgeInsets.only(left: 0.0),
                //             onPressed: () {
                //               Navigator.push(context,
                //                   MaterialPageRoute(builder: (context) => UtilityScreen()));
                //             },
                //             child: Stack(
                //               children: <Widget>[
                //                 Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Row(
                //                       children: <Widget>[
                //                         Icon(
                //                           Icons.accessible,
                //                         ),
                //                         SizedBox(width: 10),
                //                         Expanded(
                //                           child: Text(
                //                             'Bantuan',
                //                             style: TextStyle(
                //                                 fontFamily: 'LeadsGo-Font',
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16.0),
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //                 Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Icon(
                //                     Icons.chevron_right,
                //                     size: 22,
                //                   ),
                //                 ),
                //               ],
                //             )),
                //       ),
                //     ],
                //   ),
                // ),

                // TUKAR PULSA
                // Container(
                //   padding: EdgeInsets.only(
                //       left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(
                //     color: Colors.black12,
                //   ))),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: FlatButton(
                //             color: Colors.white,
                //             padding: EdgeInsets.only(left: 0.0),
                //             onPressed: () {
                //               if (widget.tarif == '0.50') {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => RedeemScreen(
                //                             widget.username,
                //                             widget.nik,
                //                             widget.diamond)));
                //               } else {
                //                 Toast.show(
                //                   'Maaf fitur ini belum tersedia',
                //                   context,
                //                   duration: Toast.LENGTH_LONG,
                //                   gravity: Toast.CENTER,
                //                   backgroundColor: Colors.grey,
                //                 );
                //               }
                //             },
                //             child: Stack(
                //               children: <Widget>[
                //                 Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Row(
                //                       children: <Widget>[
                //                         Icon(
                //                           Icons.phone_android,
                //                         ),
                //                         SizedBox(width: 10),
                //                         Expanded(
                //                           child: Text(
                //                             'Tukar Pulsa',
                //                             style: TextStyle(
                //                                 fontFamily: 'LeadsGo-Font',
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16.0),
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //                 Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Icon(
                //                     Icons.chevron_right,
                //                     size: 22,
                //                   ),
                //                 ),
                //               ],
                //             )),
                //       ),
                //     ],
                //   ),
                // ),

                // FAQ
                Container(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HelpScreen()));
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.question_answer_outlined,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'FAQ',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: 22,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),

                // LOGOUT
                // Container(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom: BorderSide(
                //     color: Colors.black12,
                //   ))),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: FlatButton(
                //             color: Colors.white,
                //             padding: EdgeInsets.only(left: 0.0),
                //             onPressed: () {
                //               showDialog(
                //                 context: context,
                //                 builder: (BuildContext context) => AlertDialog(
                //                   title: Text(
                //                     'Apakah anda ingin keluar ?',
                //                     style: TextStyle(
                //                       fontFamily: 'LeadsGo-Font',
                //                     ),
                //                   ),
                //                   actions: <Widget>[
                //                     Center(
                //                       child: Row(
                //                         mainAxisAlignment: MainAxisAlignment.center,
                //                         crossAxisAlignment: CrossAxisAlignment.center,
                //                         children: [
                //                           RaisedButton(
                //                             onPressed: () {
                //                               print("you choose no");
                //                               Navigator.of(context).pop();
                //                             },
                //                             color: Colors.redAccent,
                //                             child: Container(
                //                               width: 60,
                //                               padding: EdgeInsets.all(8.0),
                //                               decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.circular(4),
                //                                 // color: Colors.blueAccent,
                //                               ),
                //                               child: Center(
                //                                 child: Text(
                //                                   'Tidak',
                //                                   style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontFamily: 'LeadsGo-Font',
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 15,
                //                           ),
                //                           RaisedButton(
                //                             onPressed: () {
                //                               Navigator.of(context).pop(false);
                //                               SystemNavigator.pop();
                //                             },
                //                             color: Colors.blueAccent,
                //                             child: Container(
                //                               width: 60,
                //                               padding: EdgeInsets.all(8.0),
                //                               decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.circular(4),
                //                                 // color: Colors.blueAccent,
                //                               ),
                //                               child: Center(
                //                                 child: Text(
                //                                   'Ya',
                //                                   style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontFamily: 'LeadsGo-Font',
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               );
                //             },
                //             child: Stack(
                //               children: <Widget>[
                //                 Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Row(
                //                       children: <Widget>[
                //                         Icon(
                //                           Icons.logout,
                //                         ),
                //                         SizedBox(width: 10),
                //                         Expanded(
                //                           child: Text(
                //                             'Keluar',
                //                             style: TextStyle(
                //                                 fontFamily: 'LeadsGo-Font',
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16.0),
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //                 Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Icon(
                //                     Icons.chevron_right,
                //                     size: 22,
                //                   ),
                //                 ),
                //               ],
                //             )),
                //       ),
                //     ],
                //   ),
                // ),

                Container(
                  padding: EdgeInsets.only(
                      left: 16.0, top: 5.0, right: 16.0, bottom: 12.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              _launchURL(
                                  "https://play.google.com/store/apps/details?id=com.tetra.leadsgo_apps");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  MdiIcons.medalOutline,
                                  size: 20,
                                  color: Colors.blueAccent,
                                ),
                                Text(
                                  'Nilai Kami',
                                  style: TextStyle(
                                    fontSize: 14,
                                    // fontFamily: 'LeadsGo-Font',
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            )),
                        Text(
                          'Version 1.0.11',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'LeadsGo-Font',
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // KELUAR
                Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(123)),
                      color: leadsGoColor,
                      padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                      onPressed: () {
                        showDialog(
                          context: context,
                          // barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Keluar dari LeadsGo',
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 1.3,
                                    letterSpacing: 0.30,
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                    color: leadsGoColor,
                                    // fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Apakah Anda yakin ingin keluar?',
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 1.3,
                                    letterSpacing: 0.10,
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              Center(
                                  child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: Text(
                                          'BATALKAN',
                                          style: TextStyle(
                                            color: leadsGoColor,
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      TextButton(
                                        onPressed: () {
                                          userLogout();
                                          Navigator.pop(context, false);
                                        },
                                        child: Text(
                                          'KELUAR',
                                          style: TextStyle(
                                            color: leadsGoColor,
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                    ],
                                  ),
                                ],
                              ))
                            ],
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Keluar',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 110,
                ),
              ],
            )),
        onWillPop: () async {
          Future.value(false);
        },
      ),
    );
  }

  setColor(String rating) {
    switch (rating) {
      case 'bronze':
        return Color(0xFFcd7f32);
        break;
      case 'gold':
        return Color(0xFFFFD700);
        break;
      case 'platinum':
        return Color(0xFFE5E4E2);
        break;
      case 'silver':
        return Color(0xFFC0C0C0);
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
    return fmf.output.withoutFractionDigits;
  }

  setKosong(data) {
    if (data == null || data == '') {
      return '0';
    } else {
      return data;
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildGridView() {
    if (images[0] is ImageUploadModel) {
      ImageUploadModel uploadModel = images[0];
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
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: FileImage(uploadModel.imageFile),
                )),
            icon == false
                ? Positioned(
                    left: 5,
                    top: 5,
                    child: InkWell(
                      child: Icon(
                        Icons.save,
                        size: 20,
                        color: Colors.blue,
                      ),
                      onTap: () {},
                    ),
                  )
                : Text(''),
            icon == false
                ? Positioned(
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
                          images.replaceRange(0, 0 + 1, ['Add Image']);
                        });
                      },
                    ),
                  )
                : Text(''),
          ],
        ),
      );
    } else {
      if (path1 != '') {
        return InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    height: 100,
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: leadsGoColor,
                          onPressed: () {
                            print(path1);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ImageApp(
                                    path1.substring(38), 'Foto Profil')));
                          },
                          child: Text(
                            'Lihat',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: leadsGoColor,
                          onPressed: () {
                            _onAddImageClick(0);
                          },
                          child: Text(
                            'Ubah Foto',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          },
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(path1),
            backgroundColor: Colors.black45,
          ),
        );
      } else {
        InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ));
          },
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(''),
          ),
        );
      }
    }
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
            showGeneralDialog(
              context: context,
              barrierColor: Colors.black12.withOpacity(0.6), // background color
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                      ),
                    ),
                  ],
                );
              },
            );
            uploadProfil();
          }
        }
      });
    });
  }

  Widget alert(colorMessage, String headsMessage, String bodyMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anda gagal keluar!',
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.30,
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  headsMessage,
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.30,
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: colorMessage,
                    // fontSize: 14,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  bodyMessage,
                  style: TextStyle(
                    height: 1.3,
                    letterSpacing: 0.10,
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          'OKE',
                          style: TextStyle(
                            color: colorMessage,
                            fontFamily: 'LeadsGo-Font',
                            fontWeight: FontWeight.bold,
                            // fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ],
              ))
            ],
          );
        });
  }
}
