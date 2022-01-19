import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Voucher/tracking_voucher_screen.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:toast/toast.dart';

class ReportInsentifScreen extends StatefulWidget {
  String username;
  String nik;
  String tarif;

  ReportInsentifScreen(this.username, this.nik, this.tarif);
  @override
  _ReportInsentifScreenState createState() => _ReportInsentifScreenState();
}

class _ReportInsentifScreenState extends State<ReportInsentifScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Insentif',
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
                    'Insentif ' + bulan + ' ' + tahun,
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER,
                    backgroundColor: Colors.blueAccent,
                  );
                },
              )
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () => Provider.of<DisbursmentProvider>(context, listen: false)
                  .getDisbursment(DisbursmentItem(widget.nik)),
              color: Colors.red,
              child: Container(
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: Provider.of<DisbursmentProvider>(context, listen: false)
                      .getDisbursment(DisbursmentItem(widget.nik)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                      );
                    }
                    return Consumer<DisbursmentProvider>(
                      builder: (context, data, _) {
                        if (data.dataDisbursment.length == 0) {
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
                                double nominal = double.parse(data.dataDisbursment[i].plafond);
                                double jumlah = nominal * double.parse(widget.tarif) / 100;
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => TrackingVoucherScreen(
                                              data.dataDisbursment[i].nomorAkad,
                                              data.dataDisbursment[i].id,
                                              data.dataDisbursment[i].plafond,
                                              jumlah.toString(),
                                            )));
                                  },
                                  child: _buildCreditCard(
                                      Color(0xFF090943),
                                      formatRupiah(jumlah.toString()),
                                      data.dataDisbursment[i].debitur,
                                      data.dataDisbursment[i].tanggalPencairan,
                                      data.dataDisbursment[i].statusBayar,
                                      data.dataDisbursment[i].nomorAkad),
                                );
                              });
                        }
                      },
                    );
                  },
                ),
              ))),
    );
  }

  Widget _buildCreditCard(Color color, String cardNumber, String cardHolder, String cardExpiration,
      String status, String noAkad) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
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
            Icons.info,
            size: 20,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          Icons.check,
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
