import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

class PersonalDataScreen extends StatefulWidget {
  List personalData;
  PersonalDataScreen(this.personalData);
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Pribadi',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
          ),
          body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  nikField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  fullNameField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  maritalStatusField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  dateOfBirthField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  placeOfBirthField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  ktpField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  genderField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  religionField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  emailField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  phoneField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  educationField()
                ],
              ))),
    );
  }

  Widget nikField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NIK',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[0]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget fullNameField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NAMA LENGKAP',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[1]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget maritalStatusField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'STATUS PERKAWINAN',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[2]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget dateOfBirthField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TANGGAL LAHIR',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[3]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget placeOfBirthField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'TEMPAT LAHIR',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[4]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget ktpField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'NO KTP',
                style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[5]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget genderField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'JENIS KELAMIN',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[6]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget religionField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'AGAMA',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[7]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget emailField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'EMAIL',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[8]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget phoneField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NO TELEPON',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[9]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget educationField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'PENDIDIKAN',
                  style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[10]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }
}
