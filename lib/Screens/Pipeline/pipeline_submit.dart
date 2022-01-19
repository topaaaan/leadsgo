import 'dart:convert';
import 'dart:io';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:leadsgo_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:leadsgo_apps/Screens/models/image_upload_model.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class PipelineSubmitScreen extends StatefulWidget {
  String username;
  String nik;
  String id;
  String debitur;
  String noKtp;
  String noNip;
  String telepon;
  String nominal;
  String cabang;
  String tanggalPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String fotoTandaTerima;

  PipelineSubmitScreen(
      this.username,
      this.nik,
      this.id,
      this.debitur,
      this.noKtp,
      this.noNip,
      this.telepon,
      this.nominal,
      this.cabang,
      this.tanggalPenyerahan,
      this.namaPenerima,
      this.teleponPenerima,
      this.fotoTandaTerima);
  @override
  _PipelineSubmitScreen createState() => _PipelineSubmitScreen();
}

class _PipelineSubmitScreen extends State<PipelineSubmitScreen> {
  bool visible = false;
  bool re_send = false;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String image1;
  String base64Image1;
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    images.add("Add Image");
    super.initState();
    this.setDataPipeline();
  }

  String tanggalPenyerahan;
  // String namaPenerima;
  // String teleponPenerima;
  String path1 = '';
  String action = 'Simpan';

  final tanggalPenyerahanController = TextEditingController();
  // final namaPenerimaController = TextEditingController();
  // final teleponPenerimaController = TextEditingController();

  var selectedJenisProduk;
  List<String> _jenisProdukType = <String>[
    'Pegawai Aktif PNS / TNI / POLRI',
    'Prapensiun',
    'Pensiun'
  ];

  Future setDataPipeline() async {
    setState(() {
      print(widget.tanggalPenyerahan);
      if (widget.tanggalPenyerahan == 'null' ||
          widget.tanggalPenyerahan == null) {
      } else {
        tanggalPenyerahan = widget.tanggalPenyerahan;
        tanggalPenyerahanController.text = widget.tanggalPenyerahan;
        // namaPenerimaController.text = widget.namaPenerima;
        // teleponPenerimaController.text = widget.teleponPenerima;
        path1 = 'https://tetranabasainovasi.com/marsit/assets/images/submit/' +
            widget.fotoTandaTerima;
        images.replaceRange(0, 0 + 1, [path1]);
        image1 = 'https://tetranabasainovasi.com/marsit/assets/images/submit/' +
            widget.fotoTandaTerima;
        action = 'Ubah';
      }
    });
  }

  Future submitPipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    tanggalPenyerahan = tanggalPenyerahanController.text;
    // namaPenerima = namaPenerimaController.text;
    // teleponPenerima = teleponPenerimaController.text;

    //server save api
    var url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/submitPipeline');

    //starting web api call
    var response;
    if (path1 != '') {
      response = await http.post(url, body: {
        'id_pipeline': widget.id,
        'tanggal_penyerahan': tanggalPenyerahan,
        'jenis_produk': selectedJenisProduk,
        // 'nama_penerima': namaPenerima,
        // 'telepon_penerima': teleponPenerima,
        'image': '1'
      });
    } else {
      response = await http.post(url, body: {
        'id_pipeline': widget.id,
        'tanggal_penyerahan': tanggalPenyerahan,
        'jenis_produk': selectedJenisProduk,
        // 'nama_penerima': namaPenerima,
        // 'telepon_penerima': teleponPenerima,
        'file_name': 'submit',
        'image1': base64Image1,
        'name1': image1,
        'image': '0'
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Submit'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          re_send = false;
          tanggalPenyerahanController.clear();
          selectedJenisProduk = null;
          // namaPenerimaController.clear();
          // teleponPenerimaController.clear();
        });
        Toast.show(
          'Sukses submit dokumen debitur ' + widget.debitur,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
          re_send = false;
        });
        Toast.show(
          'Gagal submit dokumen debitur ' + widget.debitur,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      }
    } else {
      setState(() {
        re_send = true;
      });
      Navigator.pop(context, false);
      await _onBackPressed(context);
    }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: visible == false
                ? Column(
                    children: [
                      Icon(
                        MdiIcons.informationOutline,
                        color: leadsGoColor,
                        size: 50.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Apakah anda ingin membatalkan pengisian?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          color: leadsGoColor,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Icon(
                        MdiIcons.cancel,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Proses submit dokument tertunda!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 15),
                      re_send == false
                          ? SizedBox(height: 0)
                          : RaisedButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  if (image1 == null || image1 == '') {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Mohon pilih foto submit dokumen...'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else {
                                    showGeneralDialog(
                                      context: context,
                                      barrierColor: Colors.black12
                                          .withOpacity(0.6), // background color
                                      barrierDismissible:
                                          false, // should dialog be dismissed when tapped outside
                                      barrierLabel:
                                          "Dialog", // label for barrier
                                      transitionDuration: Duration(
                                          milliseconds:
                                              400), // how long it takes to popup dialog after button click
                                      pageBuilder: (_, __, ___) {
                                        // your widget implementation
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircularProgressIndicator(
                                                //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(leadsGoColor),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    submitPipeline();
                                  }
                                }
                              },
                              color: Colors.blue,
                              child: Container(
                                width: 150,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(123),
                                  // color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Simpan Kembali!',
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
            actions: <Widget>[
              Center(
                  child: Column(
                children: [
                  visible == false
                      ? SizedBox(height: 0)
                      : Text(
                          'Ingin membatalkan proses?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'LeadsGo-Font',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                  SizedBox(height: 15),
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
                          Navigator.pop(context, true);
                          // Navigator.of(context).pop(true);
                        },
                        color: visible == false ? leadsGoColor : Colors.red,
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

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Button pressed!');
        final shouldPop = await _onBackPressed(context);
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Submit Dokumen',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
            // actions: [
            //   FlatButton(
            //     onPressed: () {
            //       if (formKey.currentState.validate()) {
            //         if (image1 == null || image1 == '') {
            //           _scaffoldKey.currentState.showSnackBar(SnackBar(
            //             content: Text('Mohon pilih foto submit dokumen...'),
            //             duration: Duration(seconds: 3),
            //           ));
            //         } else {
            //           showGeneralDialog(
            //             context: context,
            //             barrierColor: Colors.black12.withOpacity(0.6), // background color
            //             barrierDismissible: false, // should dialog be dismissed when tapped outside
            //             barrierLabel: "Dialog", // label for barrier
            //             transitionDuration: Duration(
            //                 milliseconds:
            //                     400), // how long it takes to popup dialog after button click
            //             pageBuilder: (_, __, ___) {
            //               // your widget implementation
            //               return Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   SizedBox(
            //                     height: 50,
            //                     width: 50,
            //                     child: CircularProgressIndicator(
            //                       //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
            //                       valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
            //                     ),
            //                   ),
            //                 ],
            //               );
            //             },
            //           );
            //           submitPipeline();
            //         }
            //       }
            //     },
            //     child: Container(
            //       decoration:
            //           BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white),
            //       padding: EdgeInsets.all(2.0),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           '$action',
            //           style: TextStyle(
            //             color: leadsGoColor,
            //             fontFamily: 'LeadsGo-Font',
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
          ),
          body: Container(
              color: Colors.grey[200],
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Informasi Pipeline',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              fieldDebitur('No KTP', widget.noKtp),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('No NIP', widget.noNip),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Debitur', widget.debitur),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Telepon', widget.telepon),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Nominal', formatRupiah(widget.nominal)),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Cabang', widget.cabang),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                      child: Text(
                        'Data Submit',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            fieldTanggal(),
                            fieldJenisProduk(),
                            // fieldPenerima(),
                            // fieldTeleponPenerima(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Dokumen Submit',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 20),
                              ),
                            ),
                            path1 != null && path1 != ''
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            path1 = '';
                                            image1 = '';
                                          });
                                        },
                                        child: Tooltip(
                                          message: 'Reset Photo',
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                        )),
                                  )
                                : Text('')
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        //color: Colors.white,
                        child: Row(
                          children: <Widget>[Expanded(child: buildGridView())],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
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
                      child: Container(
                        child: Center(
                          child: Text(
                            re_send == false
                                ? 'Simpan Dokumen'
                                : 'Simpan Kembali!',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          if (image1 == null || image1 == '') {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content:
                                  Text('Mohon pilih foto submit dokumen...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            showGeneralDialog(
                              context: context,
                              barrierColor: Colors.black12
                                  .withOpacity(0.6), // background color
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                leadsGoColor),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                            submitPipeline();
                          }
                        }
                      },
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

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          width: 70,
          decoration: new BoxDecoration(
            color: leadsGoColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget fieldTanggal() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPenyerahanController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalPenyerahan == null) {
              return 'Tanggal penyerahan wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Penyerahan'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'LeadsGo-Font')),
    ]);
  }

  Widget fieldJenisProduk() {
    return DropdownButtonFormField(
        items: _jenisProdukType
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
        onChanged: (selectedJenisDebiturType) {
          setState(() {
            selectedJenisProduk = selectedJenisDebiturType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Produk',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'LeadsGo-Font',
            )),
        value: selectedJenisProduk,
        isExpanded: true);
  }

  // Widget fieldPenerima() {
  //   return TextFormField(
  //     controller: namaPenerimaController,
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'Nama penerima wajib diisi...';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(labelText: 'Nama Penerima'),
  //     textCapitalization: TextCapitalization.characters,
  //     style: TextStyle(fontFamily: 'LeadsGo-Font'),
  //   );
  // }

  // Widget fieldTeleponPenerima() {
  //   return TextFormField(
  //     controller: teleponPenerimaController,
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'No telepon penerima wajib diisi...';
  //       } else if (value.length < 10) {
  //         return 'No Telepon penerima minimal 10 angka...';
  //       } else if (value.length > 13) {
  //         return 'No Telepon penerima maksimal 13 angka...';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(labelText: 'No Telepon Penerima'),
  //     keyboardType: TextInputType.number,
  //     inputFormatters: <TextInputFormatter>[
  //       WhitelistingTextInputFormatter.digitsOnly
  //     ],
  //     style: TextStyle(fontFamily: 'LeadsGo-Font'),
  //   );
  // }

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
    return 'IDR ' + fmf.output.withoutFractionDigits;
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
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
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
          if (path1 != '') {
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
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
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
              titled = 'Foto bersama penerima\n berserta dokumen ';
              colored = leadsGoColor;
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 12.0,
                        fontFamily: 'LeadsGo-Font',
                        // letterSpacing: 0.7
                      ),
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
          String base64Image =
              base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          }
        }
      });
    });
  }
}
