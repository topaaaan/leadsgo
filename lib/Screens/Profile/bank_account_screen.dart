import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

class BankAccountDataScreen extends StatefulWidget {
  List personalData;
  BankAccountDataScreen(this.personalData);
  @override
  _BankAccountDataScreenState createState() => _BankAccountDataScreenState();
}

class _BankAccountDataScreenState extends State<BankAccountDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Rekening',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
          ),
          body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  noRekeningField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  namaBankField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  namaRekeningField(),
                ],
              ))),
    );
  }

  Widget noRekeningField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NOMOR REKENING',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[17]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget namaBankField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NAMA BANK',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[18]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget namaRekeningField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NAMA REKENING',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[19]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }
}
