import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_akad.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_edit.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_submit.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_akad_provider.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_provider.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_submit_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:leadsgo_apps/components/rounded_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_add_new.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Screens/Login/login_screen.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';

class PipelineRootPage extends StatefulWidget {
  String username;
  String nik;
  String personalData;

  PipelineRootPage(this.username, this.nik);
  @override
  _PipelinePageState createState() => new _PipelinePageState();
}

class _PipelinePageState extends State<PipelineRootPage> {
  bool visiblex = false;

  var personalData = new List(38);

  var selectedKeterangan;
  final String url =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getKeteranganPipeline';
  List datax = List();

  @override
  void initState() {
    super.initState();
    this.getKeteranganPipeline();
  }

  Future<String> getKeteranganPipeline() async {
    setState(() {
      visiblex = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res =
        await http.get(Uri.parse(url), headers: {'accept': 'application/json'});

    if (res.statusCode == 200) {
      var resBody = json.decode(res.body)['Daftar_Keluhan'];
      setState(() {
        datax = resBody;
        visiblex = false;
        print(datax);
      });
    } else {
      throw Exception();
    }
  }

  bool visible = false;

  Future invalidLogin(message, error) async {
    return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Column(
              children: [
                Icon(
                  message == 'response'
                      ? MdiIcons.earth
                      : message == 'generalError'
                          ? MdiIcons.wifiCancel
                          : MdiIcons.timerOffOutline,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(height: 15),
                Text(
                  message == 'response'
                      ? 'Server Maintenance'
                      : message == 'generalError'
                          ? 'Tidak Terkoneksi'
                          : 'Koneksi Terlalu Lama',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message == 'response'
                      ? 'Mohon segera laporkan, karena terdapat pesan : "$error"'
                      : message == 'generalError'
                          ? 'Mohon aktifkan jaringan koneksi internet ponsel anda !'
                          : 'Koneksi terlalu lambat, mohon periksa jaringan anda, !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          // Navigator.removeRoute(
                          //     context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                              (route) => false);
                        },
                        color: Colors.grey,
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              'Keluar',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'LeadsGo-Font',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (message == 'response') {
                            // Navigator.pop(context, false);
                            String teleponFix = '+62' + '082130345751';
                            String username = widget.username;
                            String messageError = error.toString();
                            launchWhatsApp(
                                phone: teleponFix,
                                message: username +
                                    ',\nmelaporkan adanya pesan bertuliskan "' +
                                    messageError +
                                    '" ketika ingin kembali dari menu pipeline ke menu utama !');
                          } else {
                            // Navigator.pop(context);
                            userLogin();
                          }
                        },
                        color:
                            message == 'response' ? Colors.red : leadsGoColor,
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              message == 'response'
                                  ? 'Laporkan !'
                                  : 'Coba Lagi !',
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

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

    setState(() {
      visiblex = true;
    });
    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSmartLogin');

    //starting web api call
    int timeout = 30;
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12.withOpacity(0.6),
      builder: (BuildContext context) {
        dialogContext = context;
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              child: Center(
                child: Container(
                  child: SpinKitThreeBounce(
                    color: leadsGoColor,
                    size: 50.0,
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );

    try {
      var response = await http.post(url,
          body: {'username': username, 'password': password}).catchError((e) {
        // SocketException would show up here, potentially after the timeout.
      }).timeout(Duration(seconds: timeout));

      if (username == '' || password == '') {
      } else {
        //if the response message is matched
        if (response.statusCode == 200) {
          Navigator.pop(context, false);
          var message = jsonDecode(response.body)['Daftar_Login'];
          print(message);
          if (message['message'].toString() == 'Login Success') {
            Navigator.pop(context, false);
            setState(() {
              visiblex = false;
            });
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
                personalData[36] = message['tipe'];
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
          } else {
            Navigator.pop(context, false);
          }
        } else {
          var message = 'response';
          var error = 'Status Code ${response.statusCode}';
          print('Status Code Error: $message');
          setState(() {
            visiblex = false;
          });
          Navigator.pop(context, false);
          Navigator.pop(dialogContext);
          // GAGAL LOGIN
          invalidLogin(message, error);
        }
      }
      // } on SocketException catch (e) {
      //   print('Socket Error: $e');
      //   setState(() {
      //     visiblex = false;
      //   });
      //   Navigator.pop(context, false);
      //   // GAGAL LOGIN
      //   var message = 'socketError';
      //   var error = e;
      //   invalidLogin(message, error);
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      // setState(() {
      //   visiblex = false;
      // });
      Navigator.pop(context, false);
      Navigator.pop(dialogContext);
      // GAGAL LOGIN
      var message = 'timeoutError';
      var error = e;
      invalidLogin(message, error);
    } on Error catch (e) {
      print('General Error: $e');
      // setState(() {
      //   visiblex = false;
      // });
      Navigator.pop(context, false);
      Navigator.pop(dialogContext);
      // GAGAL LOGIN
      var message = 'generalError';
      var error = e;
      invalidLogin(message, error);
    }
  }

  Future deletePipeline(String id) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/deletePipeline');
    var response = await http.post(url, body: {'id_pipeline': id});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Pipeline'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses delete pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal delete pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      }
    }
  }

  Future simpanKeteranganPipeline(
      String idKeterangan, String idPipeline) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/simpanKeteranganPipeline');
    var response = await http.post(url,
        body: {'id_keterangan': idKeterangan, 'id_pipeline': idPipeline});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Kondisi_Pipeline'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses simpan kondisi pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal simpan kondisi pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      }
    }
  }

  _showPopupMenu(
          String id,
          String namaNasabah,
          String noKtp,
          String noNip,
          String telepon,
          String plafond,
          String cabang,
          String tanggalPenyerahan,
          String namaPenerima,
          String teleponPenerima,
          String statusPipeline,
          String fotoSubmit,
          String tanggalAkad,
          // String nomorAplikasi,
          String nomorRekening,
          String nomorPerjanjian,
          String nominalPinjaman,
          String finalOS,
          String nominalTopUp,
          String jenisProduk,
          String informasiSales,
          String namaPetugasBank,
          // String jabatanPetugasBank,
          String kodeAO,
          String teleponPetugasBank,
          String fotoAkad1,
          String fotoAkad2,
          String idKeterangan) =>
      PopupMenuButton<int>(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        // padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
        itemBuilder: (context) => [
          statusPipeline == '2'
              ? null
              : PopupMenuItem(
                  value: 1,
                  child: GestureDetector(
                    onTap: () {
                      // if (statusPipeline != '2') {
                      if (statusPipeline != '2') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PipelineEditScreen(
                                    widget.username, widget.nik, id)));
                        // } else if (statusPipeline == '3') {
                        //   Toast.show(
                        //     'Pipeline sudah submit dan tidak bisa ubah pipeline',
                        //     context,
                        //     duration: Toast.LENGTH_LONG,
                        //     gravity: Toast.BOTTOM,
                        //     backgroundColor: Colors.red,
                        //   );
                        // } else if (statusPipeline == '4') {
                        //   Toast.show(
                        //     'Pipeline sudah akad dan tidak bisa ubah pipeline',
                        //     context,
                        //     duration: Toast.LENGTH_LONG,
                        //     gravity: Toast.BOTTOM,
                        //     backgroundColor: Colors.red,
                        //   );
                      } else {
                        Toast.show(
                          'Pipeline sudah pencairan dan tidak bisa ubah pipeline',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Tooltip(
                        message: 'Ubah Data Pipeline',
                        child: Row(
                          children: <Widget>[
                            Icon(
                              MdiIcons.pencil,
                              color: leadsGoColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Ubah Data Pipeline',
                              style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                              ),
                            )
                          ],
                        )),
                  ),
                ),
          statusPipeline == '3' || statusPipeline == '4'
              ? null
              : PopupMenuItem(
                  value: 2,
                  child: GestureDetector(
                    onTap: () {
                      if (statusPipeline == '2') {
                        Toast.show(
                          'Pipeline sudah pencairan dan tidak bisa submit dokumen kembali',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red,
                        );
                      } else if (statusPipeline == '3' ||
                          statusPipeline == '4') {
                        Toast.show(
                          'Submit dokumen tidak bisa diulang',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red,
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PipelineSubmitScreen(
                                    widget.username,
                                    widget.nik,
                                    id,
                                    namaNasabah,
                                    noKtp,
                                    noNip,
                                    telepon,
                                    plafond,
                                    cabang,
                                    tanggalPenyerahan,
                                    namaPenerima,
                                    teleponPenerima,
                                    fotoSubmit)));
                      }
                    },
                    child: Tooltip(
                        message: 'Submit Dokumen',
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.send,
                              color: leadsGoColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Submit Dokumen',
                              style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                              ),
                            )
                          ],
                        )),
                  ),
                ),
          statusPipeline == '1'
              ? null
              : PopupMenuItem(
                  value: 3,
                  child: GestureDetector(
                    onTap: () {
                      if (statusPipeline != '2') {
                        if (statusPipeline == '3' || statusPipeline == '4') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PipelineAkadScreen(
                                      '',
                                      widget.username,
                                      widget.nik,
                                      id,
                                      statusPipeline,
                                      namaNasabah,
                                      noKtp,
                                      noNip,
                                      telepon,
                                      plafond,
                                      cabang,
                                      tanggalPenyerahan,
                                      namaPenerima,
                                      teleponPenerima,
                                      tanggalAkad,
                                      // nomorAplikasi,
                                      nomorRekening,
                                      nomorPerjanjian,
                                      nominalPinjaman,
                                      finalOS,
                                      nominalTopUp,
                                      jenisProduk,
                                      informasiSales,
                                      namaPetugasBank,
                                      // jabatanPetugasBank,
                                      kodeAO,
                                      teleponPetugasBank,
                                      fotoAkad1,
                                      fotoAkad2)));
                        } else {
                          Toast.show(
                            'Silahkan submit dokumen terlebih dahulu',
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Colors.red,
                          );
                        }
                      } else {
                        Toast.show(
                          'Pipeline sudah pencairan dan tidak bisa akad kredit kembali',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Tooltip(
                        message: 'Akad Kredit',
                        child: Row(
                          children: <Widget>[
                            Icon(
                              statusPipeline == '4'
                                  ? MdiIcons.pencil
                                  : Icons.date_range,
                              color: leadsGoColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              statusPipeline == '4'
                                  ? 'Ubah Data Akad'
                                  : 'Akad Kredit',
                              style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                              ),
                            )
                          ],
                        )),
                  ),
                ),
          PopupMenuDivider(
            height: 10,
          ),
          PopupMenuItem(
            value: 4,
            child: GestureDetector(
              onTap: () {
                if (statusPipeline != '2') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Apakah anda ingin menghapus pipeline debitur ' +
                            namaNasabah +
                            ' ?',
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          color: leadsGoColor,
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              color: Colors.grey,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Tidak',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'LeadsGo-Font',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            FlatButton(
                              color: leadsGoColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                                deletePipeline(
                                  id,
                                );
                              },
                              child: Text(
                                'Ya !',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'LeadsGo-Font',
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa di hapus',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Delete',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: leadsGoColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hapus',
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                        ),
                      )
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedKeterangan = idKeterangan;
                });
                if (statusPipeline != '2') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Row(children: [
                        Icon(
                          MdiIcons.tag,
                          color: leadsGoColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Kondisi Pipeline',
                          style: TextStyle(
                            fontFamily: 'LeadsGo-Font',
                          ),
                        ),
                      ]),
                      actions: <Widget>[
                        FlatButton(
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'LeadsGo-Font',
                            ),
                          ),
                        ),
                        FlatButton(
                          color: leadsGoColor,
                          onPressed: () {
                            if (selectedKeterangan == null) {
                              Toast.show(
                                'Silahkan pilih kondisi pipeline terlebih dahulu...',
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Colors.red,
                              );
                            } else {
                              Navigator.of(context).pop();
                              simpanKeteranganPipeline(selectedKeterangan, id);
                            }
                          },
                          child: visiblex
                              ? CircularProgressIndicator(
                                  //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  'Simpan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'LeadsGo-Font',
                                  ),
                                ),
                        ),
                      ],
                      content: fieldKeteranganPipeline(),
                    ),
                  );
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa ubah kondisi kembali',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Ubah Kondisi',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        MdiIcons.tag,
                        color: leadsGoColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        idKeterangan == null ? 'Buat Kondisi' : 'Ubah Kondisi',
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
        icon: Icon(Icons.more_vert),
        offset: Offset(0, 30),
      );

  Future<bool> _onBackPressed(BuildContext context) async {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Column(
              children: [
                Icon(
                  MdiIcons.helpCircleOutline,
                  color: leadsGoColor,
                  size: 50.0,
                ),
                SizedBox(height: 15),
                Text(
                  'Apakah anda ingin keluar dari menu pipeline?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                    fontWeight: FontWeight.bold,
                    color: leadsGoColor,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
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
                          // Navigator.pop(context);
                          userLogin();
                        },
                        color: leadsGoColor,
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

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "https://wa.me/$phone/?text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          print('Back Button pressed!');
          final shouldPop = await _onBackPressed(context);
          return shouldPop;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: FadeAnimation(
                0.25,
                AppBar(
                  // automaticallyImplyLeading: true,
                  iconTheme: IconThemeData(
                    color: leadsGoColor, //change your color here
                  ),
                  centerTitle: false,
                  titleSpacing: 0.0,
                  backgroundColor: Colors.white,
                  title: Container(
                      // padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                    children: <Widget>[
                      Text(
                        'Pipeline',
                        style: TextStyle(
                            color: leadsGoColor,
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.info_outline,
                      //     color: leadsGoColor,
                      //   ),
                      //   onPressed: () {
                      //     Toast.show(
                      //       'Pipeline ' + bulan + ' ' + tahun,
                      //       context,
                      //       duration: Toast.LENGTH_LONG,
                      //       gravity: Toast.CENTER,
                      //       backgroundColor: Colors.blueAccent,
                      //     );
                      //   },
                      // ),
                    ],
                  )),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        MdiIcons.helpCircleOutline,
                        color: leadsGoColor,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Toast.show(
                          'Pipeline ' + bulan + ' ' + tahun,
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.TOP,
                          backgroundColor: leadsGoColor,
                        );
                      },
                    ),
                    // IconButton(
                    //   icon: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(100), color: leadsGoColor),
                    //     // padding: EdgeInsets.all(2.0),
                    //     child: Icon(
                    //       Icons.add,
                    //       color: Colors.white,
                    //       size: 30,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 PipelineAddScreen(widget.username, widget.nik)));
                    //   },
                    // )
                  ],
                  bottom: TabBar(
                    labelColor: leadsGoColor,
                    unselectedLabelColor: Colors.black38,
                    indicatorColor: leadsGoColor,
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.bold), //For Selected tab
                    unselectedLabelStyle: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.bold), //For Un-selected Tabs
                    tabs: <Widget>[
                      Tab(
                        text: 'SEMUA',
                      ),
                      Tab(
                        text: 'SUBMIT DOKUMEN',
                      ),
                      Tab(
                        text: 'AKAD KREDIT',
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(children: <Widget>[
              // SEMUA
              Container(
                  // color: Colors.white,
                  color: Color(0xfff3f3f3),
                  child: FutureBuilder(
                      future:
                          Provider.of<PipelineProvider>(context, listen: false)
                              .getPipeline(PipelineItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Container(
                                        child: SpinKitThreeBounce(
                                          color: leadsGoColor.withOpacity(0.5),
                                          size: 50.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        } else if (snapshot.hasData) {
                          return FadeAnimation(0.5, showPipeline());
                        } else {
                          return Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        MdiIcons.folderSyncOutline,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Data Pipeline\nBelum Tersedia',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "LeadsGo-Font",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        }
                      })),
              // SUBMIT DOKUMEN
              Container(
                  // color: Colors.white,
                  color: Color(0xfff3f3f3),
                  child: FutureBuilder(
                      future: Provider.of<PipelineSubmitProvider>(context,
                              listen: false)
                          .getPipeline(PipelineSubmitItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Container(
                                        child: SpinKitThreeBounce(
                                          color: leadsGoColor.withOpacity(0.5),
                                          size: 50.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        } else if (snapshot.hasData) {
                          return FadeAnimation(0.5, showSubmit());
                        } else {
                          return Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        MdiIcons.folderSyncOutline,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Data Submit Dokumen\nBelum Tersedia',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "LeadsGo-Font",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        }
                      })),
              // AKAD KREDIT
              Container(
                  color: Color(0xfff3f3f3),
                  child: FutureBuilder(
                      future: Provider.of<PipelineAkadProvider>(context,
                              listen: false)
                          .getPipeline(PipelineAkadItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Container(
                                        child: SpinKitThreeBounce(
                                          color: leadsGoColor.withOpacity(0.5),
                                          size: 50.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        } else if (snapshot.hasData) {
                          return FadeAnimation(0.5, showAkad());
                        } else {
                          return Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        MdiIcons.folderSyncOutline,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Data Akad Kredit\nBelum Tersedia',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "LeadsGo-Font",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        }
                      })),
            ]),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Tambah Pipeline',
              backgroundColor: leadsGoColor,
              child: Icon(
                MdiIcons.plus,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PipelineAddScreen(widget.username, widget.nik)));
              },
            ),
          ),
        ),
      ),
    );
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'In Pipeline';
    } else if (status == '2') {
      return 'Telah Pencairan';
    } else if (status == '3') {
      return 'Telah Di Submit';
    } else if (status == '4') {
      return 'Telah Akad';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.grey;
    } else if (status == '2') {
      return Colors.green;
    } else if (status == '3') {
      return Colors.redAccent;
    } else if (status == '4') {
      return leadsGoColor;
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
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'Rp ' + fmf.output.withoutFractionDigits + '';
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
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

  Widget fieldKeteranganPipeline() {
    return DropdownButtonFormField(
        items: datax
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value['keluhan'],
                    style: TextStyle(
                      fontFamily: 'LeadsGo-Font',
                    ),
                  ),
                  value: value['id'].toString(),
                ))
            .toList(),
        onChanged: (selectedKeteranganType) {
          setState(() {
            selectedKeterangan = selectedKeteranganType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Pilih Kondisi Pipeline',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedKeterangan,
        isExpanded: true);
  }

  setKTP(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'Tidak tersedia!';
    } else {
      for (int i = 8; i < data.length; i++) {
        data = replaceCharAt(data, i, '×');
      }
      return data;
    }
  }

  Widget showPipeline() {
    return Consumer<PipelineProvider>(builder: (context, data, _) {
      print(data.dataPipeline.length);
      if (data.dataPipeline.length == 0) {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  MdiIcons.folderSyncOutline,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Data Pipeline\nBelum Tersedia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "LeadsGo-Font",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ]),
        );
      } else {
        // SHOW IN PIPELINE
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.dataPipeline.length,
            itemBuilder: (context, i) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 1,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PipelineViewScreen(
                                    data.dataPipeline[i].namaNasabah,
                                    data.dataPipeline[i].tglPipeline,
                                    data.dataPipeline[i].alamat,
                                    data.dataPipeline[i].telepon,
                                    data.dataPipeline[i].jenisProduk,
                                    data.dataPipeline[i].plafond,
                                    data.dataPipeline[i].cabang,
                                    data.dataPipeline[i].keterangan,
                                    data.dataPipeline[i].status,
                                    data.dataPipeline[i].tempatLahir,
                                    data.dataPipeline[i].tanggalLahir,
                                    data.dataPipeline[i].jenisKelamin,
                                    data.dataPipeline[i].noKtp,
                                    data.dataPipeline[i].noNip,
                                    data.dataPipeline[i].tglPenyerahan,
                                    data.dataPipeline[i].tanggalAkad,
                                    // data.dataPipeline[i]
                                    //     .npwp,
                                    data.dataPipeline[i].statusKredit,
                                    data.dataPipeline[i].pengelolaPensiun,
                                    data.dataPipeline[i].bankTakeover,

                                    data.dataPipeline[i].foto1,
                                    data.dataPipeline[i].fotoAkad1,
                                    data.dataPipeline[i].fotoAkad2,
                                    data.dataPipeline[i].fotoTandaTerima,

                                    data.dataPipeline[i].nomorRekening,
                                    data.dataPipeline[i].nomorPerjanjian,
                                    data.dataPipeline[i].nominalPinjaman,
                                    data.dataPipeline[i].finalOS,
                                    data.dataPipeline[i].nominalTopUp,

                                    data.dataPipeline[i].kodeAO,
                                    data.dataPipeline[i].namaPetugasBank,
                                    data.dataPipeline[i].teleponPetugasBank,
                                  )));
                    },
                    child: Container(
                      // padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
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
                                    color: colorStatus(
                                        '${data.dataPipeline[i].status}'),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  setSubNama(data.dataPipeline[i].namaNasabah),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  messageStatus(
                                      '${data.dataPipeline[i].status}'),
                                  style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: colorStatus(
                                        '${data.dataPipeline[i].status}'),
                                  ),
                                ),
                                Wrap(
                                  spacing: 12,
                                  children: <Widget>[
                                    _showPopupMenu(
                                      data.dataPipeline[i].id.toString(),
                                      data.dataPipeline[i].namaNasabah
                                          .toString(),
                                      data.dataPipeline[i].noKtp.toString(),
                                      data.dataPipeline[i].noNip.toString(),
                                      data.dataPipeline[i].telepon.toString(),
                                      data.dataPipeline[i].plafond.toString(),
                                      data.dataPipeline[i].cabang.toString(),
                                      data.dataPipeline[i].tglPenyerahan
                                          .toString(),
                                      data.dataPipeline[i].namaPenerima
                                          .toString(),
                                      data.dataPipeline[i].teleponPenerima
                                          .toString(),
                                      data.dataPipeline[i].status,
                                      data.dataPipeline[i].fotoTandaTerima,
                                      data.dataPipeline[i].tanggalAkad,
                                      // data.dataPipeline[i]
                                      // .nomorAplikasi,
                                      data.dataPipeline[i].nomorRekening,
                                      data.dataPipeline[i].nomorPerjanjian,
                                      data.dataPipeline[i].nominalPinjaman,
                                      data.dataPipeline[i].finalOS,
                                      data.dataPipeline[i].nominalTopUp,
                                      // data.dataPipeline[i]
                                      //     .akadProduk,
                                      data.dataPipeline[i].jenisProduk,
                                      data.dataPipeline[i].salesInfo,
                                      data.dataPipeline[i].namaPetugasBank,
                                      // data.dataPipeline[i]
                                      //     .jabatanPetugasBank,
                                      data.dataPipeline[i].kodeAO,
                                      data.dataPipeline[i].teleponPetugasBank,
                                      data.dataPipeline[i].fotoAkad1,
                                      data.dataPipeline[i].fotoAkad2,
                                      data.dataPipeline[i].idKeterangan,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 130,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        // padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Status Kredit',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            color: Colors.black54,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${data.dataPipeline[i].statusKredit}',
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 130,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        // padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Nominal Plafond',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            color: Colors.black54,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        data.dataPipeline[i].statusKredit ==
                                                    'TOP UP' &&
                                                data.dataPipeline[i].status !=
                                                    '1' &&
                                                data.dataPipeline[i].status !=
                                                    '3'
                                            ? '${formatRupiah(data.dataPipeline[i].nominalTopUp)}'
                                            : '${formatRupiah(data.dataPipeline[i].plafond)}',
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            data.dataPipeline[i].keluhan == 'KONDISI KOSONG'
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Container(
                                    // padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.grey,
                                    ))),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.black54,
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(30, 30),
                                          alignment: Alignment.centerLeft),
                                      onPressed: () {
                                        setState(() {
                                          selectedKeterangan =
                                              data.dataPipeline[i].idKeterangan;
                                        });
                                        if (data.dataPipeline[i].status !=
                                            '2') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Row(children: [
                                                Icon(
                                                  MdiIcons.tag,
                                                  color: leadsGoColor,
                                                  size: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Kondisi Pipeline',
                                                  style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                  ),
                                                ),
                                              ]),
                                              actions: <Widget>[
                                                FlatButton(
                                                  color: Colors.grey,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Batal',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'LeadsGo-Font',
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  color: leadsGoColor,
                                                  onPressed: () {
                                                    if (selectedKeterangan ==
                                                        null) {
                                                      Toast.show(
                                                        'Silahkan pilih kondisi pipeline terlebih dahulu...',
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_LONG,
                                                        gravity: Toast.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      simpanKeteranganPipeline(
                                                        selectedKeterangan,
                                                        data.dataPipeline[i].id
                                                            .toString(),
                                                      );
                                                    }
                                                  },
                                                  child: visiblex
                                                      ? CircularProgressIndicator(
                                                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        )
                                                      : Text(
                                                          'Simpan',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'LeadsGo-Font',
                                                          ),
                                                        ),
                                                ),
                                              ],
                                              content:
                                                  fieldKeteranganPipeline(),
                                            ),
                                          );
                                        } else {
                                          Toast.show(
                                            'Pipeline sudah pencairan dan tidak bisa ubah kondisi kembali',
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM,
                                            backgroundColor: Colors.grey,
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.tag,
                                            // color: leadsGoColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${data.dataPipeline[i].keluhan}',
                                            style: TextStyle(
                                              fontFamily: 'LeadsGo-Font',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          data.dataPipeline[i].status == '1'
                                              ? SizedBox()
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      MdiIcons
                                                          .chevronDownCircleOutline,
                                                      color: Colors.black54,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Pipeline : ${data.dataPipeline[i].tglPipeline}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          data.dataPipeline[i].status == '1'
                                              ? SizedBox()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6.5,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .status ==
                                                                '2'
                                                            ? leadsGoColor
                                                            : data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .status ==
                                                                    '4'
                                                                ? Colors
                                                                    .redAccent
                                                                : colorStatus(
                                                                    '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          data.dataPipeline[i].status == '4'
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      MdiIcons.fileCheckOutline,
                                                      color: Colors.redAccent,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Submit : ${data.dataPipeline[i].tglPenyerahan}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          data.dataPipeline[i].status == '4'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          data.dataPipeline[i].status == '2'
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      MdiIcons
                                                          .checkCircleOutline,
                                                      color: leadsGoColor,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Akad : ${data.dataPipeline[i].tglPenyerahan}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          data.dataPipeline[i].status == '2'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6.5,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                data.dataPipeline[i].status ==
                                                        '2'
                                                    ? MdiIcons
                                                        .checkCircleOutline
                                                    : MdiIcons
                                                        .calendarCheckOutline,
                                                color: colorStatus(
                                                    '${data.dataPipeline[i].status}'),
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data.dataPipeline[i].status ==
                                                        '1'
                                                    ? 'Input pipeline pada\ntanggal ${data.dataPipeline[i].tglPipeline}'
                                                    : data.dataPipeline[i]
                                                                .status ==
                                                            '2'
                                                        ? 'Pipeline telah pencairan.\nUntuk melihat detail pencairan,\nsilahkan masuk ke menu pencairan.'
                                                        : data.dataPipeline[i]
                                                                    .status ==
                                                                '3'
                                                            ? 'Telah penyerahan berkas\npada tanggal ${data.dataPipeline[i].tglPenyerahan}'
                                                            : data.dataPipeline[i]
                                                                        .status ==
                                                                    '4'
                                                                ? 'Telah akad kredit pada\ntanggal ${data.dataPipeline[i].tanggalAkad}'
                                                                : '',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      data.dataPipeline[i].status != '2'
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                  // height: 40,
                                                  color: leadsGoColor,
                                                  onPressed: () {
                                                    if (data.dataPipeline[i]
                                                            .status ==
                                                        '1') {
                                                      if (data.dataPipeline[i]
                                                              .status ==
                                                          '2') {
                                                        Toast.show(
                                                          'Pipeline sudah pencairan dan tidak bisa submit dokumen kembali',
                                                          context,
                                                          duration:
                                                              Toast.LENGTH_LONG,
                                                          gravity: Toast.BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                        );
                                                      } else if (data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .status ==
                                                              '3' ||
                                                          data.dataPipeline[i]
                                                                  .status ==
                                                              '4') {
                                                        Toast.show(
                                                          'Submit dokumen tidak bisa diulang',
                                                          context,
                                                          duration:
                                                              Toast.LENGTH_LONG,
                                                          gravity: Toast.BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                        );
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => PipelineSubmitScreen(
                                                                    widget
                                                                        .username,
                                                                    widget.nik,
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .id
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .namaNasabah
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .noKtp
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .noNip
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .telepon
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .plafond
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .cabang
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .tglPenyerahan
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .namaPenerima
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .teleponPenerima
                                                                        .toString(),
                                                                    data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .fotoTandaTerima)));
                                                      }
                                                    } else if (data
                                                            .dataPipeline[i]
                                                            .status ==
                                                        '3') {
                                                      if (data.dataPipeline[i]
                                                              .status !=
                                                          '2') {
                                                        if (data.dataPipeline[i]
                                                                    .status ==
                                                                '3' ||
                                                            data.dataPipeline[i]
                                                                    .status ==
                                                                '4') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => PipelineAkadScreen(
                                                                      '',
                                                                      widget
                                                                          .username,
                                                                      widget
                                                                          .nik,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .id,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .status,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .namaNasabah,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .noKtp,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .noNip,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .telepon,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .plafond,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .cabang,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .tglPenyerahan,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .namaPenerima,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .teleponPenerima,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .tanggalAkad,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .nomorRekening,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .nomorPerjanjian,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .nominalPinjaman,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .finalOS,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .nominalTopUp,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .jenisProduk,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .salesInfo,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .namaPetugasBank,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .kodeAO,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .teleponPetugasBank,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .fotoAkad1,
                                                                      data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .fotoAkad2)));
                                                        } else {
                                                          Toast.show(
                                                            'Silahkan submit dokumen terlebih dahulu',
                                                            context,
                                                            duration: Toast
                                                                .LENGTH_LONG,
                                                            gravity:
                                                                Toast.BOTTOM,
                                                            backgroundColor:
                                                                Colors.red,
                                                          );
                                                        }
                                                      } else {
                                                        Toast.show(
                                                          'Pipeline sudah pencairan dan tidak bisa akad kredit kembali',
                                                          context,
                                                          duration:
                                                              Toast.LENGTH_LONG,
                                                          gravity: Toast.BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                        );
                                                      }
                                                    } else if (data
                                                            .dataPipeline[i]
                                                            .status ==
                                                        '4') {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => DisbursmentAddNewScreen(
                                                                  widget
                                                                      .username,
                                                                  widget.nik,
                                                                  '',
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .namaNasabah,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .alamat,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .telepon,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .pengelolaPensiun,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .akadProduk,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .tanggalAkad,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .tanggalAkad,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .nomorRekening,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .nomorPerjanjian,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .cabang,
                                                                  data.dataPipeline[i].statusKredit ==
                                                                          'TOP UP'
                                                                      ? data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .nominalTopUp
                                                                      : data
                                                                          .dataPipeline[
                                                                              i]
                                                                          .plafond,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .statusKredit,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .namaPetugasBank,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .kodeAO,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .teleponPetugasBank,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .pengelolaPensiun,
                                                                  data
                                                                      .dataPipeline[
                                                                          i]
                                                                      .id)));
                                                    } else {
                                                      null;
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data.dataPipeline[i]
                                                                    .status ==
                                                                '1'
                                                            ? 'Submit'
                                                            : data
                                                                        .dataPipeline[
                                                                            i]
                                                                        .status ==
                                                                    '3'
                                                                ? 'Akad Kredit'
                                                                : data.dataPipeline[i]
                                                                            .status ==
                                                                        '4'
                                                                    ? 'Pencairan'
                                                                    : '',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "LeadsGo-Font",
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Icon(
                                                        MdiIcons.arrowRight,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    });
  }

  Widget showSubmit() {
    return Consumer<PipelineSubmitProvider>(builder: (context, data, _) {
      print(data.dataPipeline.length);
      if (data.dataPipeline.length == 0) {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.grey, width: 2),
                //     borderRadius: BorderRadius.all(Radius.circular(123))),
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                MdiIcons.folderSyncOutline,
                size: 100,
                color: Colors.grey,
              ),
            )),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Data Submit Pipeline\nBelum Tersedia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "LeadsGo-Font",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ]),
        );
      } else {
        // SHOW SUBMIT DOKUMEN
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.dataPipeline.length,
            itemBuilder: (context, i) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 1,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PipelineViewScreen(
                                    data.dataPipeline[i].namaNasabah,
                                    data.dataPipeline[i].tglPipeline,
                                    data.dataPipeline[i].alamat,
                                    data.dataPipeline[i].telepon,
                                    data.dataPipeline[i].jenisProduk,
                                    data.dataPipeline[i].plafond,
                                    data.dataPipeline[i].cabang,
                                    data.dataPipeline[i].keterangan,
                                    data.dataPipeline[i].status,
                                    data.dataPipeline[i].tempatLahir,
                                    data.dataPipeline[i].tanggalLahir,
                                    data.dataPipeline[i].jenisKelamin,
                                    data.dataPipeline[i].noKtp,
                                    data.dataPipeline[i].noNip,
                                    data.dataPipeline[i].tglPenyerahan,
                                    data.dataPipeline[i].tanggalAkad,
                                    // data.dataPipeline[i]
                                    //     .npwp,
                                    data.dataPipeline[i].statusKredit,
                                    data.dataPipeline[i].pengelolaPensiun,
                                    data.dataPipeline[i].bankTakeover,
                                    data.dataPipeline[i].foto1,
                                    data.dataPipeline[i].fotoAkad1,
                                    data.dataPipeline[i].fotoAkad2,
                                    data.dataPipeline[i].fotoTandaTerima,

                                    data.dataPipeline[i].nomorRekening,
                                    data.dataPipeline[i].nomorPerjanjian,
                                    data.dataPipeline[i].nominalPinjaman,
                                    data.dataPipeline[i].finalOS,
                                    data.dataPipeline[i].nominalTopUp,

                                    data.dataPipeline[i].kodeAO,
                                    data.dataPipeline[i].namaPetugasBank,
                                    data.dataPipeline[i].teleponPetugasBank,
                                  )));
                    },
                    child: Container(
                      // padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
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
                                    color: colorStatus(
                                        '${data.dataPipeline[i].status}'),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  setSubNama(data.dataPipeline[i].namaNasabah),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    String teleponFix = '+62' +
                                        data.dataPipeline[i].telepon
                                            .substring(1);
                                    launchWhatsApp(
                                        phone: teleponFix,
                                        message: 'Hello ' +
                                            data.dataPipeline[i].namaNasabah +
                                            ',');
                                  },
                                  icon: Icon(
                                    MdiIcons.whatsapp,
                                  ),
                                  iconSize: 20,
                                  color: Colors.green,
                                ),
                                IconButton(
                                  onPressed: () {
                                    String teleponFix = '+62' +
                                        data.dataPipeline[i].telepon
                                            .substring(1);
                                    launch("tel:$teleponFix");
                                  },
                                  icon: Icon(
                                    MdiIcons.phone,
                                  ),
                                  iconSize: 20,
                                  color: Colors.blue,
                                ),
                                Wrap(
                                  spacing: 12,
                                  children: <Widget>[
                                    _showPopupMenu(
                                      data.dataPipeline[i].id.toString(),
                                      data.dataPipeline[i].namaNasabah
                                          .toString(),
                                      data.dataPipeline[i].noKtp.toString(),
                                      data.dataPipeline[i].noNip.toString(),
                                      data.dataPipeline[i].telepon.toString(),
                                      data.dataPipeline[i].plafond.toString(),
                                      data.dataPipeline[i].cabang.toString(),
                                      data.dataPipeline[i].tglPenyerahan
                                          .toString(),
                                      data.dataPipeline[i].namaPenerima
                                          .toString(),
                                      data.dataPipeline[i].teleponPenerima
                                          .toString(),
                                      data.dataPipeline[i].status,
                                      data.dataPipeline[i].fotoTandaTerima,
                                      data.dataPipeline[i].tanggalAkad,
                                      // data.dataPipeline[i]
                                      // .nomorAplikasi,
                                      data.dataPipeline[i].nomorRekening,
                                      data.dataPipeline[i].nomorPerjanjian,
                                      data.dataPipeline[i].nominalPinjaman,
                                      data.dataPipeline[i].finalOS,
                                      data.dataPipeline[i].nominalTopUp,
                                      // data.dataPipeline[i]
                                      //     .akadProduk,
                                      data.dataPipeline[i].jenisProduk,
                                      data.dataPipeline[i].salesInfo,
                                      data.dataPipeline[i].namaPetugasBank,
                                      // data.dataPipeline[i]
                                      //     .jabatanPetugasBank,
                                      data.dataPipeline[i].kodeAO,
                                      data.dataPipeline[i].teleponPetugasBank,
                                      data.dataPipeline[i].fotoAkad1,
                                      data.dataPipeline[i].fotoAkad2,
                                      data.dataPipeline[i].idKeterangan,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.black12,
                                    width: 80.0,
                                    height: 80.0,
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/cupertino_activity_indicator.gif',
                                      image:
                                          'https://tetranabasainovasi.com/marsit/${data.dataPipeline[i].foto1}',
                                      fit: BoxFit.cover,
                                    ),

                                    // Image.network(
                                    //   'https://tetranabasainovasi.com/marsit/${data.dataPipeline[i].foto1}',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 80.00,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              'KTP ${setKTP(data.dataPipeline[i].noKtp)}',
                                              // textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              MdiIcons.pound,
                                              size: 14,
                                              color: Colors.black54,
                                            ),
                                            Text(
                                              '${data.dataPipeline[i].pengelolaPensiun}',
                                              // textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 110,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
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
                                              '${data.dataPipeline[i].statusKredit}',
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
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
                                              data.dataPipeline[i]
                                                              .statusKredit ==
                                                          'TOP UP' &&
                                                      data.dataPipeline[i]
                                                              .status !=
                                                          '1' &&
                                                      data.dataPipeline[i]
                                                              .status !=
                                                          '3'
                                                  ? '${formatRupiah(data.dataPipeline[i].nominalTopUp)}'
                                                  : '${formatRupiah(data.dataPipeline[i].plafond)}',
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
                            data.dataPipeline[i].keluhan == 'KONDISI KOSONG'
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Container(
                                    // padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.grey,
                                    ))),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.black54,
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(30, 30),
                                          alignment: Alignment.centerLeft),
                                      onPressed: () {
                                        setState(() {
                                          selectedKeterangan =
                                              data.dataPipeline[i].idKeterangan;
                                        });
                                        if (data.dataPipeline[i].status !=
                                            '2') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Row(children: [
                                                Icon(
                                                  MdiIcons.tag,
                                                  color: leadsGoColor,
                                                  size: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Kondisi Pipeline',
                                                  style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                  ),
                                                ),
                                              ]),
                                              actions: <Widget>[
                                                FlatButton(
                                                  color: Colors.grey,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Batal',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'LeadsGo-Font',
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  color: leadsGoColor,
                                                  onPressed: () {
                                                    if (selectedKeterangan ==
                                                        null) {
                                                      Toast.show(
                                                        'Silahkan pilih kondisi pipeline terlebih dahulu...',
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_LONG,
                                                        gravity: Toast.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      simpanKeteranganPipeline(
                                                        selectedKeterangan,
                                                        data.dataPipeline[i].id
                                                            .toString(),
                                                      );
                                                    }
                                                  },
                                                  child: visiblex
                                                      ? CircularProgressIndicator(
                                                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        )
                                                      : Text(
                                                          'Simpan',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'LeadsGo-Font',
                                                          ),
                                                        ),
                                                ),
                                              ],
                                              content:
                                                  fieldKeteranganPipeline(),
                                            ),
                                          );
                                        } else {
                                          Toast.show(
                                            'Pipeline sudah pencairan dan tidak bisa ubah kondisi kembali',
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM,
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.tag,
                                            // color: leadsGoColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${data.dataPipeline[i].keluhan}',
                                            style: TextStyle(
                                              fontFamily: 'LeadsGo-Font',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          data.dataPipeline[i].status == '1'
                                              ? SizedBox()
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      MdiIcons
                                                          .chevronDownCircleOutline,
                                                      color: Colors.black54,
                                                      size: 14,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Pipeline : ${data.dataPipeline[i].tglPipeline}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          data.dataPipeline[i].status == '1'
                                              ? SizedBox()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .status ==
                                                                '4'
                                                            ? Colors.redAccent
                                                            : colorStatus(
                                                                '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          data.dataPipeline[i].status == '4'
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      MdiIcons.fileCheckOutline,
                                                      color: Colors.redAccent,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Submit : ${data.dataPipeline[i].tglPenyerahan}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          data.dataPipeline[i].status == '4'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                MdiIcons.calendarCheckOutline,
                                                color: colorStatus(
                                                    '${data.dataPipeline[i].status}'),
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data.dataPipeline[i].status ==
                                                        '1'
                                                    ? 'Input pipeline pada\ntanggal ${data.dataPipeline[i].tglPipeline}'
                                                    : data.dataPipeline[i]
                                                                .status ==
                                                            '3'
                                                        ? 'Telah penyerahan berkas\npada tanggal ${data.dataPipeline[i].tglPenyerahan}'
                                                        : data.dataPipeline[i]
                                                                    .status ==
                                                                '4'
                                                            ? 'Telah akad kredit pada\ntanggal ${data.dataPipeline[i].tanggalAkad}'
                                                            : '',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlatButton(
                                            color: leadsGoColor,
                                            onPressed: () {
                                              if (data.dataPipeline[i].status ==
                                                  '1') {
                                                if (data.dataPipeline[i]
                                                        .status ==
                                                    '2') {
                                                  Toast.show(
                                                    'Pipeline sudah pencairan dan tidak bisa submit dokumen kembali',
                                                    context,
                                                    duration: Toast.LENGTH_LONG,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                  );
                                                } else if (data.dataPipeline[i]
                                                            .status ==
                                                        '3' ||
                                                    data.dataPipeline[i]
                                                            .status ==
                                                        '4') {
                                                  Toast.show(
                                                    'Submit dokumen tidak bisa diulang',
                                                    context,
                                                    duration: Toast.LENGTH_LONG,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                  );
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => PipelineSubmitScreen(
                                                              widget.username,
                                                              widget.nik,
                                                              data.dataPipeline[i].id
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .namaNasabah
                                                                  .toString(),
                                                              data.dataPipeline[i].noKtp
                                                                  .toString(),
                                                              data.dataPipeline[i].noNip
                                                                  .toString(),
                                                              data.dataPipeline[i].telepon
                                                                  .toString(),
                                                              data.dataPipeline[i].plafond
                                                                  .toString(),
                                                              data.dataPipeline[i].cabang
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .tglPenyerahan
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .namaPenerima
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .teleponPenerima
                                                                  .toString(),
                                                              data.dataPipeline[i]
                                                                  .fotoTandaTerima)));
                                                }
                                              } else if (data
                                                      .dataPipeline[i].status ==
                                                  '3') {
                                                if (data.dataPipeline[i]
                                                        .status !=
                                                    '2') {
                                                  if (data.dataPipeline[i]
                                                              .status ==
                                                          '3' ||
                                                      data.dataPipeline[i]
                                                              .status ==
                                                          '4') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => PipelineAkadScreen(
                                                                '',
                                                                widget.username,
                                                                widget.nik,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .id,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .status,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .namaNasabah,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .noKtp,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .noNip,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .telepon,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .plafond,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .cabang,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .tglPenyerahan,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .namaPenerima,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .teleponPenerima,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .tanggalAkad,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nomorRekening,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nomorPerjanjian,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nominalPinjaman,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .finalOS,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nominalTopUp,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .jenisProduk,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .salesInfo,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .namaPetugasBank,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .kodeAO,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .teleponPetugasBank,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .fotoAkad1,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .fotoAkad2)));
                                                  } else {
                                                    Toast.show(
                                                      'Silahkan submit dokumen terlebih dahulu',
                                                      context,
                                                      duration:
                                                          Toast.LENGTH_LONG,
                                                      gravity: Toast.BOTTOM,
                                                      backgroundColor:
                                                          Colors.red,
                                                    );
                                                  }
                                                } else {
                                                  Toast.show(
                                                    'Pipeline sudah pencairan dan tidak bisa akad kredit kembali',
                                                    context,
                                                    duration: Toast.LENGTH_LONG,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                  );
                                                }
                                              } else if (data
                                                      .dataPipeline[i].status ==
                                                  '4') {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DisbursmentAddNewScreen(
                                                            widget.username,
                                                            widget.nik,
                                                            '',
                                                            data.dataPipeline[i]
                                                                .namaNasabah,
                                                            data.dataPipeline[i]
                                                                .alamat,
                                                            data.dataPipeline[i]
                                                                .telepon,
                                                            data.dataPipeline[i]
                                                                .pengelolaPensiun,
                                                            data.dataPipeline[i]
                                                                .akadProduk,
                                                            data.dataPipeline[i]
                                                                .tanggalAkad,
                                                            data.dataPipeline[i]
                                                                .tanggalAkad,
                                                            data.dataPipeline[i]
                                                                .nomorRekening,
                                                            data.dataPipeline[i]
                                                                .nomorPerjanjian,
                                                            data.dataPipeline[i]
                                                                .cabang,
                                                            data.dataPipeline[i]
                                                                        .statusKredit ==
                                                                    'TOP UP'
                                                                ? data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nominalTopUp
                                                                : data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .plafond,
                                                            data.dataPipeline[i]
                                                                .statusKredit,
                                                            data.dataPipeline[i]
                                                                .namaPetugasBank,
                                                            data.dataPipeline[i]
                                                                .kodeAO,
                                                            data.dataPipeline[i]
                                                                .teleponPetugasBank,
                                                            data.dataPipeline[i]
                                                                .pengelolaPensiun,
                                                            data.dataPipeline[i]
                                                                .id)));
                                              } else {
                                                null;
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  data.dataPipeline[i].status ==
                                                          '1'
                                                      ? 'Submit'
                                                      : data.dataPipeline[i]
                                                                  .status ==
                                                              '3'
                                                          ? 'Akad Kredit'
                                                          : data.dataPipeline[i]
                                                                      .status ==
                                                                  '4'
                                                              ? 'Pencairan'
                                                              : '',
                                                  style: TextStyle(
                                                    fontFamily: "LeadsGo-Font",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Icon(
                                                  MdiIcons.arrowRight,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    });
  }

  Widget showAkad() {
    return Consumer<PipelineAkadProvider>(builder: (context, data, _) {
      print(data.dataPipeline.length);
      if (data.dataPipeline.length == 0) {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  MdiIcons.folderSyncOutline,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Data Akad Kredit\nBelum Tersedia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "LeadsGo-Font",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ]),
        );
      } else {
        // SHOW AKAD KREDIT
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.dataPipeline.length,
            itemBuilder: (context, i) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 1,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PipelineViewScreen(
                                    data.dataPipeline[i].namaNasabah,
                                    data.dataPipeline[i].tglPipeline,
                                    data.dataPipeline[i].alamat,
                                    data.dataPipeline[i].telepon,
                                    data.dataPipeline[i].jenisProduk,
                                    data.dataPipeline[i].plafond,
                                    data.dataPipeline[i].cabang,
                                    data.dataPipeline[i].keterangan,
                                    data.dataPipeline[i].status,
                                    data.dataPipeline[i].tempatLahir,
                                    data.dataPipeline[i].tanggalLahir,
                                    data.dataPipeline[i].jenisKelamin,
                                    data.dataPipeline[i].noKtp,
                                    data.dataPipeline[i].noNip,
                                    data.dataPipeline[i].tglPenyerahan,
                                    data.dataPipeline[i].tanggalAkad,
                                    // data.dataPipeline[i]
                                    //     .npwp,
                                    data.dataPipeline[i].statusKredit,
                                    data.dataPipeline[i].pengelolaPensiun,
                                    data.dataPipeline[i].bankTakeover,
                                    data.dataPipeline[i].foto1,
                                    data.dataPipeline[i].fotoAkad1,
                                    data.dataPipeline[i].fotoAkad2,
                                    data.dataPipeline[i].fotoTandaTerima,

                                    data.dataPipeline[i].nomorRekening,
                                    data.dataPipeline[i].nomorPerjanjian,
                                    data.dataPipeline[i].nominalPinjaman,
                                    data.dataPipeline[i].finalOS,
                                    data.dataPipeline[i].nominalTopUp,

                                    data.dataPipeline[i].kodeAO,
                                    data.dataPipeline[i].namaPetugasBank,
                                    data.dataPipeline[i].teleponPetugasBank,
                                  )));
                    },
                    child: Container(
                      // padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
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
                                    color: colorStatus(
                                        '${data.dataPipeline[i].status}'),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  setSubNama(data.dataPipeline[i].namaNasabah),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LeadsGo-Font'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    String teleponFix = '+62' +
                                        data.dataPipeline[i].telepon
                                            .substring(1);
                                    launchWhatsApp(
                                        phone: teleponFix,
                                        message: 'Hello ' +
                                            data.dataPipeline[i].namaNasabah +
                                            ',');
                                  },
                                  icon: Icon(
                                    MdiIcons.whatsapp,
                                  ),
                                  iconSize: 20,
                                  color: Colors.green,
                                ),
                                IconButton(
                                  onPressed: () {
                                    String teleponFix = '+62' +
                                        data.dataPipeline[i].telepon
                                            .substring(1);
                                    launch("tel:$teleponFix");
                                  },
                                  icon: Icon(
                                    MdiIcons.phone,
                                  ),
                                  iconSize: 20,
                                  color: Colors.blue,
                                ),
                                Wrap(
                                  spacing: 12,
                                  children: <Widget>[
                                    _showPopupMenu(
                                      data.dataPipeline[i].id.toString(),
                                      data.dataPipeline[i].namaNasabah
                                          .toString(),
                                      data.dataPipeline[i].noKtp.toString(),
                                      data.dataPipeline[i].noNip.toString(),
                                      data.dataPipeline[i].telepon.toString(),
                                      data.dataPipeline[i].plafond.toString(),
                                      data.dataPipeline[i].cabang.toString(),
                                      data.dataPipeline[i].tglPenyerahan
                                          .toString(),
                                      data.dataPipeline[i].namaPenerima
                                          .toString(),
                                      data.dataPipeline[i].teleponPenerima
                                          .toString(),
                                      data.dataPipeline[i].status,
                                      data.dataPipeline[i].fotoTandaTerima,
                                      data.dataPipeline[i].tanggalAkad,
                                      // data.dataPipeline[i]
                                      // .nomorAplikasi,
                                      data.dataPipeline[i].nomorRekening,
                                      data.dataPipeline[i].nomorPerjanjian,
                                      data.dataPipeline[i].nominalPinjaman,
                                      data.dataPipeline[i].finalOS,
                                      data.dataPipeline[i].nominalTopUp,
                                      // data.dataPipeline[i]
                                      //     .akadProduk,
                                      data.dataPipeline[i].jenisProduk,
                                      data.dataPipeline[i].salesInfo,
                                      data.dataPipeline[i].namaPetugasBank,
                                      // data.dataPipeline[i]
                                      //     .jabatanPetugasBank,
                                      data.dataPipeline[i].kodeAO,
                                      data.dataPipeline[i].teleponPetugasBank,
                                      data.dataPipeline[i].fotoAkad1,
                                      data.dataPipeline[i].fotoAkad2,
                                      data.dataPipeline[i].idKeterangan,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.black12,
                                    width: 80.0,
                                    height: 80.0,
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/cupertino_activity_indicator.gif',
                                      image:
                                          'https://tetranabasainovasi.com/marsit/${data.dataPipeline[i].foto1}',
                                      fit: BoxFit.cover,
                                    ),
                                    // Image.network(
                                    //   'https://tetranabasainovasi.com/marsit/${data.dataPipeline[i].foto1}',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 80.00,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              'KTP ${setKTP(data.dataPipeline[i].noKtp)}',
                                              // textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              MdiIcons.pound,
                                              size: 14,
                                              color: Colors.black54,
                                            ),
                                            Text(
                                              '${data.dataPipeline[i].pengelolaPensiun}',
                                              // textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 110,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
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
                                              '${data.dataPipeline[i].statusKredit}',
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
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
                                              data.dataPipeline[i]
                                                              .statusKredit ==
                                                          'TOP UP' &&
                                                      data.dataPipeline[i]
                                                              .status !=
                                                          '1' &&
                                                      data.dataPipeline[i]
                                                              .status !=
                                                          '3'
                                                  ? '${formatRupiah(data.dataPipeline[i].nominalTopUp)}'
                                                  : '${formatRupiah(data.dataPipeline[i].plafond)}',
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
                            data.dataPipeline[i].keluhan == 'KONDISI KOSONG'
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Container(
                                    // padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.grey,
                                    ))),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.black54,
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(30, 30),
                                          alignment: Alignment.centerLeft),
                                      onPressed: () {
                                        setState(() {
                                          selectedKeterangan =
                                              data.dataPipeline[i].idKeterangan;
                                        });
                                        if (data.dataPipeline[i].status !=
                                            '2') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Row(children: [
                                                Icon(
                                                  MdiIcons.tag,
                                                  color: leadsGoColor,
                                                  size: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Kondisi Pipeline',
                                                  style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                  ),
                                                ),
                                              ]),
                                              actions: <Widget>[
                                                FlatButton(
                                                  color: Colors.grey,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Batal',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'LeadsGo-Font',
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  color: leadsGoColor,
                                                  onPressed: () {
                                                    if (selectedKeterangan ==
                                                        null) {
                                                      Toast.show(
                                                        'Silahkan pilih kondisi pipeline terlebih dahulu...',
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_LONG,
                                                        gravity: Toast.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      simpanKeteranganPipeline(
                                                        selectedKeterangan,
                                                        data.dataPipeline[i].id
                                                            .toString(),
                                                      );
                                                    }
                                                  },
                                                  child: visiblex
                                                      ? CircularProgressIndicator(
                                                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        )
                                                      : Text(
                                                          'Simpan',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'LeadsGo-Font',
                                                          ),
                                                        ),
                                                ),
                                              ],
                                              content:
                                                  fieldKeteranganPipeline(),
                                            ),
                                          );
                                        } else {
                                          Toast.show(
                                            'Pipeline sudah pencairan dan tidak bisa ubah kondisi kembali',
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM,
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.tag,
                                            // color: leadsGoColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${data.dataPipeline[i].keluhan}',
                                            style: TextStyle(
                                              fontFamily: 'LeadsGo-Font',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          data.dataPipeline[i].status == '1'
                                              ? SizedBox()
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      MdiIcons
                                                          .chevronDownCircleOutline,
                                                      color: Colors.black54,
                                                      size: 14,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Pipeline : ${data.dataPipeline[i].tglPipeline}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          data.dataPipeline[i].status == '1'
                                              ? SizedBox()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .status ==
                                                                '4'
                                                            ? Colors.redAccent
                                                            : colorStatus(
                                                                '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          data.dataPipeline[i].status == '4'
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      MdiIcons.fileCheckOutline,
                                                      color: Colors.redAccent,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Submit : ${data.dataPipeline[i].tglPenyerahan}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font',
                                                        color: Colors.black54,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          data.dataPipeline[i].status == '4'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}'),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                MdiIcons.calendarCheckOutline,
                                                color: colorStatus(
                                                    '${data.dataPipeline[i].status}'),
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data.dataPipeline[i].status ==
                                                        '1'
                                                    ? 'Input pipeline pada\ntanggal ${data.dataPipeline[i].tglPipeline}'
                                                    : data.dataPipeline[i]
                                                                .status ==
                                                            '3'
                                                        ? 'Telah penyerahan berkas\npada tanggal ${data.dataPipeline[i].tglPenyerahan}'
                                                        : data.dataPipeline[i]
                                                                    .status ==
                                                                '4'
                                                            ? 'Telah akad kredit pada\ntanggal ${data.dataPipeline[i].tanggalAkad}'
                                                            : '',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlatButton(
                                            color: leadsGoColor,
                                            onPressed: () {
                                              if (data.dataPipeline[i].status ==
                                                  '1') {
                                                if (data.dataPipeline[i]
                                                        .status ==
                                                    '2') {
                                                  Toast.show(
                                                    'Pipeline sudah pencairan dan tidak bisa submit dokumen kembali',
                                                    context,
                                                    duration: Toast.LENGTH_LONG,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                  );
                                                } else if (data.dataPipeline[i]
                                                            .status ==
                                                        '3' ||
                                                    data.dataPipeline[i]
                                                            .status ==
                                                        '4') {
                                                  Toast.show(
                                                    'Submit dokumen tidak bisa diulang',
                                                    context,
                                                    duration: Toast.LENGTH_LONG,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                  );
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => PipelineSubmitScreen(
                                                              widget.username,
                                                              widget.nik,
                                                              data.dataPipeline[i].id
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .namaNasabah
                                                                  .toString(),
                                                              data.dataPipeline[i].noKtp
                                                                  .toString(),
                                                              data.dataPipeline[i].noNip
                                                                  .toString(),
                                                              data.dataPipeline[i].telepon
                                                                  .toString(),
                                                              data.dataPipeline[i].plafond
                                                                  .toString(),
                                                              data.dataPipeline[i].cabang
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .tglPenyerahan
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .namaPenerima
                                                                  .toString(),
                                                              data
                                                                  .dataPipeline[
                                                                      i]
                                                                  .teleponPenerima
                                                                  .toString(),
                                                              data.dataPipeline[i]
                                                                  .fotoTandaTerima)));
                                                }
                                              } else if (data
                                                      .dataPipeline[i].status ==
                                                  '3') {
                                                if (data.dataPipeline[i]
                                                        .status !=
                                                    '2') {
                                                  if (data.dataPipeline[i]
                                                              .status ==
                                                          '3' ||
                                                      data.dataPipeline[i]
                                                              .status ==
                                                          '4') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => PipelineAkadScreen(
                                                                '',
                                                                widget.username,
                                                                widget.nik,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .id,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .status,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .namaNasabah,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .noKtp,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .noNip,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .telepon,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .plafond,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .cabang,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .tglPenyerahan,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .namaPenerima,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .teleponPenerima,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .tanggalAkad,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nomorRekening,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nomorPerjanjian,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nominalPinjaman,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .finalOS,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nominalTopUp,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .jenisProduk,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .salesInfo,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .namaPetugasBank,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .kodeAO,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .teleponPetugasBank,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .fotoAkad1,
                                                                data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .fotoAkad2)));
                                                  } else {
                                                    Toast.show(
                                                      'Silahkan submit dokumen terlebih dahulu',
                                                      context,
                                                      duration:
                                                          Toast.LENGTH_LONG,
                                                      gravity: Toast.BOTTOM,
                                                      backgroundColor:
                                                          Colors.red,
                                                    );
                                                  }
                                                } else {
                                                  Toast.show(
                                                    'Pipeline sudah pencairan dan tidak bisa akad kredit kembali',
                                                    context,
                                                    duration: Toast.LENGTH_LONG,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                  );
                                                }
                                              } else if (data
                                                      .dataPipeline[i].status ==
                                                  '4') {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DisbursmentAddNewScreen(
                                                            widget.username,
                                                            widget.nik,
                                                            '',
                                                            data.dataPipeline[i]
                                                                .namaNasabah,
                                                            data.dataPipeline[i]
                                                                .alamat,
                                                            data.dataPipeline[i]
                                                                .telepon,
                                                            data.dataPipeline[i]
                                                                .pengelolaPensiun,
                                                            data.dataPipeline[i]
                                                                .akadProduk,
                                                            data.dataPipeline[i]
                                                                .tanggalAkad,
                                                            data.dataPipeline[i]
                                                                .tanggalAkad,
                                                            data.dataPipeline[i]
                                                                .nomorRekening,
                                                            data.dataPipeline[i]
                                                                .nomorPerjanjian,
                                                            data.dataPipeline[i]
                                                                .cabang,
                                                            data.dataPipeline[i]
                                                                        .statusKredit ==
                                                                    'TOP UP'
                                                                ? data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .nominalTopUp
                                                                : data
                                                                    .dataPipeline[
                                                                        i]
                                                                    .plafond,
                                                            data.dataPipeline[i]
                                                                .statusKredit,
                                                            data.dataPipeline[i]
                                                                .namaPetugasBank,
                                                            data.dataPipeline[i]
                                                                .kodeAO,
                                                            data.dataPipeline[i]
                                                                .teleponPetugasBank,
                                                            data.dataPipeline[i]
                                                                .pengelolaPensiun,
                                                            data.dataPipeline[i]
                                                                .id)));
                                              } else {
                                                null;
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  data.dataPipeline[i].status ==
                                                          '1'
                                                      ? 'Submit'
                                                      : data.dataPipeline[i]
                                                                  .status ==
                                                              '3'
                                                          ? 'Akad Kredit'
                                                          : data.dataPipeline[i]
                                                                      .status ==
                                                                  '4'
                                                              ? 'Pencairan'
                                                              : '',
                                                  style: TextStyle(
                                                    fontFamily: "LeadsGo-Font",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Icon(
                                                  MdiIcons.arrowRight,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    });
  }
}
