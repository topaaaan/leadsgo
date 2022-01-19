import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:leadsgo_apps/Screens/WebView/webview_container_screen.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

class MitraScreen extends StatefulWidget {
  @override
  _MitraScreen createState() => _MitraScreen();
}

class _MitraScreen extends State<MitraScreen> {
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  final _links = 'https://www.kreditpensiun.com/mitra.html';

  String image1, image2, image3;
  String base64Image1, base64Image2, base64Image3;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;
  String teleponMitra;
  String namaMitra;
  String emailMitra;
  String nomorKtp;
  String nomorRekening;
  final formKey = GlobalKey<FormState>();
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  bool _loading = false;

  final teleponMitraController = TextEditingController();
  final namaMitraController = TextEditingController();
  final emailMitraController = TextEditingController();
  final nomorKtpController = TextEditingController();
  final nomorRekeningController = TextEditingController();

  Future saveDisbursment() async {
    setState(() {
      _loading = true;
    });
    //getting value from controller
    teleponMitra = teleponMitraController.text;
    namaMitra = namaMitraController.text;
    emailMitra = emailMitraController.text;
    nomorKtp = nomorKtpController.text;
    nomorRekening = nomorRekeningController.text;

    //server save api
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/saveMitra');

    //starting web api call
    var response = await http.post(url, body: {
      "nomor_ktp": nomorKtp,
      "telepon": teleponMitra,
      "nama_mitra": namaMitra,
      "email_mitra": emailMitra,
      "nomor_rekening": nomorRekening,
      "file_name": "mitra",
      'image1': base64Image1,
      'name1': image1,
      'image2': base64Image2,
      'name2': image2,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Mitra'];
      if (message.toString() == 'Save Success') {
        setState(() {
          _loading = false;
          nomorKtpController.clear();
          namaMitraController.clear();
          teleponMitraController.clear();
          emailMitraController.clear();
          nomorRekeningController.clear();
          image1 = null;
          image2 = null;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
        Toast.show(
          'Sukses mendaftar sebagai mitra, silahkan menunggu proses verifikasi dari kami...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else if (message.toString() == 'Mitra Ada') {
        setState(() {
          _loading = false;
        });
        Toast.show(
          'Nomor KTP ini sudah terdaftar sebagai mitra,mohon masukkan nomor KTP lain...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          _loading = false;
          nomorKtpController.clear();
          namaMitraController.clear();
          teleponMitraController.clear();
          emailMitraController.clear();
          nomorRekeningController.clear();
          image1 = null;
          image2 = null;
        });
        Toast.show(
          'Gagal mendaftar sebagai mitra, silahkan mencoba kembali...',
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
    return WillPopScope(
      onWillPop: () async {
        _loading
            ? showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Mohon menunggu, proses sedang berlangsung...'),
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
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Mitra',
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
                    saveDisbursment();
                  })
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
            child: Form(
              key: formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  fieldKtp(),
                  fieldNama(),
                  fieldTelepon(),
                  fieldEmail(),
                  fieldRekening(),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: buildGridView(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleURLButtonPress(context, _links);
                    },
                    child: Text(
                      '*Informasi lebih lanjut mengenai mitra',
                      style:
                          TextStyle(color: Colors.blue, fontFamily: 'LeadsGo-Font', fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponMitraController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Telepon wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldNama() {
    return TextFormField(
      controller: namaMitraController,
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

  Widget fieldEmail() {
    return TextFormField(
      controller: emailMitraController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Email wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Email'),
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldKtp() {
    return TextFormField(
      controller: nomorKtpController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No Ktp wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor KTP'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget fieldRekening() {
    return TextFormField(
      controller: nomorRekeningController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No Rekening wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor Rekening'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
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
          String titled;
          Color colored;
          if (index == 0) {
            titled = 'Foto KTP';
            colored = Colors.deepPurple;
          } else if (index == 1) {
            titled = 'Foto Rekening';
            colored = Colors.deepPurple;
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
              ));
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
}
