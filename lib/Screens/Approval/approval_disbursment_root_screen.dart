import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_pencairan_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/approval_disbursment_agen_provider.dart';
import 'package:leadsgo_apps/Screens/provider/approval_disbursment_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:provider/provider.dart';

class ApprovalDisbursmentRootPage extends StatefulWidget {
  String username;
  String nik;
  String nikSdm;

  ApprovalDisbursmentRootPage(this.username, this.nik, this.nikSdm);
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<ApprovalDisbursmentRootPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: AppBar(
                backgroundColor: leadsGoColor,
                title: Center(
                  child: Text(
                    'Approval Pencairan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'LeadsGo-Font',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                actions: <Widget>[],
                bottom: TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      text: 'Marketing',
                    ),
                    Tab(
                      text: 'Agent',
                    )
                  ],
                ),
              ),
            ),
            body: TabBarView(children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: FutureBuilder(
                  future: Provider.of<ApprovalDisbursmentProvider>(context, listen: false)
                      .getApprovalDisbursment(ApprovalDisbursmentItem(widget.nikSdm)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                      );
                    }
                    return Consumer<ApprovalDisbursmentProvider>(
                      builder: (context, data, _) {
                        print(data.dataApprovalDisbursment.length);
                        if (data.dataApprovalDisbursment.length == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Column(children: <Widget>[
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
                                    'Approval Pencairan Yuk!',
                                    style: TextStyle(
                                        fontFamily: "LeadsGo-Font",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Pencairan marketing tidak tersedia.',
                                    style: TextStyle(
                                      fontFamily: "LeadsGo-Font",
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.dataApprovalDisbursment.length,
                                    itemBuilder: (context, i) {
                                      String namaSales;
                                      if (data.dataApprovalDisbursment[i].namaSales.length > 15) {
                                        namaSales = data.dataApprovalDisbursment[i].namaSales
                                            .substring(0, 15);
                                      } else {
                                        namaSales =
                                            namaSales = data.dataApprovalDisbursment[i].namaSales;
                                      }
                                      String debitur;
                                      if (data.dataApprovalDisbursment[i].debitur.length > 15) {
                                        debitur = data.dataApprovalDisbursment[i].debitur
                                            .substring(0, 15);
                                      } else {
                                        debitur = data.dataApprovalDisbursment[i].debitur;
                                      }
                                      return Container(
                                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApprovalDisbursmentViewScreen(
                                                        widget.username,
                                                        widget.nik,
                                                        widget.nikSdm,
                                                        data.dataApprovalDisbursment[i].id,
                                                        data.dataApprovalDisbursment[i].debitur,
                                                        data.dataApprovalDisbursment[i].alamat,
                                                        data.dataApprovalDisbursment[i].telepon,
                                                        data.dataApprovalDisbursment[i].tanggalAkad,
                                                        data.dataApprovalDisbursment[i].nomorAkad,
                                                        data.dataApprovalDisbursment[i].noJanji,
                                                        data.dataApprovalDisbursment[i].plafond,
                                                        data.dataApprovalDisbursment[i]
                                                            .jenisPencairan,
                                                        data.dataApprovalDisbursment[i].jenisProduk,
                                                        data.dataApprovalDisbursment[i].cabang,
                                                        data.dataApprovalDisbursment[i].infoSales,
                                                        data.dataApprovalDisbursment[i].foto1,
                                                        data.dataApprovalDisbursment[i].foto2,
                                                        data.dataApprovalDisbursment[i].foto3,
                                                        data.dataApprovalDisbursment[i]
                                                            .tanggalPencairan,
                                                        data.dataApprovalDisbursment[i]
                                                            .jamPencairan,
                                                        data.dataApprovalDisbursment[i].namaTl,
                                                        data.dataApprovalDisbursment[i].jabatanTl,
                                                        data.dataApprovalDisbursment[i].teleponTl,
                                                        data.dataApprovalDisbursment[i].namaSales,
                                                        data.dataApprovalDisbursment[i].cabang,
                                                        data.dataApprovalDisbursment[i].infoSales,
                                                        data.dataApprovalDisbursment[i]
                                                            .statusPipeline,
                                                        data.dataApprovalDisbursment[i]
                                                            .statusKredit,
                                                        data.dataApprovalDisbursment[i]
                                                            .pengelolaPensiun,
                                                        data.dataApprovalDisbursment[i]
                                                            .bankTakeover,
                                                        data.dataApprovalDisbursment[i]
                                                            .tanggalPenyerahan,
                                                        data.dataApprovalDisbursment[i]
                                                            .namaPenerima,
                                                        data.dataApprovalDisbursment[i]
                                                            .teleponPenerima,
                                                        data.dataApprovalDisbursment[i]
                                                            .tanggalPipeline,
                                                        data.dataApprovalDisbursment[i].tempatLahir,
                                                        data.dataApprovalDisbursment[i]
                                                            .tanggalLahir,
                                                        data.dataApprovalDisbursment[i]
                                                            .jenisKelamin,
                                                        data.dataApprovalDisbursment[i].noKtp,
                                                        data.dataApprovalDisbursment[i].npwp,
                                                        data.dataApprovalDisbursment[i].kodeProduk,
                                                      )));
                                            },
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Tooltip(
                                                    message: messageStatus(
                                                        '${data.dataApprovalDisbursment[i].statusPencairan}'),
                                                    child: Icon(
                                                      iconStatus(
                                                          '${data.dataApprovalDisbursment[i].statusPencairan}'),
                                                      color: colorStatus(
                                                          '${data.dataApprovalDisbursment[i].statusPencairan}'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    namaSales,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'LeadsGo-Font'),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Nasabah : $debitur',
                                                          style: TextStyle(
                                                              fontStyle: FontStyle.italic,
                                                              fontFamily: 'LeadsGo-Font'),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Plafond : ${formatRupiah(data.dataApprovalDisbursment[i].plafond)}',
                                                          style: TextStyle(
                                                              fontStyle: FontStyle.italic,
                                                              fontFamily: 'LeadsGo-Font'),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              trailing: Text(
                                                '${data.dataApprovalDisbursment[i].tanggalAkad}',
                                                style: fontFamily,
                                              ),
                                            ),
                                          ));
                                    }),
                              )
                            ],
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: FutureBuilder(
                  future: Provider.of<ApprovalDisbursmentAgenProvider>(context, listen: false)
                      .getApprovalDisbursmentAgen(ApprovalDisbursmentAgenItem(widget.nikSdm)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                      );
                    }
                    return Consumer<ApprovalDisbursmentAgenProvider>(
                      builder: (context, data, _) {
                        print(data.dataApprovalDisbursmentAgen.length);
                        if (data.dataApprovalDisbursmentAgen.length == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Column(children: <Widget>[
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
                                    'Approval Pencairan Yuk!',
                                    style: TextStyle(
                                        fontFamily: "LeadsGo-Font",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Pencairan agent tidak tersedia.',
                                    style: TextStyle(
                                      fontFamily: "LeadsGo-Font",
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.dataApprovalDisbursmentAgen.length,
                                    itemBuilder: (context, i) {
                                      String namaSales;
                                      if (data.dataApprovalDisbursmentAgen[i].namaSales.length >
                                          15) {
                                        namaSales = data.dataApprovalDisbursmentAgen[i].namaSales
                                            .substring(0, 15);
                                      } else {
                                        namaSales = namaSales =
                                            data.dataApprovalDisbursmentAgen[i].namaSales;
                                      }
                                      String debitur;
                                      if (data.dataApprovalDisbursmentAgen[i].debitur.length > 15) {
                                        debitur = data.dataApprovalDisbursmentAgen[i].debitur
                                            .substring(0, 15);
                                      } else {
                                        debitur = data.dataApprovalDisbursmentAgen[i].debitur;
                                      }
                                      return Container(
                                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApprovalDisbursmentViewScreen(
                                                        widget.username,
                                                        widget.nik,
                                                        widget.nikSdm,
                                                        data.dataApprovalDisbursmentAgen[i].id,
                                                        data.dataApprovalDisbursmentAgen[i].debitur,
                                                        data.dataApprovalDisbursmentAgen[i].alamat,
                                                        data.dataApprovalDisbursmentAgen[i].telepon,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .tanggalAkad,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .nomorAkad,
                                                        data.dataApprovalDisbursmentAgen[i].noJanji,
                                                        data.dataApprovalDisbursmentAgen[i].plafond,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .jenisPencairan,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .jenisProduk,
                                                        data.dataApprovalDisbursmentAgen[i].cabang,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .infoSales,
                                                        data.dataApprovalDisbursmentAgen[i].foto1,
                                                        data.dataApprovalDisbursmentAgen[i].foto2,
                                                        data.dataApprovalDisbursmentAgen[i].foto3,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .tanggalPencairan,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .jamPencairan,
                                                        data.dataApprovalDisbursmentAgen[i].namaTl,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .jabatanTl,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .teleponTl,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .namaSales,
                                                        data.dataApprovalDisbursmentAgen[i].cabang,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .infoSales,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .statusPipeline,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .statusKredit,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .pengelolaPensiun,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .bankTakeover,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .tanggalPenyerahan,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .namaPenerima,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .teleponPenerima,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .tanggalPipeline,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .tempatLahir,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .tanggalLahir,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .jenisKelamin,
                                                        data.dataApprovalDisbursmentAgen[i].noKtp,
                                                        data.dataApprovalDisbursmentAgen[i].npwp,
                                                        data.dataApprovalDisbursmentAgen[i]
                                                            .kodeProduk,
                                                      )));
                                            },
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Tooltip(
                                                    message: messageStatus(
                                                        '${data.dataApprovalDisbursmentAgen[i].statusPencairan}'),
                                                    child: Icon(
                                                      iconStatus(
                                                          '${data.dataApprovalDisbursmentAgen[i].statusPencairan}'),
                                                      color: colorStatus(
                                                          '${data.dataApprovalDisbursmentAgen[i].statusPencairan}'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    namaSales,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'LeadsGo-Font'),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Nasabah : $debitur',
                                                          style: TextStyle(
                                                              fontStyle: FontStyle.italic,
                                                              fontFamily: 'LeadsGo-Font'),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Plafond : ${formatRupiah(data.dataApprovalDisbursmentAgen[i].plafond)}',
                                                          style: TextStyle(
                                                              fontStyle: FontStyle.italic,
                                                              fontFamily: 'LeadsGo-Font'),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              trailing: Text(
                                                '${data.dataApprovalDisbursmentAgen[i].tanggalAkad}',
                                                style: fontFamily,
                                              ),
                                            ),
                                          ));
                                    }),
                              )
                            ],
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  messageStatus(String status) {
    if (status == 'waiting') {
      return 'Menunggu Persetujuan';
    } else if (status == 'success') {
      return 'Disetujui Sales Leader';
    } else if (status == 'failed') {
      return 'Ditolak Sales Leader';
    } else {
      return 'Menunggu Persetujuan';
    }
  }

  iconStatus(String status) {
    if (status == 'waiting') {
      return Icons.info;
    } else if (status == 'success') {
      return Icons.check;
    } else if (status == 'failed') {
      return Icons.cancel;
    } else {
      return Icons.info;
    }
  }

  colorStatus(String status) {
    if (status == 'waiting') {
      return Colors.blue;
    } else if (status == 'success') {
      return Colors.green;
    } else if (status == 'failed') {
      return Colors.red;
    } else {
      return Colors.blue;
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
}
