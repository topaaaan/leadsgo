import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:toast/toast.dart';

class InteractionAddScreen extends StatefulWidget {
  String username;
  String nik;

  InteractionAddScreen(this.username, this.nik);
  @override
  _InteractionAddScreen createState() => _InteractionAddScreen();
}

class _InteractionAddScreen extends State<InteractionAddScreen> {
  String kodeOtp;
  String namaPensiun;
  String alamat;
  String email;
  String telepon;
  String otp;
  var selectedSalesFeedback;
  List<String> _jenisSalesFeedbackType = <String>[
    'SUDAH PINDAH BANK / KANTOR BAYAR',
    'MASIH MEMILIKI PINJAMAN DI BANK LAIN',
    'MASIH MEMILIKI PINJAMAN DI KOPERASI LAIN',
    'MENUNGGU PINJAMAN LUNAS TERLEBIH DAHULU',
    'BELUM ADA PINJAMAN DI BANK LAIN',
    'MAU TAKEOVER PINJAMAN',
    'PENSIUNAN BERMINAT UNTUK MEMINJAM'
  ];
  var selectedRencanaPinjaman;
  List<String> _jenisRencanaPinjamanType = <String>[
    '1.000.000 - 50.000.000',
    '50.000.000 - 100.000.000',
    '100.000.000 - 200.000.000',
    '200.000.000 - 300.000.000',
    '300.000.000 - 400.000.000',
    '400.000.000 - 500.000.000',
    '500.000.000 - 1.000.000.000'
  ];
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String uploadEndPoint =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/saveInteraction';
  Future<File> file;
  String status = '';
  String base64Image;
  XFile tmpFile;
  String errMessage = 'Error Uploading Image';
  bool _loading = false;
  bool _loadingOtp = false;
  var hasil;

  final namaPensiunController = TextEditingController();
  final alamatController = TextEditingController();
  final emailController = TextEditingController();
  final teleponController = TextEditingController();
  final otpController = TextEditingController();

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

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pilih Foto Interaksi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera();
                      })
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
    upload(fileName);
  }

  Future requestOtp() async {
    setState(() {
      _loadingOtp = true;
    });
    //server login api
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/sendOtp');
    telepon = teleponController.text;
    //starting web api call
    var response = await http.post(url, body: {'telepon': telepon, 'nik_sales': widget.nik});
    if (telepon == '' || telepon == null) {
      setState(() {
        _loadingOtp = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('No Telepon wajib diisi terlebih dahulu...'),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Save_Otp'];
        print(message);
        if (message['message'].toString() == 'Otp Success') {
          setState(() {
            _loadingOtp = false;
            kodeOtp = message['kode_otp'];
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:
                    new Text('Kode verifikasi berhasil dikirim, mohon periksa handphone kamu...'),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  upload(String fileName) {
    //getting value from controller
    namaPensiun = namaPensiunController.text;
    alamat = alamatController.text;
    email = emailController.text;
    telepon = teleponController.text;
    otp = otpController.text;

    http.post(Uri.parse(uploadEndPoint), body: {
      "niksales": widget.nik,
      "image": base64Image,
      "name": fileName,
      "file_name": "interaksi",
      "nama_pensiun": namaPensiun,
      "alamat": alamat,
      "email": email,
      "telepon": telepon,
      "otp": otp,
      "rencana_pinjaman": selectedRencanaPinjaman.toString(),
      "sales_feedback": selectedSalesFeedback.toString()
    }).then((result) {
      if (result.statusCode == 200) {
        var message = jsonDecode(result.body)['status'];
        setStatus(jsonDecode(result.body)['status']);
        setState(() {
          _loading = false;
          hasil = result.body;
          tmpFile = null;
          namaPensiunController.clear();
          alamatController.clear();
          emailController.clear();
          teleponController.clear();
          otpController.clear();
          selectedRencanaPinjaman = null;
          selectedSalesFeedback = null;
        });
        Toast.show(
          'Sukses menambahkan data interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          _loading = false;
        });
        Toast.show(
          'Gagal menambahkan data interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      Toast.show(
        'Gagal menambahkan data interaksi...',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
      );
    });
  }

  Widget _decideImageView() {
    if (tmpFile == null) {
      return Container(
          width: 250,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(
              color: leadsGoColor,
              width: 3,
            ),
          ),
          child: Center(
              child: Text("Foto Selfie / KTP",
                  style: TextStyle(fontSize: 20, fontFamily: 'LeadsGo-Font'))));
    } else {
      base64Image = base64Encode(File(tmpFile.path).readAsBytesSync());
      tmpFile = tmpFile;
      return Row(
        children: [
          Flexible(
              child: Image.file(
            File(tmpFile.path),
            fit: BoxFit.fill,
          ))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _loading
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Mohon menunggu, sedang proses penyimpanan interaksi...'),
                    //content: Text('We hate to see you leave...'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                )
              : Navigator.of(context).pop();
        },
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: leadsGoColor,
              title: Text(
                'Interaksi',
                style: TextStyle(fontFamily: 'LeadsGo-Font'),
              ),
              actions: <Widget>[
                FlatButton(
                    child: _loading
                        ? CircularProgressIndicator(
                            //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Simpan',
                            style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        if (selectedRencanaPinjaman == null) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Mohon pilih rencana pinjaman...'),
                            duration: Duration(seconds: 3),
                          ));
                        } else if (selectedSalesFeedback == null) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Mohon pilih sales feedback...'),
                            duration: Duration(seconds: 3),
                          ));
                        } else if (tmpFile == null) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Mohon pilih foto selfie/KTP...'),
                            duration: Duration(seconds: 3),
                          ));
                        } else if (otpController.text != kodeOtp) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Mohon isi kode verifikasi dengan benar...'),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          setState(() {
                            _loading = true;
                          });
                          startUpload();
                        }
                      }

                      //_showProgressDialog(context);
                      //saveInteraction();
                    })
              ],
            ),
            body: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
                child: Form(
                  key: formKey,
                  child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
                    fieldDebitur(),
                    fieldAlamat(),
                    fieldEmail(),
                    fieldTelepon(),
                    Row(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: fieldOTP(),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Center(
                            child: _loadingOtp
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                    ),
                                    height: 20.0,
                                    width: 20.0,
                                  )
                                : FlatButton(
                                    color: Colors.red,
                                    child: Text("Kode Verifikasi",
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontSize: 12.0,
                                            color: Colors.white)),
                                    onPressed: () {
                                      requestOtp();
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                          ))
                    ]),
                    fieldRencanaPinjaman(),
                    fieldSalesFeedback(),
                    _decideImageView(),
                  ]),
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _loading
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Mohon menunggu, sedang proses penyimpanan interaksi...'),
                          //content: Text('We hate to see you leave...'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      )
                    : _showChoiceDialog(context);
              },
              backgroundColor: leadsGoColor,
              child: new Icon(Icons.camera_alt),
            ),
          ),
        ));
  }

  Widget fieldDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama pensiun wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama Pensiun'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
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
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldEmail() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: 'Email'),
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
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
      decoration: InputDecoration(labelText: 'No Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldOTP() {
    return TextFormField(
      controller: otpController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kode verifikasi wajib diisi...';
        } else if (value.length < 4) {
          return 'Kode verifikasi minimal 4 angka...';
        } else if (value.length > 4) {
          return 'Kode verifikasi maksimal 4 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kode Verifikasi'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldRencanaPinjaman() {
    return DropdownButton(
      items: _jenisRencanaPinjamanType
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedRencanaPinjamanType) {
        setState(() {
          selectedRencanaPinjaman = selectedRencanaPinjamanType;
        });
      },
      value: selectedRencanaPinjaman,
      isExpanded: true,
      hint: Text('Rencana Pinjaman', style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font')),
    );
  }

  Widget fieldSalesFeedback() {
    return DropdownButton(
      items: _jenisSalesFeedbackType
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedSalesFeedbackType) {
        setState(() {
          selectedSalesFeedback = selectedSalesFeedbackType;
        });
      },
      value: selectedSalesFeedback,
      isExpanded: true,
      hint: Text('Sales Feedback', style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font')),
    );
  }
}
