import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_screen.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

// ignore: must_be_immutable
class DisbursmentEditScreen extends StatefulWidget {
  String username;
  String nik;
  String noAkad;
  String statusKaryawan;
  String personalData;

  DisbursmentEditScreen(
      this.username, this.nik, this.noAkad, this.statusKaryawan, this.personalData);
  @override
  _DisbursmentEditScreen createState() => _DisbursmentEditScreen();
}

class _DisbursmentEditScreen extends State<DisbursmentEditScreen> {
  bool loadingScreen;
  String image1, image2, image3;
  String base64Image1, base64Image2, base64Image3;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCabang();
    setState(() {
      images.add('Add Image');
      images.add('Add Image');
      images.add('Add Image');
      getDataPencairan();
    });
  }

  String id;
  String namaPensiun;
  String alamat;
  String telepon;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String plafond;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String path1;
  String path2;
  String path3;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedJenisDebitur;
  List<String> _jenisDebiturType = <String>[
    'Prapensiun',
    'Pensiun',
    'Take over Kredit Aktif BTPN',
    'Pegawai Aktif PNS',
    'Pegawai Aktif BUMN',
    'Pegawai Perguruan Tinggi'
  ];
  var selectedJenisProduk;
  List<String> _jenisProdukType = <String>['Fleksi BNI', 'KP74 BTPN', 'KP74 BJB'];
  var selectedJenisCabang;

  var selectedJenisInfo;
  List<String> _jenisInfoType = <String>[
    'REFERAL',
    'WALK IN',
    'INTERAKSI',
    'SMS BLAST PUSAT',
    'SOSIAL MEDIA',
    'SOSIALISASI INSTANSI',
    'TELEMARKETING PUSAT'
  ];

  var selectedStatusKredit;
  List<String> _jenisStatusKreditType = <String>['KREDIT BARU', 'TOP UP', 'TAKEOVER'];

  final String url = 'https://tetranabasainovasi.com/api_marsit_v1/service.php/getCabang';
  List data =
      List(); //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY
  bool visible = false;
  final namaPensiunController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final tanggalPerjanjianController = TextEditingController();
  final nomorAplikasiController = TextEditingController();
  final nomorPerjanjianController = TextEditingController();
  final plafondController = TextEditingController();
  final namaPetugasBankController = TextEditingController();
  final jabatanPetugasBankController = TextEditingController();
  final teleponPetugasBankController = TextEditingController();

  Future getDataPencairan() async {
    loadingScreen = true;
    String noAkad = widget.noAkad;
    String nikSales = widget.nik;
    //server login api
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getDataPencairan');
    //starting web api call
    var response = await http.post(url, body: {'no_akad': noAkad, 'nik_sales': nikSales});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Data_Pencairan'];
      print(message);
      setState(() {
        loadingScreen = false;
        id = message[0]['id'].toString();
        namaPensiunController.text = message[0]['debitur'].toString();
        alamatController.text = message[0]['alamat'].toString();
        teleponController.text = message[0]['telepon'].toString();
        tanggalPerjanjianController.text = message[0]['tanggal_akad'].toString();
        nomorAplikasiController.text = message[0]['nomor_akad'].toString();
        nomorPerjanjianController.text = message[0]['no_janji'].toString();
        plafondController.text = message[0]['plafond'].toString();
        if (message[0]['jenis_pencairan'].toString() == 'Calon Pensiun') {
          selectedJenisDebitur = 'Prapensiun';
        }
        if (message[0]['jenis_produk'].toString() == 'Flexi') {
          selectedJenisProduk = 'Fleksi BNI';
        }
        selectedJenisCabang = message[0]['cabang'].toString();
        selectedJenisInfo = message[0]['info_sales'].toString();
        selectedStatusKredit = message[0]['status_kredit'].toString();
        namaPetugasBankController.text = message[0]['nama_tl'].toString();
        jabatanPetugasBankController.text = message[0]['jabatan_tl'].toString();
        teleponPetugasBankController.text = message[0]['telepon_tl'].toString();
        path1 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto1'].toString();
        path2 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto2'].toString();
        path3 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto3'].toString();
        images.replaceRange(0, 0 + 1, [path1]);
        image1 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto1'].toString();
        images.replaceRange(1, 1 + 1, [path2]);
        image2 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto2'].toString();
        images.replaceRange(2, 2 + 1, [path3]);
        image3 = 'https://tetranabasainovasi.com/marsit/' + message[0]['foto3'].toString();
        print(images);
      });
    } else {
      setState(() {
        loadingScreen = false;
      });
      print('error');
    }
  }

  // ignore: missing_return
  Future<String> getCabang() async {
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body)['Daftar_Cabang'];
    setState(() {
      data = resBody;
      print(data);
    });
  }

  Future updateDisbursment() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //getting value from controller
    namaPensiun = namaPensiunController.text;
    alamat = alamatController.text;
    telepon = teleponController.text;
    tanggalAkad = tanggalPerjanjianController.text;
    nomorAplikasi = nomorAplikasiController.text;
    nomorPerjanjian = nomorPerjanjianController.text;
    plafond = plafondController.text;
    namaPetugasBank = namaPetugasBankController.text;
    jabatanPetugasBank = jabatanPetugasBankController.text;
    teleponPetugasBank = teleponPetugasBankController.text;

    print(tanggalAkad);
    //server save api
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/updateDisbursment');
    var response;
    if (path1 != '' && path2 != '' && path3 != '') {
      //starting web api call
      response = await http.post(url, body: {
        'id': id,
        'nama_pensiun': namaPensiun,
        'alamat': alamat,
        'telepon': telepon,
        'jenis_debitur': selectedJenisDebitur,
        'jenis_produk': selectedJenisProduk,
        'tanggal_akad': tanggalAkad,
        'nomor_aplikasi': nomorAplikasi,
        'nomor_perjanjian': nomorPerjanjian,
        'jenis_cabang': selectedJenisCabang,
        'plafond': plafond,
        'jenis_info': selectedJenisInfo,
        'niksales': widget.nik,
        'status_kredit': selectedStatusKredit,
        'nama_petugas_bank': namaPetugasBank,
        'jabatan_petugas_bank': jabatanPetugasBank,
        'telepon_petugas_bank': teleponPetugasBank,
        'image': '1'
      });
    } else {
      //starting web api call
      response = await http.post(url, body: {
        'id': id,
        'nama_pensiun': namaPensiun,
        'alamat': alamat,
        'telepon': telepon,
        'jenis_debitur': selectedJenisDebitur,
        'jenis_produk': selectedJenisProduk,
        'tanggal_akad': tanggalAkad,
        'nomor_aplikasi': nomorAplikasi,
        'nomor_perjanjian': nomorPerjanjian,
        'jenis_cabang': selectedJenisCabang,
        'plafond': plafond,
        'jenis_info': selectedJenisInfo,
        'niksales': widget.nik,
        'file_name': 'disbursment',
        'image1': base64Image1,
        'name1': image1,
        'image2': base64Image2,
        'name2': image2,
        'image3': base64Image3,
        'name3': image3,
        'status_kredit': selectedStatusKredit,
        'nama_petugas_bank': namaPetugasBank,
        'jabatan_petugas_bank': jabatanPetugasBank,
        'telepon_petugas_bank': teleponPetugasBank,
        'image': '0'
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Disbursment'];
      if (message.toString() == 'Update Success') {
        setState(() {
          visible = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DisbursmentScreen(
                    widget.username, widget.nik, widget.statusKaryawan, widget.personalData)));
        Toast.show(
          'Sukses update data pencairan kredit...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else if (message.toString() == 'Nomor Aplikasi') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Maaf, nomor aplikasi sudah terdaftar, mohon masukkan nomor aplikasi yang lain...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DisbursmentScreen(
                    widget.username, widget.nik, widget.statusKaryawan, widget.personalData)));
        Toast.show(
          'Gagal update data pencairan kredit...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          visible
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Mohon menunggu, sedang proses penyimpanan pencairan kredit...'),
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
                'Pencairan',
                style: TextStyle(fontFamily: 'LeadsGo-Font'),
              ),
              actions: <Widget>[
                loadingScreen
                    ? Text('')
                    : FlatButton(
                        //LAKUKAN PENGECEKAN, JIKA _ISLOADING TRUE MAKA TAMPILKAN LOADING
                        //JIKA FALSE, MAKA TAMPILKAN ICON SAVE
                        child: visible
                            ? CircularProgressIndicator(
                                //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Ubah',
                                style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                        onPressed: () {
                          print(image1);
                          if (formKey.currentState.validate()) {
                            if (selectedJenisDebitur == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih jenis pensiun...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedJenisProduk == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih jenis produk...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedJenisCabang == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih kantor cabang...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedJenisInfo == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih informasi sales...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (selectedStatusKredit == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih status kredit...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (image1 == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih foto akad...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (image2 == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih foto tanda tangan akad...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else if (image3 == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Mohon pilih foto bukti dana cair...'),
                                duration: Duration(seconds: 3),
                              ));
                            } else {
                              updateDisbursment();
                            }
                          }
                        })
              ],
            ),
            body: loadingScreen
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    child: Form(
                      key: formKey,
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DATA NASABAH',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                fieldDebitur(),
                                fieldAlamat(),
                                fieldTelepon(),
                                fieldTanggalAkad(),
                                fieldNomorAplikasi(),
                                fieldNomorPerjanjian(),
                                fieldPlafond(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DATA KREDIT',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            //color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                fieldJenisDebitur(),
                                fieldKodeProduk(),
                                fieldKantorCabang(),
                                fieldSalesInfo(),
                                fieldStatusKredit(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DATA PETUGAS BANK',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                fieldPetugasBank(),
                                fieldJabatanBank(),
                                fieldNoTeleponBank(),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'DOKUMEN KREDIT',
                                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              path1 = '';
                                            });
                                          },
                                          child: Tooltip(
                                            message: 'Reset Photo',
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                          )))
                                ],
                              )),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            //color: Colors.white,
                            child: Row(
                              children: <Widget>[Expanded(child: buildGridView())],
                            ),
                          ),
                        ],
                      ),
                    )),
          ),
        ));
  }

  Widget fieldPetugasBank() {
    return TextFormField(
      controller: namaPetugasBankController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldJabatanBank() {
    return TextFormField(
      controller: jabatanPetugasBankController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Jabatan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Jabatan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldNoTeleponBank() {
    return TextFormField(
      controller: teleponPetugasBankController,
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
      decoration: InputDecoration(labelText: 'No. Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
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
                          backgroundDecoration: BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    uploadModel.imageFile,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
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
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          if (path1 != '' && path2 != '' && path3 != '') {
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
                            imageProvider: NetworkImage(images[index]),
                            backgroundDecoration: BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      images[index],
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
            );
          } else {
            String titled;
            Color colored;
            if (index == 0) {
              titled = 'Foto SKK';
              colored = Colors.red;
            } else if (index == 1) {
              titled = 'Foto Tanda Tangan Akad';
              colored = Colors.yellow;
            } else if (index == 2) {
              titled = 'Foto Bukti Dana Cair';
              colored = Colors.green;
            }
            return Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: colored, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titled,
                    style: TextStyle(fontSize: 8.0, fontFamily: 'LeadsGo-Font'),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                ],
              ),
            );
          }
        }
      }),
    );
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
          String base64Image = base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          } else if (index == 1) {
            image2 = fileName;
            base64Image2 = base64Image;
          } else if (index == 2) {
            image3 = fileName;
            base64Image3 = base64Image;
          }
        }
      });
    });
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

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
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
      decoration: InputDecoration(labelText: 'No Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldJenisDebitur() {
    return DropdownButtonFormField(
        items: _jenisDebiturType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisDebiturType) {
          setState(() {
            selectedJenisDebitur = selectedJenisDebiturType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Pencairan',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
        value: selectedJenisDebitur,
        isExpanded: true);
  }

  Widget fieldKodeProduk() {
    return DropdownButtonFormField(
        items: _jenisProdukType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisProdukType) {
          setState(() {
            selectedJenisProduk = selectedJenisProdukType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Produk',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
        value: selectedJenisProduk,
        isExpanded: true);
  }

  Widget fieldStatusKredit() {
    return DropdownButtonFormField(
        items: _jenisStatusKreditType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedStatusKreditType) {
          setState(() {
            selectedStatusKredit = selectedStatusKreditType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Status Kredit',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
        value: selectedStatusKredit,
        isExpanded: true);
  }

  Widget fieldTanggalAkad() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPerjanjianController,
          decoration: InputDecoration(labelText: 'Tanggal Akad'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font')),
    ]);
  }

  Widget fieldNomorAplikasi() {
    return TextFormField(
        controller: nomorAplikasiController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nomor aplikasi wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nomor Aplikasi'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
        style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'));
  }

  Widget fieldNomorPerjanjian() {
    return TextFormField(
      controller: nomorPerjanjianController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor perjanjian wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor Perjanjian'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKantorCabang() {
    return DropdownButtonFormField(
        items: data
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value['NAMA'],
                    style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                  ),
                  value: value['NAMA'].toString(),
                ))
            .toList(),
        onChanged: (selectedJenisCabangType) {
          setState(() {
            selectedJenisCabang = selectedJenisCabangType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Kantor Cabang',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
        value: selectedJenisCabang,
        isExpanded: true);
  }

  Widget fieldPlafond() {
    return TextFormField(
        controller: plafondController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nominal pinjaman wajib diisi...';
          } else if (value.length < 8) {
            return 'Nominal pinjaman minimal 8 digit...';
          } else if (value.length > 9) {
            return 'Nominal pinjaman maksimal 9 digit';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nominal Pinjaman'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
        style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'));
  }

  Widget fieldSalesInfo() {
    return DropdownButtonFormField(
        items: _jenisInfoType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisInfoType) {
          setState(() {
            selectedJenisInfo = selectedJenisInfoType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Informasi Sales',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
        value: selectedJenisInfo,
        isExpanded: true);
  }
}
