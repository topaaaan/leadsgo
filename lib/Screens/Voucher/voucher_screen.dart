import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Voucher/tracking_voucher_screen.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_provider.dart';
import 'package:leadsgo_apps/Screens/provider/disbursmentA_provider.dart';
import 'package:leadsgo_apps/Screens/provider/disbursmentC_provider.dart';
import 'package:leadsgo_apps/Screens/provider/disbursmentCPlus_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class VoucherScreen extends StatefulWidget {
  String username;
  String nik;
  String tarif;
  String tipe;

  VoucherScreen(this.username, this.nik, this.tarif, this.tipe);
  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Pilih Data Insentif !',
              style: TextStyle(
                fontFamily: 'CourrierPrime',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: (widget.tipe.toString() != 'C Plus')
                ? <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Toast.show(
                          'Insentif ' + bulan + ' ' + tahun,
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.CENTER,
                          backgroundColor: Colors.blueAccent,
                        );
                      },
                    )
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VoucherScreenCPlus(widget.nik)));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                          // color: Colors.black45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white24,
                          ),

                          child: Row(
                            children: <Widget>[
                              Text(
                                "Rincian Pendapatan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "LeadsGo-Font",
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                MdiIcons.arrowRight,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
          body: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<DisbursmentProvider>(context, listen: false)
                      .getDisbursment(DisbursmentItem(widget.nik)),
              color: Colors.red,
              child: FadeAnimation(
                  0.5,
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: Provider.of<DisbursmentProvider>(context,
                              listen: false)
                          .getDisbursment(DisbursmentItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    leadsGoColor)),
                          );
                        }
                        return Consumer<DisbursmentProvider>(
                          builder: (context, data, _) {
                            print(data.dataDisbursment.length);
                            if (data.dataDisbursment.length == 0) {
                              return Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Icon(Icons.hourglass_empty,
                                                size: 70),
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
                                    ]),
                              );
                            } else {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.dataDisbursment.length,
                                  itemBuilder: (context, i) {
                                    double nominal = double.parse(
                                        data.dataDisbursment[i].plafond);
                                    double jumlah = nominal *
                                        double.parse(
                                            data.dataDisbursment[i].tarif) /
                                        100;
                                    // double jumlah = nominal * double.parse(widget.tarif) / 100;
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrackingVoucherScreen(
                                                      data.dataDisbursment[i]
                                                          .nomorAkad,
                                                      data.dataDisbursment[i]
                                                          .id,
                                                      data.dataDisbursment[i]
                                                          .plafond,
                                                      jumlah.toString(),
                                                    )));
                                      },
                                      child: _buildCreditCard(
                                          Color(0xFF090943),
                                          formatRupiah(jumlah.toString()),
                                          data.dataDisbursment[i].debitur,
                                          data.dataDisbursment[i]
                                              .tanggalPencairan,
                                          data.dataDisbursment[i].statusBayar,
                                          data.dataDisbursment[i].nomorAkad),
                                    );
                                  });
                            }
                          },
                        );
                      },
                    ),
                  )))),
    );
  }

  Widget _buildCreditCard(Color color, String cardNumber, String cardHolder,
      String cardExpiration, String status, String noAkad) {
    return Card(
      elevation: 4.0,
      // color: insentifCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            gradient: status != '0'
                ? LinearGradient(
                    begin: Alignment.bottomLeft, end: Alignment.topRight,
                    // Add one stop for each color
                    // Values should increase from 0.0 to 1.0
                    stops: [0.1, 0.7],
                    colors: [leadsGoColor, Colors.deepOrange[300]],
                  )
                : LinearGradient(
                    begin: Alignment.bottomLeft, end: Alignment.topRight,
                    // Add one stop for each color
                    // Values should increase from 0.0 to 1.0
                    stops: [0.1, 0.7], colors: [Colors.black54, Colors.black26],
                  )),
        height: 150,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(status, noAkad),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourrierPrime',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock('DEBITUR', cardHolder),
                _buildDetailsBlock('INPUT', cardExpiration),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsBlock(String label, String value) {
    if (value.length <= 25) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value.substring(0, 20) + '...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }
  }

  Widget _buildLogosBlock(status, noAkad) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Tooltip(
            message: noAkad,
            child: Icon(
              MdiIcons.bank,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        iconStatus(status)
      ],
    );
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Belum Dibayar';
    } else {
      return 'Sudah Dibayar';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Tooltip(
          message: messageStatus(status),
          child: Icon(
            MdiIcons.progressCheck,
            size: 20,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.checkBold,
          size: 20,
          color: Colors.white,
        ),
      );
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

class VoucherScreenA extends StatefulWidget {
  String nik;

  VoucherScreenA(this.nik);
  @override
  _VoucherScreenAState createState() => _VoucherScreenAState();
}

class _VoucherScreenAState extends State<VoucherScreenA> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Estimasi Gaji Saya',
              style: TextStyle(
                fontFamily: 'CourrierPrime',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Toast.show(
                    'Gaji Dibayarkan Tanggal 3 ' + bulanDepan,
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER,
                    backgroundColor: leadsGoColor,
                  );
                },
              )
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<DisbursmentAProvider>(context, listen: false)
                      .getDisbursmentA(DisbursmentAItem(widget.nik)),
              color: leadsGoColor,
              child: FadeAnimation(
                  0.5,
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: Provider.of<DisbursmentAProvider>(context,
                              listen: false)
                          .getDisbursmentA(DisbursmentAItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    leadsGoColor)),
                          );
                        }
                        return Consumer<DisbursmentAProvider>(
                          builder: (context, data, _) {
                            return Container(
                              decoration: BoxDecoration(color: Colors.white54),
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                children: <Widget>[
                                  _buildCreditCardA(
                                      formatRupiah(data
                                          .dataDisbursmentA[0].income
                                          .toString()),
                                      data.dataDisbursmentA[0].statusGaji,
                                      data.dataDisbursmentA[0].idStatusGaji),
                                  Container(
                                    padding: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.person,
                                              color: leadsGoColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Detail',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: leadsGoColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Pencairan Saya Bulan Ini',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentA[0].plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentA[0].nasabah} Debitur',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Target',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentA[0].target.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Selisih',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah((double.parse(data.dataDisbursmentA[0].plafond) - double.parse(data.dataDisbursmentA[0].target)).toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rate Insentif',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentA[0].rate}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Insentif',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentA[0].insentif.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Gaji',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentA[0].gaji.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Income',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentA[0].income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.note,
                                              color: Colors.redAccent,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Notes :',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Selisih = pencairan - target.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Gaji tidak akan keluar jika belum mencapai target.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Pencairan yang diperhitungkan, hanya yang berstatus New Loan atau Take Over saja.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Jika mencapai target, perhitungan insentif = selisih x rate insentif.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Jika tidak mencapai target, perhitungan insentif = total pencairan x rate insentif.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Total income dihitung dari gaji + insentif.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Jika ada pertanyaan silahkan hubungi IT Support Kami (MALA : 081318367541)',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )))),
    );
  }

  Widget _buildCreditCardA(
      String cardNumber, String cardHolder, String status) {
    return Card(
      elevation: 4.0,
      // color: insentifCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            gradient: status != '0'
                ? LinearGradient(
                    begin: Alignment.bottomLeft, end: Alignment.topRight,
                    // Add one stop for each color
                    // Values should increase from 0.0 to 1.0
                    stops: [0.1, 0.7],
                    colors: [leadsGoColor, Colors.deepOrange[300]],
                  )
                : LinearGradient(
                    begin: Alignment.bottomLeft, end: Alignment.topRight,
                    // Add one stop for each color
                    // Values should increase from 0.0 to 1.0
                    stops: [0.1, 0.7], colors: [Colors.black54, Colors.black26],
                  )),
        height: 150,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(status),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourrierPrime',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildDetailsBlock('STATUS', cardHolder),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildLogosBlock(status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Icon(
            MdiIcons.piggyBank,
            size: 20,
            color: Colors.white,
          ),
        ),
        iconStatus(status)
      ],
    );
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Belum Dibayar';
    } else {
      return 'Sudah Dibayar';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.progressCheck,
          size: 20,
          color: Colors.white,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.checkBold,
          size: 20,
          color: Colors.white,
        ),
      );
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
    return 'Rp. ' + fmf.output.withoutFractionDigits;
  }
}

class VoucherScreenC extends StatefulWidget {
  String nik;

  VoucherScreenC(this.nik);
  @override
  _VoucherScreenCState createState() => _VoucherScreenCState();
}

class _VoucherScreenCState extends State<VoucherScreenC> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Estimasi Gaji',
              style: TextStyle(
                fontFamily: 'CourrierPrime',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Toast.show(
                    'Sisa Insentif Dibayarkan Tanggal 5 ' + bulanDepan,
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER,
                    backgroundColor: leadsGoColor,
                  );
                },
              )
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<DisbursmentCProvider>(context, listen: false)
                      .getDisbursmentC(DisbursmentCItem(widget.nik)),
              color: leadsGoColor,
              child: FadeAnimation(
                  0.5,
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: Provider.of<DisbursmentCProvider>(context,
                              listen: false)
                          .getDisbursmentC(DisbursmentCItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    leadsGoColor)),
                          );
                        }
                        return Consumer<DisbursmentCProvider>(
                          builder: (context, data, _) {
                            print(data.dataDisbursmentC.length);
                            return Container(
                              decoration: BoxDecoration(color: Colors.white54),
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                children: <Widget>[
                                  _buildCreditCardC(formatRupiah(
                                      data.dataDisbursmentC[0].thp.toString())),
                                  Container(
                                    padding: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.person,
                                              color: leadsGoColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Detail',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: leadsGoColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Pencairan New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].new_to_plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentC[0].new_to_noa}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rate Insentif New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentC[0].new_to_rate}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Income dari New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].new_to_income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Pencairan Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].top_up_plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentC[0].top_up_noa}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rate Insentif Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentC[0].top_up_rate}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Income dari Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].top_up_income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Pencairan',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentC[0].noa}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Transport',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].transport.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Income',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Take Home Pay',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentC[0].thp.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.note,
                                              color: Colors.redAccent,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Notes :',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Pembayaran Gaji akan dibayarkan tanggal 5 setiap bulannya.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Jika ada pertanyaan silahkan hubungi IT Support Kami (MALA : 081318367541)',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )))),
    );
  }

  Widget _buildCreditCardC(String cardNumber) {
    return Card(
      elevation: 4.0,
      // color: insentifCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.7],
              colors: [leadsGoColor, Colors.deepOrange[300]],
            )),
        height: 150,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourrierPrime',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Icon(
            MdiIcons.piggyBank,
            size: 20,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Icon(
            MdiIcons.checkBold,
            size: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
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
    return 'Rp. ' + fmf.output.withoutFractionDigits;
  }
}

class VoucherScreenCPlus extends StatefulWidget {
  String nik;

  VoucherScreenCPlus(this.nik);
  @override
  _VoucherScreenCPlusState createState() => _VoucherScreenCPlusState();
}

class _VoucherScreenCPlusState extends State<VoucherScreenCPlus> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Estimasi Sisa Insentif',
              style: TextStyle(
                fontFamily: 'CourrierPrime',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Toast.show(
                    'Sisa Insentif Dibayarkan Tanggal 3 ' + bulanDepan,
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER,
                    backgroundColor: leadsGoColor,
                  );
                },
              )
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<DisbursmentCPlusProvider>(context, listen: false)
                      .getDisbursmentCPlus(DisbursmentCPlusItem(widget.nik)),
              color: leadsGoColor,
              child: FadeAnimation(
                  0.5,
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: Provider.of<DisbursmentCPlusProvider>(context,
                              listen: false)
                          .getDisbursmentCPlus(
                              DisbursmentCPlusItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    leadsGoColor)),
                          );
                        }
                        return Consumer<DisbursmentCPlusProvider>(
                          builder: (context, data, _) {
                            print(data.dataDisbursmentCPlus.length);
                            return Container(
                              decoration: BoxDecoration(color: Colors.white54),
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                children: <Widget>[
                                  _buildCreditCardCPlus(formatRupiah(data
                                      .dataDisbursmentCPlus[0].sisa
                                      .toString())),
                                  Container(
                                    padding: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.person,
                                              color: leadsGoColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Detail',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: leadsGoColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Pencairan New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].new_to_plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentCPlus[0].new_to_noa}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rate Insentif New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentCPlus[0].new_to_rate}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Income dari New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].new_to_income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Transport dari New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].new_to_transport.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Pencairan Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].top_up_plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentCPlus[0].top_up_noa}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rate Insentif Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentCPlus[0].top_up_rate}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Income dari Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].top_up_income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Transport dari Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].top_up_transport.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Pencairan',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].plafond.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Debitur',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${data.dataDisbursmentCPlus[0].noa}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Transport',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].transport.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Total Income',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].income.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Take Home Pay',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].thp.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Telah dibayarkan New Loan & Take Over',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].new_to_done.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Telah dibayarkan Top Up',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].top_up_done.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Sisa pembayaran income',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '${formatRupiah(data.dataDisbursmentCPlus[0].sisa.toString())}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'LeadsGo-Font'),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.note,
                                              color: Colors.redAccent,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Notes :',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'LeadsGo-Font',
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Pembayaran Sisa Insentif akan dibayarkan tanggal 3 setiap bulannya.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '- Jika ada pertanyaan silahkan hubungi IT Support Kami (MALA : 081318367541)',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'LeadsGo-Font'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )))),
    );
  }

  Widget _buildCreditCardCPlus(String cardNumber) {
    return Card(
      elevation: 4.0,
      // color: insentifCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.7],
              colors: [leadsGoColor, Colors.deepOrange[300]],
            )),
        height: 150,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourrierPrime',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Icon(
            MdiIcons.piggyBank,
            size: 20,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Icon(
            MdiIcons.checkBold,
            size: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
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
    return 'Rp. ' + fmf.output.withoutFractionDigits;
  }
}
