import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/constants.dart';

class IncomeDataScreen extends StatefulWidget {
  List personalData;
  IncomeDataScreen(this.personalData);
  @override
  _IncomeDataScreenState createState() => _IncomeDataScreenState();
}

class _IncomeDataScreenState extends State<IncomeDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Pendapatan',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
          ),
          body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  gajiPokokField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  tunjanganTkdField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  tunjanganJabatanField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  tunjanganPerumahanField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  tunjanganTeleponField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  tunjanganKinerjaField(),
                ],
              ))),
    );
  }

  Widget gajiPokokField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'GAJI POKOK',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    '${formatRupiah(widget.personalData[26])}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget tunjanganTkdField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TUNJANGAN TKD',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    '${formatRupiah(widget.personalData[27])}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget tunjanganJabatanField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TUNJANGAN JABATAN',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    '${formatRupiah(widget.personalData[28])}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget tunjanganPerumahanField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TUNJANGAN PERUMAHAN',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    '${formatRupiah(widget.personalData[29])}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget tunjanganTeleponField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TUNJANGAN TELEPON',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    '${formatRupiah(widget.personalData[30])}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget tunjanganKinerjaField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TUNJANGAN KINERJA',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    '${formatRupiah(widget.personalData[31])}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
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
    return 'IDR ' + fmf.output.withoutFractionDigits;
  }
}
