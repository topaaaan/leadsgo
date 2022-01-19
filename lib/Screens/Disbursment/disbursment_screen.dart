import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_akad_screen.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_edit_new.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_akad.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentScreen extends StatefulWidget {
  @override
  _DisbursmentScreen createState() => _DisbursmentScreen();

  String username;
  String nik;
  String statusKaryawan;
  String personalData;

  DisbursmentScreen(
      this.username, this.nik, this.statusKaryawan, this.personalData);
}

class _DisbursmentScreen extends State<DisbursmentScreen> {
  bool visible = false;
  bool visiblex = false;
  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursment';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result =
        await http.post(Uri.parse(apiUrl), body: {'nik_sales': widget.nik});
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

  String _tanggalAkadX(dynamic user) {
    return user['tanggal_akad_x'];
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

  String _kodeTL(dynamic user) {
    return user['kode_tl'];
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

  // String _npwp(dynamic user) {
  //   return user['npwp'];
  // }

  String _noNip(dynamic user) {
    return user['no_nip'];
  }

  String _nominalOS(dynamic user) {
    return user['nominal_os_akhir'];
  }

  String _nominalTopUp(dynamic user) {
    return user['nominal_top_up'];
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

  var personalData = new List(38);

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
    var url =
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSmartLogin';

    //starting web api call
    int timeout = 30;
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12.withOpacity(0.6),
      builder: (BuildContext context) {
        dialogContext = context;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
              ),
            ),
          ],
        );
      },
    );

    try {
      var response = await http.post(Uri.parse(url),
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

  Future deleteDisbursment(String id, String idPipeline, String noAkad) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/deleteDisbursment');
    var response = await http.post(url, body: {
      'id_disbursment': id,
      'id_pipeline': idPipeline,
      'no_akad': noAkad
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Disbursment'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses hapus pencairan',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        userLogin();
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal hapus pencairan',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  setAksesEdit(String tglPencairan, String tglCutOff) {
    final a = DateTimeFormat.format(DateTime.parse(tglPencairan), format: 'U');
    final b = DateTimeFormat.format(DateTime.parse(tglCutOff), format: 'U');
    if (int.parse(a) > int.parse(b)) {
      return false;
    } else {
      return true;
    }
  }

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
                  'Apakah anda ingin keluar dari menu pencairan?',
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Button pressed!');
        final shouldPop = await _onBackPressed(context);
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: grey,
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Semua Pencairan',
              style: fontFamily,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  MdiIcons.helpCircleOutline,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  Toast.show('Pencairan Kredit ' + bulan + ' ' + tahun, context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.TOP,
                      backgroundColor: Colors.white,
                      textColor: leadsGoColor);
                },
              )
            ],
          ),
          body: Container(
            color: Color(0xfff3f3f3),
            child: _buildList(),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Tambah Pencairan',
            backgroundColor: leadsGoColor,
            child: Icon(
              MdiIcons.plus,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DisbursmentAkadScreen(widget.username, widget.nik)));
            },
          ),
        ),
      ),
    );
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

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
        color: leadsGoColor,
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          color: leadsGoColor,
          // LIST
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
                                _nominalOS(_users[index]),
                                _jenisPencairan(_users[index]),
                                setJenisProdukLTR(_jenisProduk(_users[index])),
                                _cabang(_users[index]),
                                _infoSales(_users[index]),
                                _foto1(_users[index]),
                                _foto2(_users[index]),
                                _foto3(_users[index]),
                                _tanggalPencairan(_users[index]),
                                _jamPencairan(_users[index]),
                                _namaTl(_users[index]),
                                _kodeTL(_users[index]),
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
                                _noNip(_users[index]),
                                // _nominalOS(_users[index]),
                                // _nominalTopUp(_users[index]),
                                _kodeProduk(_users[index]),
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
                            // Row(
                            //   children: [
                            //     IconButton(
                            //       onPressed: () {
                            //         String teleponFix =
                            //             '+62' + _telepon(_users[index]).substring(1);
                            //         launchWhatsApp(
                            //             phone: teleponFix,
                            //             message: 'Hello ' + _debitur(_users[index]) + ',');
                            //       },
                            //       icon: Icon(
                            //         MdiIcons.whatsapp,
                            //       ),
                            //       iconSize: 20,
                            //       color: Colors.green,
                            //     ),
                            //     IconButton(
                            //       onPressed: () {
                            //         String teleponFix =
                            //             '+62' + _telepon(_users[index]).substring(1);
                            //         launch("tel:$teleponFix");
                            //       },
                            //       icon: Icon(
                            //         MdiIcons.phone,
                            //       ),
                            //       iconSize: 20,
                            //       color: Colors.blue,
                            //     ),
                            //   ],
                            // ),
                            InkWell(
                              onTap: () {
                                if ((widget.statusKaryawan !=
                                            'MARKETING AGEN' &&
                                        _statusPencairan(_users[index]) !=
                                            'success') ||
                                    (widget.statusKaryawan ==
                                            'MARKETING AGEN' &&
                                        _approvalSl(_users[index]) != '4')) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Apakah Anda ingin menghapus pencairan debitur ' +
                                            _debitur(_users[index]) +
                                            ' ?',
                                        style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.bold,
                                          color: leadsGoColor,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                deleteDisbursment(
                                                    _id(_users[index]),
                                                    _idPipeline(_users[index]),
                                                    _nomorAkad(_users[index]));
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
                                    'Pencairan ' +
                                        messageStatus(
                                            _statusPencairan(_users[index]),
                                            widget.statusKaryawan,
                                            _approvalSl(_users[index])) +
                                        ', data tidak bisa di hapus kembali',
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER,
                                    backgroundColor: Colors.red,
                                  );
                                }
                              },
                              child: Container(
                                // decoration: BoxDecoration(
                                //     color: Colors,
                                //     borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    MdiIcons.delete,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                ),
                              ),
                            )
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
                                    child: Image.network(
                                      'https://tetranabasainovasi.com/marsit/${_foto3(_users[index])}',
                                      fit: BoxFit.cover,
                                    ),
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
                                            Icon(
                                              MdiIcons.informationOutline,
                                              size: 16,
                                              color: leadsGoColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              messageStatus(
                                                  _statusPencairan(
                                                      _users[index]),
                                                  widget.statusKaryawan,
                                                  _approvalSl(_users[index])),
                                              // textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: leadsGoColor,
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
                                              _tanggalPencairan(_users[index]),
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
                                              _statusKredit(_users[index]),
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
                                              formatRupiah(
                                                  _plafond(_users[index])),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //TRACKING PIPELINE
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                MdiIcons
                                                    .chevronDownCircleOutline,
                                                color: Colors.black54,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                ' Akad ${_tanggalAkad(_users[index])}',
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  color: Colors.black54,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 9,
                                            ),
                                            height: 15,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: Colors.green,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                MdiIcons.calendarCheckOutline,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Telah melakukan pencairan\npada tanggal ${_tanggalPencairan(_users[index])}',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // BUTTON LANJUT
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 3, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FlatButton(
                                    color: Colors.grey,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PipelineAkadScreen(
                                                    _id(_users[index]),
                                                    widget.username,
                                                    // '',
                                                    widget.nik,
                                                    // '',
                                                    _idPipeline(_users[index]),
                                                    // '',
                                                    _statusPipeline(
                                                        _users[index]),
                                                    // '',
                                                    _debitur(_users[index]),
                                                    // '',
                                                    _noKtp(_users[index]),
                                                    // '',
                                                    _noNip(_users[index]),
                                                    // '',
                                                    _telepon(_users[index]),
                                                    // '',
                                                    _nominal(_users[index]),
                                                    // '',
                                                    _cabang(_users[index]),
                                                    // '1',
                                                    _tanggalPenyerahan(
                                                        _users[index]),
                                                    // '1',
                                                    _namaTl(_users[index]),
                                                    // '1',
                                                    _teleponTl(_users[index]),
                                                    // '1',
                                                    _tanggalAkadX(
                                                        _users[index]),
                                                    // '1',
                                                    _nomorAkad(_users[index]),
                                                    // '1',
                                                    _noJanji(_users[index]),
                                                    // '1',
                                                    _nominal(_users[index]),
                                                    // '1',
                                                    _nominalOS(_users[index]),
                                                    // '1',
                                                    _nominalTopUp(
                                                        _users[index]),
                                                    // '1',
                                                    setJenisProdukLTR(
                                                        _jenisProduk(
                                                            _users[index])),
                                                    // '3',
                                                    _infoSales(_users[index]),
                                                    // '1',
                                                    _namaTl(_users[index]),
                                                    // '1',
                                                    _kodeTL(_users[index]),
                                                    // '1',
                                                    _teleponTl(_users[index]),
                                                    // '1',
                                                    _foto1(_users[index]),
                                                    // '1',
                                                    _foto2(_users[index]),
                                                    // '1',
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          MdiIcons.pencil,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Ubah Data Akad',
                                          style: TextStyle(
                                            fontFamily: "LeadsGo-Font",
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FlatButton(
                                    color: leadsGoColor,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DisbursmentEditNewScreen(
                                            widget.username,
                                            widget.nik,
                                            '',
                                            _debitur(_users[index]),
                                            _alamat(_users[index]),
                                            _telepon(_users[index]),
                                            _tanggalAkad(_users[index]),
                                            _jenisProduk(_users[index]),
                                            _tanggalAkad(_users[index]),
                                            _nomorAkad(_users[index]),
                                            _noJanji(_users[index]),
                                            _cabang(_users[index]),
                                            _plafond(_users[index]),
                                            _infoSales(_users[index]),
                                            _statusKredit(_users[index]),
                                            _namaTl(_users[index]),
                                            _kodeTL(_users[index]),
                                            _teleponTl(_users[index]),
                                            _pengelolaPensiun(_users[index]),
                                            _idPipeline(_users[index]),
                                            // PENCAIRAN YANG DI EDIT
                                            _tanggalPencairan(_users[index]),
                                            _foto3(_users[index]),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          MdiIcons.pencil,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Ubah Pencairan',
                                          style: TextStyle(
                                            fontFamily: "LeadsGo-Font",
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Pencairan Kredit Yuk!',
              style: TextStyle(
                  fontFamily: "LeadsGo-Font",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dapatkan insentif besar dari pencairanmu.',
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DisbursmentAkadScreen(widget.username, widget.nik)));
              },
              child: Text(
                'Lihat Akad Kredit',
                style: TextStyle(
                  fontFamily: "LeadsGo-Font",
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        );
      }
    }
  }

  messageStatus(String status, String statusKaryawan, String bayar) {
    if (status == 'waiting') {
      return 'Menunggu Sales Leader';
    } else if (status == 'success') {
      if (statusKaryawan == 'MARKETING AGENT') {
        if (bayar == '4') {
          return 'Sudah dibayarkan';
        } else {
          return 'Disetujui Sales Leader';
        }
      } else {
        return 'Disetujui Sales Leader';
      }
    } else if (status == 'failed') {
      return 'Ditolak Sales Leader ';
    } else {
      return 'Menunggu Sales Leader';
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

  setNull(String data) {
    if (data == null || data == '') {
      return '-';
    } else {
      return data;
    }
  }

  setJenisProdukLTR(String produk) {
    switch (produk) {
      case "Pegawai Aktif PNS / TNI / POLRI":
        return '1';
        break;
      case "Prapensiun":
        return '2';
        break;
      case "Pensiun":
        return '3';
        break;
      case "Kredit Insidentil":
        return '4';
        break;
      case "Kredit Platinum 74 (BTPN)":
        return '5';
        break;
      case "Kredit Platinum 74 (BJB)":
        return '6';
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
    return 'Rp ' + fmf.output.withoutFractionDigits;
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
}
