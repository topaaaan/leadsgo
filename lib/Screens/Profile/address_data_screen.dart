import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

class AddressDataScreen extends StatefulWidget {
  List personalData;
  AddressDataScreen(this.personalData);
  @override
  _AddressDataScreenState createState() => _AddressDataScreenState();
}

class _AddressDataScreenState extends State<AddressDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Alamat',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
          ),
          body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  alamatField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  kelurahanField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  kecamatanField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  kabupatenField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  // kodeposField(),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  propinsiField(),
                ],
              ))),
    );
  }

  Widget alamatField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'ALAMAT',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Text(
                  '${widget.personalData[11]}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
        ],
      ),
    );
  }

  Widget kelurahanField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'KELURAHAN',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[12]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget kecamatanField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'KECAMATAN',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[13]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget kabupatenField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'KABUPATEN',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[14]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget kodeposField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'KODEPOS',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[15]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget propinsiField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'PROPINSI',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[16]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }
}
