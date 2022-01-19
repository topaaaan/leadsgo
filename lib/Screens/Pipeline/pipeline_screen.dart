import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_akad.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_edit.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_submit.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class PipelineScreen extends StatefulWidget {
  @override
  _PipelineScreen createState() => _PipelineScreen();

  String username;
  String nik;

  PipelineScreen(this.username, this.nik);
}

class _PipelineScreen extends State<PipelineScreen> {
  bool visible = false;
  Future deletePipeline(String id) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/deletePipeline');
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
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal delete pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PipelineRootPage(widget.username, widget.nik)));
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
          String fotoAkad2) =>
      PopupMenuButton<int>(
        padding: EdgeInsets.only(left: 2),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PipelineEditScreen(widget.username, widget.nik, id)));
              },
              child: Tooltip(
                  message: 'Edit',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: leadsGoColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Ubah')
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: InkWell(
              onTap: () {
                if (statusPipeline != '2') {
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
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa submit dokumen kembali',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
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
                      Text('Submit Dokumen')
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: InkWell(
              onTap: () {
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
              },
              child: Tooltip(
                  message: 'Akad Kredit',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: leadsGoColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Akad Kredit')
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 4,
            child: InkWell(
              onTap: () {
                if (statusPipeline != '2') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                          'Apakah anda ingin menghapus pipeline debitur ' + namaNasabah + ' ?'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tidak'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            deletePipeline(
                              id,
                            );
                          },
                          child: Text('Ya'),
                        ),
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
                      Text('Hapus')
                    ],
                  )),
            ),
          ),
        ],
        icon: Icon(Icons.more_vert),
        offset: Offset(0, 30),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Pipeline',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PipelineAddScreen(widget.username, widget.nik)));
                },
              )
            ],
          ),
          //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
          //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
          body: RefreshIndicator(
              onRefresh: () => Provider.of<PipelineProvider>(context, listen: false)
                  .getPipeline(PipelineItem(widget.nik)),
              color: Colors.red,
              child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: FutureBuilder(
                      future: Provider.of<PipelineProvider>(context, listen: false)
                          .getPipeline(PipelineItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.data == null &&
                            snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                          );
                        } else if (snapshot.data == null) {
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
                                'Buat Pipeline Yuk!',
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
                            ]),
                          );
                        } else {
                          return Consumer<PipelineProvider>(builder: (context, data, _) {
                            print(data.dataPipeline.length);
                            if (data.dataPipeline.length == 0) {
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
                                    'Buat Pipeline Yuk!',
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
                                ]),
                              );
                            } else {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.dataPipeline.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: Colors.black12,
                                        ))),
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                            child: ListTile(
                                              title: Text(
                                                data.dataPipeline[i].namaNasabah,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'LeadsGo-Font'),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Tooltip(
                                                        message: 'Plafond',
                                                        child: Icon(
                                                          Icons.monetization_on_outlined,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${formatRupiah(data.dataPipeline[i].plafond)}',
                                                        style: TextStyle(
                                                            fontFamily: 'LeadsGo-Font',
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Tooltip(
                                                        message: 'Tanggal Input',
                                                        child: Icon(
                                                          Icons.date_range_outlined,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${data.dataPipeline[i].tglPipeline}',
                                                        style: TextStyle(
                                                            fontFamily: 'LeadsGo-Font',
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Tooltip(
                                                        message: 'Status Pipeline',
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        messageStatus(
                                                            '${data.dataPipeline[i].status}'),
                                                        style: TextStyle(
                                                            fontFamily: 'LeadsGo-Font',
                                                            fontWeight: FontWeight.bold,
                                                            color: colorStatus(
                                                                '${data.dataPipeline[i].status}')),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              trailing: Wrap(
                                                spacing: 12,
                                                children: <Widget>[
                                                  _showPopupMenu(
                                                    data.dataPipeline[i].id.toString(),
                                                    data.dataPipeline[i].namaNasabah.toString(),
                                                    data.dataPipeline[i].noKtp.toString(),
                                                    data.dataPipeline[i].noNip.toString(),
                                                    data.dataPipeline[i].telepon.toString(),
                                                    data.dataPipeline[i].plafond.toString(),
                                                    data.dataPipeline[i].cabang.toString(),
                                                    data.dataPipeline[i].tglPenyerahan.toString(),
                                                    data.dataPipeline[i].namaPenerima.toString(),
                                                    data.dataPipeline[i].teleponPenerima.toString(),
                                                    data.dataPipeline[i].status,
                                                    data.dataPipeline[i].fotoTandaTerima,
                                                    data.dataPipeline[i].tanggalAkad,
                                                    // data.dataPipeline[i]
                                                    //     .nomorAplikasi,
                                                    data.dataPipeline[i].nomorRekening,
                                                    data.dataPipeline[i].nomorPerjanjian,
                                                    data.dataPipeline[i].nominalPinjaman,
                                                    data.dataPipeline[i].finalOS,
                                                    data.dataPipeline[i].nominalTopUp,
                                                    data.dataPipeline[i].jenisProduk,
                                                    data.dataPipeline[i].salesInfo,
                                                    data.dataPipeline[i].namaPetugasBank,
                                                    // data.dataPipeline[i]
                                                    //     .jabatanPetugasBank,
                                                    data.dataPipeline[i].kodeAO,
                                                    data.dataPipeline[i].teleponPetugasBank,
                                                    data.dataPipeline[i].fotoAkad1,
                                                    data.dataPipeline[i].fotoAkad2,
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
                      })))),
    );
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Pipeline';
    } else if (status == '2') {
      return 'Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.orangeAccent;
    } else if (status == '2') {
      return Colors.greenAccent;
    } else if (status == '3') {
      return Colors.blueAccent;
    } else if (status == '4') {
      return Colors.blueAccent;
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
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'IDR ' + fmf.output.withoutFractionDigits;
  }

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
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
}
