import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';

class InteractionAddScreen extends StatefulWidget {
  String username;
  String nik;
  String namaNasabah;
  String alamatNasabah;
  String emailNasabah;
  String teleponNasabah;
  String title;
  String kelurahan;
  String kecamatan;
  String propinsi;
  String kotakab;
  String notas;

  InteractionAddScreen(
      this.username,
      this.nik,
      this.namaNasabah,
      this.alamatNasabah,
      this.emailNasabah,
      this.teleponNasabah,
      this.title,
      this.kelurahan,
      this.kecamatan,
      this.propinsi,
      this.kotakab,
      this.notas);
  @override
  _InteractionAddScreen createState() => _InteractionAddScreen();
}

class _InteractionAddScreen extends State<InteractionAddScreen> {
  void initState() {
    super.initState();
    setState(() {
      codeReady = false;
      namaPensiunController.text = widget.namaNasabah;
      alamatController.text = widget.alamatNasabah;
      kelurahanController.text = widget.kelurahan;
      kecamatanController.text = widget.kecamatan;
      kotakabController.text = widget.kotakab;
      propinsiController.text = widget.propinsi;
      emailController.text = widget.emailNasabah;
      teleponController.text = widget.teleponNasabah;
    });
  }

  String kodeOtp;
  String namaPensiun;
  String alamat;
  String kelurahan;
  String kecamatan;
  String kotakab;
  String propinsi;
  String email;
  String telepon;
  String otp;
  String rencanaPinjaman;
  String salesFeedback;
  var selectedSalesFeedback;
  List<String> _jenisSalesFeedbackType = <String>[
    'SUDAH PINDAH BANK / KANTOR BAYAR',
    'MASIH MEMILIKI PINJAMAN DI BANK LAIN',
    'MASIH MEMILIKI PINJAMAN DI KOPERASI LAIN',
    'MENUNGGU PINJAMAN LUNAS TERLEBIH DAHULU',
    'BELUM ADA PINJAMAN DI BANK LAIN',
    'MAU TAKEOVER PINJAMAN',
    'PENSIUNAN BERMINAT UNTUK MEMINJAM',
    'MASIH MAU MENANYAKAN KELUARGA INTI',
  ];
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final String uploadEndPoint =
  //     'https://tetranabasainovasi.com/api_marsit_v1/service.php/saveInteraction';
  // @.1.0.5

  Future<XFile> file;
  String status = '';
  String base64Image;
  String base64Image1;
  XFile tmpFile;
  XFile tmpFile1;
  String errMessage = 'Error Uploading Image';
  bool _loading = false;
  bool _loadingOtp = false;
  var hasil;
  var personalData = new List(38);

  final namaPensiunController = TextEditingController();
  final alamatController = TextEditingController();
  final kelurahanController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kotakabController = TextEditingController();
  final propinsiController = TextEditingController();
  final emailController = TextEditingController();
  final teleponController = TextEditingController();
  final otpController = TextEditingController();
  final rencanaPinjamanController = TextEditingController();
  final salesFeedbackController = TextEditingController();

  void _openCamera() async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      tmpFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openGallery() async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      tmpFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera1() async {
    var picture1 = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      tmpFile1 = picture1;
    });
    Navigator.of(context).pop();
  }

  void _openGallery1() async {
    var picture1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      tmpFile1 = picture1;
    });
    Navigator.of(context).pop();
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
              personalData[36] = message['rating'];
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

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Pilih Foto Interaksi',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'LeadsGo-Font',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () => {_openCamera()},
                    color: leadsGoColor,
                    padding: EdgeInsets.all(10.0),
                    textColor: Colors.white,
                    splashColor: Colors.deepPurple,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MdiIcons.camera,
                          size: 30,
                        ),
                        Text(
                          'Camera',
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () => {_openGallery()},
                    color: Colors.deepPurple,
                    padding: EdgeInsets.all(10.0),
                    textColor: Colors.white,
                    splashColor: leadsGoColor,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MdiIcons.image,
                          size: 30,
                        ),
                        Text(
                          'Gallery',
                        )
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   child: Text('Gallery'),
                  //   onTap: () {
                  //     _openGallery();
                  //   },
                  // ),
                  // Padding(padding: EdgeInsets.all(8.0)),
                  // GestureDetector(
                  //     child: Text('Camera'),
                  //     onTap: () {
                  //       _openCamera();
                  //     })
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Pilih Foto KTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'LeadsGo-Font',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () => {_openCamera1()},
                    color: leadsGoColor,
                    padding: EdgeInsets.all(10.0),
                    textColor: Colors.white,
                    splashColor: Colors.deepPurple,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MdiIcons.camera,
                          size: 30,
                        ),
                        Text(
                          'Camera',
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () => {_openGallery1()},
                    color: Colors.deepPurple,
                    padding: EdgeInsets.all(10.0),
                    textColor: Colors.white,
                    splashColor: leadsGoColor,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MdiIcons.image,
                          size: 30,
                        ),
                        Text(
                          'Gallery',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    String fileName = tmpFile.path.split('/').last;
    String fileName1 = tmpFile1.path.split('/').last;
    //print(fileName1);
    upload(fileName, fileName1);
  }

  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = 30;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool codeReady;
  Future requestOtp() async {
    setState(() {
      codeReady = false;
      _loadingOtp = true;
    });
    //server login api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/sendOtp');
    telepon = teleponController.text;
    //starting web api call
    var response = await http
        .post(url, body: {'telepon': telepon, 'nik_sales': widget.nik});
    if (telepon == '' || telepon == null) {
      setState(() {
        codeReady = false;
        _loadingOtp = false;
      });
      Toast.show(
        'No telepon wajib diisi terlebih dahulu',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Save_Otp'];
        print(message);
        if (message['message'].toString() == 'Otp Success') {
          setState(() {
            codeReady = true;
            _loadingOtp = false;
            kodeOtp = message['kode_otp'];
          });
          // Toast.show(
          //   'Kode verifikasi berhasil dikirim ke nomor nasabah, mohon ditanyakan ya',
          //   context,
          //   duration: Toast.LENGTH_LONG,
          //   gravity: Toast.BOTTOM,
          //   backgroundColor: Colors.green,
          // );
        }
      }
    }
  }

  Future upload(String fileName, String fileName1) async {
    //getting value from controller
    namaPensiun = namaPensiunController.text;
    alamat = alamatController.text;
    propinsi = propinsiController.text;
    kotakab = kotakabController.text;
    kecamatan = kecamatanController.text;
    kelurahan = kelurahanController.text;
    email = emailController.text;
    telepon = teleponController.text;
    otp = otpController.text;
    rencanaPinjaman = rencanaPinjamanController.text;
    salesFeedback = salesFeedbackController.text;

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
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/saveInteractionAddCashNew');

    // try {
    var result = await http.post(url, body: {
      "niksales": widget.nik,
      "image": base64Image,
      "name": fileName,
      "image1": base64Image1,
      "name1": fileName1,
      "file_name": "interaksi",
      "nama_pensiun": namaPensiun,
      "alamat": alamat,
      "provinsi": propinsi,
      "kota_kab": kotakab,
      "kecamatan": kecamatan,
      "kelurahan": kelurahan,
      "email": email,
      "telepon": telepon,
      "otp": otp,
      "rencana_pinjaman": rencanaPinjaman,
      // "sales_feedback": selectedSalesFeedback.toString(),
      "sales_feedback": salesFeedback,
      "notas": widget.notas
    }).catchError((e) {});
    //.timeout(Duration(seconds: 30));

    if (result.statusCode == 200) {
      // Navigator.pop(dialogContext);
      var message = jsonDecode(result.body)['status'];
      print(message);
      if (message == 'error') {
        Navigator.pop(dialogContext);
        alertUpload('GAGAL',
            'Gagal menambahkan data interaksi, mohon ulangi beberapa saat lagi.');
      } else if (message == 'Nomor Telepon') {
        Navigator.pop(dialogContext);
        alertUpload('GAGAL',
            'Nomor telepon sudah terdaftar, mohon masukkan nomor telepon lain.');
        setState(() {
          _loading = false;
          print(message);
        });
      } else if (message == 'Melebihi') {
        Navigator.pop(dialogContext);
        alertUpload('GAGAL',
            'Anda sudah 50x interaksi bulan ini, silahkan interaksi kembali bulan besok.');
        setState(() {
          _loading = false;
          print(message);
        });
      } else {
        Navigator.pop(dialogContext, false);
        alertUpload('SUKSES', 'Berhasil menambahkan data interaksi');
        setStatus(jsonDecode(result.body)['status']);
        setState(() {
          _loading = false;
          hasil = result.body;
          tmpFile = null;
          namaPensiunController.clear();
          alamatController.clear();
          kelurahanController.clear();
          kecamatanController.clear();
          kotakabController.clear();
          propinsiController.clear();
          emailController.clear();
          teleponController.clear();
          otpController.clear();
          rencanaPinjamanController.clear();
          selectedSalesFeedback = null;
        });
        userLogin();
      }
    } else {
      Navigator.pop(dialogContext);
      alertUpload('GAGAL',
          'Gagal menambahkan data interaksi, mohon ulangi beberapa saat lagi.');
      setState(() {
        _loading = false;
      });
    }
    // } on TimeoutException catch (e) {
    //   print('Time Out : $e');
    //   Navigator.pop(dialogContext);
    //   alertUpload('GAGAL',
    //       'Gagal menambahkan data interaksi, mohon ulangi beberapa saat lagi.');
    //   setState(() {
    //     _loading = false;
    //   });
    // } on Error catch (e) {
    //   print('General Error : $e');
    //   Navigator.pop(dialogContext);
    //   alertUpload('GAGAL',
    //       'Gagal menambahkan data interaksi, mohon ulangi beberapa saat lagi.');
    //   setState(() {
    //     _loading = false;
    //   });
    // }
  }

  Future alertUpload(String status, String messages) {
    String dd = DateFormat("dd").format(DateTime.now());
    String mm = bulan;
    // namaBulan(DateFormat("MM").format(DateTime.now())).substring(0, 3);
    String yyyy = DateFormat("yyyy").format(DateTime.now());
    String timeNow = DateFormat("HH:mm").format(DateTime.now());

    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: status == 'SUKSES'
                        ? Icon(
                            MdiIcons.checkCircleOutline,
                            color: Colors.green,
                            size: 60.0,
                          )
                        : Icon(
                            MdiIcons.closeCircleOutline,
                            color: Colors.red,
                            size: 60.0,
                          ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      status == 'SUKSES' ? 'Berhasil' : 'Gagal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.3,
                        letterSpacing: 0.30,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.bold,
                        color: status == 'SUKSES' ? Colors.green : Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      '$dd $mm $yyyy, $timeNow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.4,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      messages,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.30,
                        fontFamily: 'LeadsGo-Font',
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context, false);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 30)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(123),
                        side: BorderSide(
                            color:
                                status == 'SUKSES' ? Colors.green : Colors.red,
                            width: 1.8),
                      ),
                    ),
                  ),
                  child: Text(
                    'Tutup',
                    style: TextStyle(
                      color: status == 'SUKSES' ? Colors.green : Colors.red,
                      fontFamily: 'LeadsGo-Font',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _decideImageView() {
    if (tmpFile == null) {
      return InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(
              color: leadsGoColor,
              width: 2,
            ),
          ),
          height: 100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.camera, color: leadsGoColor, size: 40),
              Text(
                'Selfie dgn Caldeb (memakai ID Card ASN)',
                style: TextStyle(
                  color: leadsGoColor,
                  fontFamily: 'LeadsGo-Font',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          _loading
              ? Toast.show(
                  'Mohon menunggu, sedang proses penyimpanan interaksi',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.red,
                )
              : _showChoiceDialog(context);
        },
      );
    } else {
      base64Image = base64Encode(File(tmpFile.path).readAsBytesSync());
      tmpFile = tmpFile;
      // return Row(
      //   children: [
      //     Flexible(
      //         child: Image.file(
      //       File(tmpFile.path),
      //       fit: BoxFit.fill,
      //     ))
      //   ],
      // );
      return Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            border: Border.all(
              color: leadsGoColor,
              width: 2,
            ),
            image: DecorationImage(
              image: AssetImage("assets/bg-cloud.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: 350,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Container(
                  // width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Image.file(
                    File(tmpFile.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      tmpFile = null;
                    });
                  },
                  icon: Icon(MdiIcons.closeCircleOutline),
                  iconSize: 30,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ));
    }
  }

  Widget _decideImageView1() {
    if (tmpFile1 == null) {
      return InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(
              color: leadsGoColor,
              width: 2,
            ),
          ),
          height: 100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.camera, color: leadsGoColor, size: 40),
              Text(
                'Foto KTP/Karpeg Calon Debitur',
                style: TextStyle(
                  color: leadsGoColor,
                  fontFamily: 'LeadsGo-Font',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          _loading
              ? Toast.show(
                  'Mohon menunggu, sedang proses penyimpanan interaksi',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.red,
                )
              : _showChoiceDialog1(context);
        },
      );
    } else {
      base64Image1 = base64Encode(File(tmpFile1.path).readAsBytesSync());
      tmpFile1 = tmpFile1;
      return Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            border: Border.all(
              color: leadsGoColor,
              width: 2,
            ),
            image: DecorationImage(
              image: AssetImage("assets/bg-cloud.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: 350,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.file(
                    File(tmpFile1.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      tmpFile1 = null;
                    });
                  },
                  icon: Icon(MdiIcons.closeCircleOutline),
                  iconSize: 30,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _loading
              ? Toast.show(
                  'Mohon menunggu, sedang proses penyimpanan interaksi',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.red,
                )
              : Navigator.of(context).pop();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: grey,
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: leadsGoColor,
              title: Text(
                'Laporan Interaksi',
                style: TextStyle(
                  fontFamily: 'LeadsGo-Font',
                ),
              ),
            ),
            body: Container(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: ListView(
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Text(
                          'Info Calon Debitur',
                          style: TextStyle(
                            color: leadsGoColor,
                            letterSpacing: 0.5,
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fieldDebitur(),
                        fieldAlamat(),
                        fieldKelurahan(),
                        fieldKecamatan(),
                        fieldKotakab(),
                        fieldPropinsi(),
                        // fieldEmail(),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Rencana Pinjaman',
                          style: TextStyle(
                            color: leadsGoColor,
                            letterSpacing: 0.5,
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fieldRencanaPinjaman(),
                        fieldSalesFeedbackString(),
                        // fieldSalesFeedback(),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Konfirmasi Calon Debitur',
                          style: TextStyle(
                            color: leadsGoColor,
                            letterSpacing: 0.5,
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: fieldTelepon(),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              child: Center(
                                child: _start == 30
                                    ? FlatButton(
                                        color: leadsGoColor,
                                        child: Text(
                                          'Kirim Kode Verifikasi',
                                          style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_start == 30) {
                                            startTimer();
                                            requestOtp();
                                          } else {
                                            print('belum siap');
                                          }
                                        },
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Belum terima kode?",
                                              style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Tunggu $_start detik lagi",
                                              style: TextStyle(
                                                letterSpacing: 0.4,
                                                fontFamily: 'LeadsGo-Font',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.0,
                                                color: leadsGoColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        codeReady == true
                            ? Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Kode Verifikasi Telah Dikirim',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'LeadsGo-Font',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Cek Kodenya dalam SMS yang masuk di nomor',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'LeadsGo-Font',
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            '${teleponController.text}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 0.5,
                                              fontFamily: 'LeadsGo-Font',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Masukkan kode verifikasinya di bawah ini',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'LeadsGo-Font',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    fieldOTP(),
                                  ],
                                ),
                              )
                            : SizedBox(),

                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Bukti Dokumentasi Interaksi',
                          style: TextStyle(
                            color: leadsGoColor,
                            letterSpacing: 0.5,
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _decideImageView(),
                        SizedBox(
                          height: 10,
                        ),
                        _decideImageView1(),
                        SizedBox(
                          height: 80,
                        ),
                      ]),
                )),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     _loading
            //         ? Toast.show(
            //             'Mohon menunggu, sedang proses penyimpanan interaksi',
            //             context,
            //             duration: Toast.LENGTH_LONG,
            //             gravity: Toast.BOTTOM,
            //             backgroundColor: Colors.red,
            //           )
            //         : _showChoiceDialog(context);
            //   },
            //   backgroundColor: leadsGoColor,
            //   child: new Icon(Icons.camera_alt),
            // ),
            bottomSheet: codeReady == true
                ? Container(
                    padding: EdgeInsets.symmetric(
                      // horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 3, 16, 0),
                            child: FlatButton(
                              height: 46,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(123),
                              ),
                              color: leadsGoColor,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'SIMPAN',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        letterSpacing: 0.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  // if (selectedSalesFeedback == null) {
                                  //   _scaffoldKey.currentState
                                  //       .showSnackBar(SnackBar(
                                  //     content:
                                  //         Text('Mohon pilih sales feedback...'),
                                  //     duration: Duration(seconds: 5),
                                  //   ));
                                  // } else
                                  if (tmpFile == null) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Mohon pilih foto selfie/KTP...'),
                                      duration: Duration(seconds: 5),
                                    ));
                                  } else if (otpController.text != kodeOtp) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Mohon isi kode verifikasi dengan benar...'),
                                      duration: Duration(seconds: 5),
                                    ));
                                  } else {
                                    setState(() {
                                      _loading = true;
                                    });

                                    startUpload();
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ));
  }

  Widget fieldDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Calon debitur wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Calon debitur'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldAlamat() {
    return TextFormField(
      controller: alamatController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Alamat wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Alamat'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKelurahan() {
    return TextFormField(
      controller: kelurahanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kelurahan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kelurahan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKecamatan() {
    return TextFormField(
      controller: kecamatanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kecamatan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kecamatan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKotakab() {
    return TextFormField(
      controller: kotakabController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kabupaten wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kabupaten'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldPropinsi() {
    return TextFormField(
      controller: propinsiController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Propinsi wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Propinsi'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldEmail() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: 'Email'),
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No telepon minimal 10 angka...';
        } else if (value.length > 13) {
          return 'No telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'No. Telepon (Handphone)'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldOTP() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: otpController,
        decoration: InputDecoration(
          // errorText: otpController.text.isEmpty
          //     ? 'Kode verifikasi wajib diisi!'
          //     : otpController.text.length < 4
          //         ? 'Kode verifikasi minimal 4 angka!'
          //         : otpController.text.length > 4
          //             ? 'Kode verifikasi maksimal 4 angka!'
          //             : null,
          contentPadding: EdgeInsets.all(16),
          //Add th Hint text here.
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
            borderRadius: BorderRadius.circular(123.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: leadsGoColor, width: 1.5),
            borderRadius: BorderRadius.circular(123.0),
          ),
          // hintText: "____",
          hintStyle:
              TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black45),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1.0),
            borderRadius: BorderRadius.circular(123.0),
          ),
          // prefixIcon: Icon(
          //   MdiIcons.codeBraces,
          //   color: leadsGoColor,
          // ),
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: leadsGoColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 12),
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
    );
    // return TextFormField(
    //   controller: otpController,
    //   validator: (value) {
    //     if (value.isEmpty) {
    //       return 'Kode verifikasi wajib diisi...';
    //     } else if (value.length < 4) {
    //       return 'Kode verifikasi minimal 4 angka...';
    //     } else if (value.length > 4) {
    //       return 'Kode verifikasi maksimal 4 angka...';
    //     }
    //     return null;
    //   },
    //   decoration: InputDecoration(labelText: 'Masukkan Kode Verifikasinya'),
    //   keyboardType: TextInputType.number,
    //   inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
    //   style: TextStyle(fontFamily: 'LeadsGo-Font'),
    // );
  }

  Widget fieldRencanaPinjaman() {
    return TextFormField(
      controller: rencanaPinjamanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nominal pinjaman wajib diisi...';
        }
        // else if (value.length < 7) {
        //   return 'Nominal pinjaman minimal 7 angka...';
        // } else if (value.length > 9) {
        //   return 'Nominal pinjaman maksimal 9 angka...';
        // }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nominal Rencana Pinjaman'),
      keyboardType: TextInputType.number,
      inputFormatters: [DecimalFormatter()],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldSalesFeedbackString() {
    return TextFormField(
      controller: salesFeedbackController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Sales Feedback wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Isi apa hasil pertemuan dan prospek kamu tadi ?'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldSalesFeedback() {
    return DropdownButtonFormField(
        items: _jenisSalesFeedbackType
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
        onChanged: (selectedSalesFeedbackType) {
          setState(() {
            selectedSalesFeedback = selectedSalesFeedbackType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Sales Feedback',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedSalesFeedback,
        isExpanded: true);
  }
}

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9\.]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > this.decimalDigits)) {
        return oldValue;
      } else
        return newValue;
    }

    //in case if input is empty or zero
    if (newText.trim() == '' || newText.trim() == '0') {
      return newValue.copyWith(text: '');
    } else if (int.parse(newText) < 1) {
      return newValue.copyWith(text: '');
    }

    double newDouble = double.parse(newText);
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = NumberFormat("#,##0.##").format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
