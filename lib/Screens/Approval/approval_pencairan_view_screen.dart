import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_disbursment_root_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

class ApprovalDisbursmentViewScreen extends StatefulWidget {
  String username;
  String nik;
  String nikSdm;
  String id;
  String calonDebitur;
  String alamat;
  String telepon;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String nominal;
  String jenisPencairan;
  String jenisProduk;
  String kantorCabang;
  String informasiSales;
  String foto1;
  String foto2;
  String foto3;
  String tanggalPencairan;
  String jamPencairan;
  String namaTl;
  String jabatanTl;
  String teleponTl;
  String namaSales;
  String cabang;
  String keterangan;
  String status;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String tanggalPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String tanggalPipeline;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String nomorKtp;
  String npwp;
  String kodeProduk;

  ApprovalDisbursmentViewScreen(
    this.username,
    this.nik,
    this.nikSdm,
    this.id,
    this.calonDebitur,
    this.alamat,
    this.telepon,
    this.tanggalAkad,
    this.nomorAplikasi,
    this.nomorPerjanjian,
    this.nominal,
    this.jenisPencairan,
    this.jenisProduk,
    this.kantorCabang,
    this.informasiSales,
    this.foto1,
    this.foto2,
    this.foto3,
    this.tanggalPencairan,
    this.jamPencairan,
    this.namaTl,
    this.jabatanTl,
    this.teleponTl,
    this.namaSales,
    this.cabang,
    this.keterangan,
    this.status,
    this.statusKredit,
    this.pengelolaPensiun,
    this.bankTakeover,
    this.tanggalPenyerahan,
    this.namaPenerima,
    this.teleponPenerima,
    this.tanggalPipeline,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.nomorKtp,
    this.npwp,
    this.kodeProduk,
  );
  @override
  _ApprovalDisbursmentViewScreenState createState() => _ApprovalDisbursmentViewScreenState();
}

class _ApprovalDisbursmentViewScreenState extends State<ApprovalDisbursmentViewScreen> {
  List imgList;
  List imgText;
  bool _loadingA = false;
  bool _loadingR = false;

  Future dialogLoading(bool _loadingA) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            if (_loadingA == false) {
              Navigator.of(context).pop();
            }
          });

          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                ),
                height: 20,
                width: 20,
              )
            ])),
          );
        });
  }

  Future approvalInteraksi() async {
    //showing CircularProgressIndicator
    setState(() {
      _loadingA = true;
    });
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/ApprovalDisbursment');

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'status_pencairan': 'success',
      'rekom_sl': 'approve_pencairan',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Approval_Disbursment'];
      print(message);
      if (message == 'Save Success') {
        setState(() {
          _loadingA = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ApprovalDisbursmentRootPage(widget.username, widget.nik, widget.nikSdm)),
            ModalRoute.withName('/'));
      } else {
        setState(() {
          _loadingA = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Pencairan gagal disetujui...'),
            //content: Text('We hate to see you leave...'),
            actions: <Widget>[],
          ),
        );
      }
    }
  }

  Future rejectInteraksi() async {
    //showing CircularProgressIndicator
    setState(() {
      _loadingR = true;
    });
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/RejectDisbursment');

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'status_pencairan': 'failed',
      'rekom_sl': 'reject_pencairan',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Reject_Disbursment'];
      if (message.toString() == 'Save Success') {
        setState(() {
          _loadingR = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ApprovalDisbursmentRootPage(widget.username, widget.nik, widget.nikSdm)),
            ModalRoute.withName('/'));
      } else {
        setState(() {
          _loadingR = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Pencairan gagal ditolak...'),
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
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String foto1 = 'https://tetranabasainovasi.com/marsit/' + widget.foto1;
    String foto2 = 'https://tetranabasainovasi.com/marsit/' + widget.foto2;
    String foto3 = 'https://tetranabasainovasi.com/marsit/' + widget.foto3;
    imgList = [foto1, foto2, foto3];
    imgText = ['Foto Akad', 'Foto Tanda Tangan Akad', 'Foto Bukti Dana Cair'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            '${widget.calonDebitur}',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            color: grey,
            child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Dokumen Pencairan',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    _buildBannerMenu(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Nasabah',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Tanggal Pipeline', setNull(widget.tanggalPipeline), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Tempat Lahir', setNull(widget.tempatLahir), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Tanggal Lahir', setNull(widget.tanggalLahir), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Jenis Kelamin',
                      setJenisKelamin(setNull(widget.jenisKelamin)),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'No KTP',
                      setNull(widget.nomorKtp),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'NPWP',
                      setNull(widget.npwp),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur('Alamat', setNull(widget.alamat), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Telepon', setNull(widget.telepon), 120.0),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Kredit',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur(
                      'Jenis Produk',
                      setNull(widget.jenisPencairan),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Plafond',
                      setNull(formatRupiah(widget.nominal)),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Cabang Pencairan',
                      setNull(widget.cabang),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Sales Info',
                      setNull(widget.keterangan),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Status Pipeline',
                      messageStatus(setNull(widget.status)),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur('Status Kredit', setNull(widget.statusKredit), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Pengelola Pensiun',
                      setNull(widget.pengelolaPensiun),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    setNull(widget.statusKredit) == 'TAKEOVER'
                        ? fieldDebitur(
                            'Bank Takeover',
                            setNull(widget.bankTakeover),
                            120.0,
                          )
                        : SizedBox(),
                    setNull(widget.statusKredit) == 'TAKEOVER' ? SizedBox(height: 10) : SizedBox()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Submit',
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
                        fieldDebitur(
                            'Tanggal Penyerahan', setNull(widget.tanggalPenyerahan), 120.0),
                        SizedBox(
                          height: 10,
                        ),
                        fieldDebitur('Nama Penerima', setNull(widget.namaPenerima), 120.0),
                        SizedBox(
                          height: 10,
                        ),
                        fieldDebitur('Telepon Penerima', setNull(widget.teleponPenerima), 120.0),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Akad',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Tanggal Akad', setNull(widget.tanggalAkad), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Nomor Aplikasi', setNull(widget.nomorAplikasi), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Nomor Perjanjian', setNull(widget.nomorPerjanjian), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Nominal Pinjaman', setNull(formatRupiah(widget.nominal)), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Kode Produk', setNull(widget.kodeProduk), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Sales Info', setNull(widget.informasiSales), 120.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Petugas Bank',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Nama', setNull(widget.namaTl), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Jabatan', setNull(widget.jabatanTl), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                    fieldDebitur('Telepon', setNull(widget.teleponTl), 120.0),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Pencairan',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Tanggal Pencairan', setNull(widget.tanggalPencairan), 120.0),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ])),
        bottomSheet: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    dialogLoading(_loadingA);
                    approvalInteraksi();
                  },
                  child: Text(
                    'Setuju',
                    style: TextStyle(color: Colors.white, fontFamily: 'LeadsGo-Font'),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    dialogLoading(_loadingR);
                    rejectInteraksi();
                  },
                  child: Text(
                    'Tolak',
                    style: TextStyle(color: Colors.white, fontFamily: 'LeadsGo-Font'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldDebitur(title, value, size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          decoration: new BoxDecoration(
            color: Colors.indigoAccent,
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
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: TextStyle(fontFamily: 'LeadsGo-Font'),
                    ),
                  ],
                ))),
      ],
    );
  }

  Widget _buildBannerMenu() {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: PhotoView(
                                  imageProvider: NetworkImage(item),
                                  backgroundDecoration: BoxDecoration(color: Colors.transparent),
                                ),
                              ),
                            );
                          },
                          child: Image.network(item, fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setJenisKelamin(jenisKelamin) {
    if (jenisKelamin == '0') {
      return 'LAKI-LAKI';
    } else {
      return 'PEREMPUAN';
    }
  }

  setJenisProduk(String produk) {
    switch (produk) {
      case "0":
        return 'PRAPENSIUN';
        break;
      case "1":
        return 'PENSIUN';
        break;
      case "2":
        return 'TAKE OVER KREDIT AKTIF BTPN';
        break;
      case "3":
        return 'PEGAWAI AKTIF PNS';
        break;
      case "4":
        return 'PEGAWAI AKTIF BUMN';
        break;
      case "5":
        return 'PEGAWAI PERGURUAN TINGGI';
        break;
      default:
        return 'NULL';
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

  messageStatus(String status) {
    if (status == '1') {
      return 'Pipeline';
    } else if (status == '2') {
      return 'Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    } else {
      return 'NULL';
    }
  }
}
