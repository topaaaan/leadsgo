import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_screen.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page.dart';
import 'package:leadsgo_apps/Screens/Landing/landing_page_mr.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:toast/toast.dart';

class PlanningAddScreen extends StatefulWidget {
  String username;
  String nik;

  PlanningAddScreen(this.username, this.nik);
  @override
  _PlanningAddScreen createState() => _PlanningAddScreen();
}

class _PlanningAddScreen extends State<PlanningAddScreen> {
  bool visible = false;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String namaPensiun;
  String alamatPensiun;
  String kelurahan;
  String kecamatan;
  String kotakab;
  String propinsi;
  String teleponPensiun;
  String kantorBayarPensiun;
  String instansiPensiun;
  var personalData = new List(38);

  final namaPensiunController = TextEditingController();
  final alamatPensiunController = TextEditingController();
  final kelurahanController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kotakabController = TextEditingController();
  final propinsiController = TextEditingController();
  final teleponPensiunController = TextEditingController();
  final kantorBayarPensiunController = TextEditingController();
  final instansiPensiunController = TextEditingController();

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

  Future savePlanning() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    namaPensiun = namaPensiunController.text;
    alamatPensiun = alamatPensiunController.text;
    kelurahan = kelurahanController.text;
    kecamatan = kecamatanController.text;
    kotakab = kotakabController.text;
    propinsi = propinsiController.text;
    teleponPensiun = teleponPensiunController.text;
    kantorBayarPensiun = kantorBayarPensiunController.text;
    instansiPensiun = instansiPensiunController.text;

    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/addRencanaInteraksi');

    //starting web api call
    var response = await http.post(url, body: {
      'nama_pensiun': namaPensiun,
      'alamat_pensiun': alamatPensiun,
      'kelurahan': kelurahan,
      'kecamatan': kecamatan,
      'kotakab': kotakab,
      'propinsi': propinsi,
      'telepon_pensiun': teleponPensiun,
      'kantor_pensiun': kantorBayarPensiun,
      'instansi_pensiun': instansiPensiun,
      'nik_sales': widget.nik,
      'notas': teleponPensiun
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Planning_Interaction'];
      if (message['message'].toString() == 'Save Success') {
        setState(() {
          visible = false;
          namaPensiunController.clear();
          alamatPensiunController.clear();
          kelurahanController.clear();
          kecamatanController.clear();
          kotakabController.clear();
          propinsiController.clear();
          teleponPensiunController.clear();
          kantorBayarPensiunController.clear();
          instansiPensiunController.clear();
        });
        userLogin();
        Toast.show(
          'Sukses menambahkan data rencana interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
        );
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal menambahkan data rencana interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Interaksi sekarang! (Kuota: 50/bln)',
            style: TextStyle(fontFamily: 'LeadsGo-Font'),
          ),
          // actions: <Widget>[
          //   FlatButton(
          //     child: visible
          //         ? CircularProgressIndicator(
          //             //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
          //             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //           )
          //         : Container(
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4), color: Colors.white),
          //             padding: EdgeInsets.all(2.0),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(
          //                 'Simpan',
          //                 style: TextStyle(
          //                     fontFamily: 'LeadsGo-Font',
          //                     color: leadsGoColor,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //     onPressed: () {
          //       if (formKey.currentState.validate()) {
          //         savePlanning();
          //       }
          //     },
          //   )
          // ],
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 75.0),
          child: Form(
            key: formKey,
            child:
                ListView(physics: ClampingScrollPhysics(), children: <Widget>[
              SizedBox(height: size.height * 0.02),
              fieldNama(),
              SizedBox(height: size.height * 0.02),
              fieldAlamat(),
              SizedBox(height: size.height * 0.02),
              fieldKelurahan(),
              SizedBox(height: size.height * 0.02),
              fieldKecamatan(),
              SizedBox(height: size.height * 0.02),
              fieldKotakab(),
              SizedBox(height: size.height * 0.02),
              fieldPropinsi(),
              SizedBox(height: size.height * 0.02),
              fieldTelepon(),
              SizedBox(height: size.height * 0.02),
              fieldNamaKantor(),
              SizedBox(height: size.height * 0.02),
              fieldPenerbitSkep(),
              SizedBox(height: size.height * 0.02),
            ]),
          ),
        ),
        bottomSheet: Container(
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
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: FlatButton(
                    height: 46,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(123),
                    ),
                    color: leadsGoColor,
                    child: Center(
                      child: Text(
                        'Simpan Interaksi',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'LeadsGo-Font',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        savePlanning();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldNama() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama lengkap wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Nama Lengkap",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: "Nama Lengkap"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(
        fontFamily: 'LeadsGo-Font',
      ),
    );
  }

  Widget fieldPenerbitSkep() {
    return TextFormField(
      controller: instansiPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Instansi pensiun wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Instansi Pensiun",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: "Instansi Pensiun"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldAlamat() {
    return TextFormField(
      controller: alamatPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Alamat wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
        //Add th Hint text here.
        hintText: "Alamat",
        hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Alamat",
      ),
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
      decoration: InputDecoration(
        //Add th Hint text here.
        hintText: "Kelurahan",
        hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Kelurahan",
      ),
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
      decoration: InputDecoration(
        //Add th Hint text here.
        hintText: "Kecamatan",
        hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Kecamatan",
      ),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKotakab() {
    return TextFormField(
      controller: kotakabController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kota wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
        //Add th Hint text here.
        hintText: "Kota",
        hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Kota",
      ),
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
      decoration: InputDecoration(
        //Add th Hint text here.
        hintText: "Propinsi",
        hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Propinsi",
      ),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldNamaKantor() {
    return TextFormField(
      controller: kantorBayarPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama kantor bayar wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Kantor Bayar",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: "Kantor Bayar"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No Telepon minimal 10 angka...';
        } else if (value.length > 13) {
          return 'No Telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Telepon",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: "Telepon"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }
}
