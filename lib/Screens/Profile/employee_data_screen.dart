import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';

class EmployeeDataScreen extends StatefulWidget {
  List personalData;
  EmployeeDataScreen(this.personalData);
  @override
  _EmployeeDataScreenState createState() => _EmployeeDataScreenState();
}

class _EmployeeDataScreenState extends State<EmployeeDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Karyawan',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
          ),
          body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: ListView(
                children: <Widget>[
                  divisiField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  jabatanField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  wilayahField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  branchField(),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // statusField(),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // gradeField(),
                ],
              ))),
    );
  }

  Widget divisiField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'DIVISI',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[20]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget jabatanField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'JABATAN',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    'MR TIPE ${widget.personalData[36]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget wilayahField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'WILAYAH KERJA',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[22]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget branchField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'KANTOR CABANG',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[23]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget statusField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'STATUS KARYAWAN',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    widget.personalData[24] == 'MARKETING AGENT'
                        ? 'MARKETING REPRESENTATIVE'
                        : '${widget.personalData[24]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }

  Widget gradeField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'GRADE',
                  style: TextStyle(
                      fontFamily: 'LeadsGo-Font', color: Colors.black54),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '${widget.personalData[25]}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'LeadsGo-Font', color: Colors.black54),
                  ))),
        ],
      ),
    );
  }
}
