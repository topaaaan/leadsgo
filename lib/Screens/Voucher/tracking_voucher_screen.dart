import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TrackingVoucherScreen extends StatefulWidget {
  @override
  _TrackingVoucherScreenState createState() => _TrackingVoucherScreenState();

  String noAkad;
  String idPencairan;
  String plafond;
  String insentif;

  TrackingVoucherScreen(
      this.noAkad, this.idPencairan, this.plafond, this.insentif);
}

class _TrackingVoucherScreenState extends State<TrackingVoucherScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getTrackingVoucher';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl),
        body: {'no_akad': widget.noAkad, 'id_pencairan': widget.idPencairan});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Tracking'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Tracking'];
          _isLoading = false;
        }
      });
    }
  }

  String _rate_insentif(dynamic user) {
    return user['rate_insentif'];
  }

  String _nama_debitur(dynamic user) {
    return user['debitur'];
  }

  String _tglDaftarLap(dynamic user) {
    return user['TGL_DAFTARLAP'];
  }

  String _statusKredit(dynamic user) {
    return user['status_kredit'];
  }

  String _tglPencairan(dynamic user) {
    return user['tgl_pencairan'];
  }

  String _jamPencairan(dynamic user) {
    return user['jam_pencairan'];
  }

  String _statusPencairan(dynamic user) {
    return user['STATUS_PENCAIRAN'];
  }

  String _sysupdatedate(dynamic user) {
    return user['sysupdatedate'];
  }

  String _approvalAkuntan(dynamic user) {
    return user['approval_akuntan'];
  }

  String _dateApproval3(dynamic user) {
    return user['date_approval_3'];
  }

  String _jamApproval3(dynamic user) {
    return user['jam_approval_3'];
  }

  String _approvalBisnis(dynamic user) {
    return user['approval_bisnis'];
  }

  String _dateApproval2(dynamic user) {
    return user['date_approval_2'];
  }

  String _jamApproval2(dynamic user) {
    return user['jam_approval_2'];
  }

  String _createdAtCallAudit(dynamic user) {
    return user['created_at_call'];
  }

  String _jam_createdAtCallAudit(dynamic user) {
    return user['time_created_at_call'];
  }

  String _createdAtApprovalFinal(dynamic user) {
    return user['created_at_call_final'];
  }

  String _jam_createdAtApprovalFinal(dynamic user) {
    return user['time_created_at_call_final'];
  }

  String _approvalSl(dynamic user) {
    return user['approval_sl'];
  }

  String _sysupdatedateSl(dynamic user) {
    return user['sysupdatedate'];
  }

  String _time_sysupdatedateSl(dynamic user) {
    return user['time_sysupdatedate'];
  }

  String _tglPembayaran(dynamic user) {
    return user['tgl_pembayaran'];
  }

  String _jam_tglPembayaran(dynamic user) {
    return user['time_tgl_pembayaran'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.noAkad);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: leadsGoColor,
        title: Text(
          'Tracking Insentif',
          style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 0),
        color: Colors.white,
        child: _buildList(),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(
            // horizontal: 15,
            // vertical: 10,
            ),
        // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Form(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      top: 12.0,
                      right: 16.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      'Rincian Insentif',
                      style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 10.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Jumlah Plafond',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  formatRupiah(widget.plafond),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Tarif Insentif',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  'x    ' +
                                      setNull(_rate_insentif(_users[index])) +
                                      ' %',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      top: 8.0,
                      right: 16.0,
                      bottom: 8.0,
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         bottom: BorderSide(
                    //   color: Colors.black12,
                    // ))),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Total Insentif',
                              style: TextStyle(
                                fontFamily: 'LeadsGo-Font',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  formatRupiah(widget.insentif),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'LeadsGo-Font',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: _tglPembayaran(_users[index]) != null
                                        ? Colors.black
                                        : Colors.black12,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ));
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 10.0, right: 16.0),
                    child: Text(
                      'Info Aplikasi',
                      style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'No. Rekening',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  widget.noAkad,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Atas Nama',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  setNullStipe(_nama_debitur(_users[index])),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Tanggal Pencairan',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  setNullStipe(_tglPencairan(_users[index])),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Status Kredit',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  setNullStipe(_statusKredit(_users[index])),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Plafond',
                              style: TextStyle(
                                  fontFamily: 'LeadsGo-Font',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  formatRupiah(widget.plafond),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'LeadsGo-Font',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: Colors.black54),
                                ))),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 7,
                    // indent: 16,
                    // endIndent: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      top: 12.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      'Status Insentif',
                      style: TextStyle(
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 20.0),
                    child: ListBody(
                      children: <Widget>[
                        // PENCAIRAN -----------------------------------------------
                        _tglDaftarLap(_users[index]) != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _tglPencairan(_users[index])) +
                                        ' ' +
                                        setNull(_jamPencairan(_users[index])),
                                    child: Icon(
                                      MdiIcons.calendarCheckOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Pencairan ',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              ' | ' +
                                                  setNullStipe(_tglPencairan(
                                                      _users[index])),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      setNullStipe(
                                              _jamPencairan(_users[index])) +
                                          ' WIB',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _tglPencairan(_users[index])) +
                                        ' ' +
                                        setNull(_jamPencairan(_users[index])),
                                    child: Icon(
                                      MdiIcons.calendarRemoveOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Pencairan',
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _tglDaftarLap(_users[index]) != null
                                ? Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: _tglDaftarLap(_users[index]) !=
                                                  null
                                              ? Colors.green
                                              : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.70,
                                      child: Text(
                                        'Laporan pencairan berhasil disubmit.\nPastikan status kredit Top Up / New Loan / Take Over.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: _tglDaftarLap(_users[index]) !=
                                                  null
                                              ? Colors.green
                                              : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        // ./PENCAIRAN -----------------------------------------------

                        // SALES LEADER -----------------------------------------------
                        _statusPencairan(_users[index]) == 'success'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _sysupdatedateSl(_users[index])) +
                                        ' ' +
                                        setNull(_time_sysupdatedateSl(
                                            _users[index])),
                                    child: Icon(
                                      MdiIcons.checkCircleOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Sales Leader',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              // ' | ' + setNullStipe(_sysupdatedateSl(_users[index])),
                                              ' - System Approval',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width * 0.20,
                                  //   child: Text(
                                  //     setNull(_time_sysupdatedateSl(_users[index])) + ' WIB',
                                  //     textAlign: TextAlign.right,
                                  //     style: TextStyle(
                                  //       fontFamily: 'LeadsGo-Font',
                                  //       fontWeight: FontWeight.normal,
                                  //       fontSize: 12,
                                  //       color: Colors.black45,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _tglPencairan(_users[index])) +
                                        ' ' +
                                        setNull(_jamPencairan(_users[index])),
                                    child: Icon(
                                      MdiIcons.circleEditOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Sales Leader',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                        Row(
                          children: <Widget>[
                            _statusPencairan(_users[index]) == 'success'
                                ? Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              _statusPencairan(_users[index]) !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Laporan pencairan telah disetujui Sales Leader.\nPastikan nominal plafond sesuai dengan SPPK.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              _statusPencairan(_users[index]) ==
                                                      'success'
                                                  ? Colors.green
                                                  : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Persetujuan sales leader.\nUntuk melanjutkan verifikasi akutansi.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        // ./SALES LEADER -----------------------------------------------

                        // AKUNTANSI-----------------------------------------------
                        _approvalAkuntan(_users[index]) != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _dateApproval3(_users[index])) +
                                        ' ' +
                                        setNull(_jamApproval3(_users[index])),
                                    child: Icon(
                                      MdiIcons.checkCircleOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Verifikasi Akuntan',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              ' | ' +
                                                  setNullStipe(_dateApproval3(
                                                      _users[index])),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      setNullStipe(
                                              _jamApproval3(_users[index])) +
                                          ' WIB',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _dateApproval3(_users[index])) +
                                        ' ' +
                                        setNull(_jamApproval3(_users[index])),
                                    child: Icon(
                                      MdiIcons.circleEditOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Verifikasi Akuntan',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                        Row(
                          children: <Widget>[
                            _approvalAkuntan(_users[index]) != null
                                ? Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              _approvalAkuntan(_users[index]) !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Diverifikasi tim akuntansi.\nPastikan dokumen yang di upload sudah benar.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              _approvalAkuntan(_users[index]) !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Verifikasi akuntansi.\nKhusus pencairan Top Up : Plafond - Sisa hutang.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        // ./AKUNTANSI -----------------------------------------------

                        // SALES MARKETING HEAD -----------------------------------------------
                        _approvalBisnis(_users[index]) != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _dateApproval2(_users[index])) +
                                        ' ' +
                                        setNull(_jamApproval2(_users[index])),
                                    child: Icon(
                                      MdiIcons.checkCircleOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Sales & Marketing Head',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              ' | ' +
                                                  setNullStipe(_dateApproval2(
                                                      _users[index])),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      setNullStipe(
                                              _jamApproval2(_users[index])) +
                                          ' WIB',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                            _dateApproval3(_users[index])) +
                                        ' ' +
                                        setNull(_jamApproval3(_users[index])),
                                    child: Icon(
                                      MdiIcons.circleEditOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Sales & Marketing Head',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                        Row(
                          children: <Widget>[
                            _approvalBisnis(_users[index]) != null
                                ? Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              _approvalBisnis(_users[index]) !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Disetujui oleh Sales & Marketing Head.\nPastikan nomor HP debitur benar & bisa dihubungi',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              _approvalBisnis(_users[index]) !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Persetujuan Sales & Marketing Head.\nSelanjutnya, audit call after sales ke nomor HP debitur.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        // ./SALES MARKETING HEAD -----------------------------------------------

                        // CALL AUDIT -----------------------------------------------
                        _createdAtCallAudit(_users[index]) != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(_createdAtCallAudit(
                                            _users[index])) +
                                        ' ' +
                                        setNull(_jam_createdAtCallAudit(
                                            _users[index])),
                                    child: Icon(
                                      MdiIcons.phoneCheckOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Audit Call',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              ' | ' +
                                                  setNullStipe(
                                                      _createdAtCallAudit(
                                                          _users[index])),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      setNullStipe(_jam_createdAtCallAudit(
                                              _users[index])) +
                                          ' WIB',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(_createdAtCallAudit(
                                            _users[index])) +
                                        ' ' +
                                        setNull(_jam_createdAtCallAudit(
                                            _users[index])),
                                    child: Icon(
                                      MdiIcons.phoneCheckOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Audit Call',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                        Row(
                          children: <Widget>[
                            _createdAtCallAudit(_users[index]) != null
                                ? Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: _createdAtCallAudit(
                                                      _users[index]) !=
                                                  null
                                              ? Colors.green
                                              : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Audit Call ke debitur telah berhasil.\nSelanjutnya akan menunggu persetujuan akhir.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: _createdAtCallAudit(
                                                      _users[index]) !=
                                                  null
                                              ? Colors.green
                                              : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Audit Call belum berhasil.\nAda kemungkinan nomor salah / tidak bisa dihubungi.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        // ./CALL AUDIT -----------------------------------------------

                        // APPROVAL FINAL -----------------------------------------------
                        _createdAtApprovalFinal(_users[index]) != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(_createdAtApprovalFinal(
                                            _users[index])) +
                                        ' ' +
                                        setNull(_jam_createdAtApprovalFinal(
                                            _users[index])),
                                    child: Icon(
                                      MdiIcons.checkCircleOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Approval Final',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              ' | ' +
                                                  setNullStipe(
                                                      _createdAtApprovalFinal(
                                                          _users[index])),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      setNullStipe(_jam_createdAtApprovalFinal(
                                              _users[index])) +
                                          ' WIB',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(_createdAtApprovalFinal(
                                            _users[index])) +
                                        ' ' +
                                        setNull(_jam_createdAtApprovalFinal(
                                            _users[index])),
                                    child: Icon(
                                      MdiIcons.circleEditOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Approval Final',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                        Row(
                          children: <Widget>[
                            _createdAtApprovalFinal(_users[index]) != null
                                ? Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: _createdAtApprovalFinal(
                                                      _users[index]) !=
                                                  null
                                              ? Colors.green
                                              : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Laporan Pencairan telah disetujui Direksi.\nSelanjutnya proses pembayaran insentif ke rekening anda.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(
                                      left: 9,
                                    ),
                                    height: 25,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: _createdAtApprovalFinal(
                                                      _users[index]) !=
                                                  null
                                              ? Colors.green
                                              : Colors.grey[400],
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                        'Proses akhir persetujuan laporan pencairan.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        // ./APPROVAL FINAL -----------------------------------------------

                        // PEMBAYARAN -----------------------------------------------
                        int.parse(_approvalSl(_users[index])) == 4
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNullStipe(
                                        _tglPembayaran(_users[index])),
                                    child: Icon(
                                      MdiIcons.creditCardCheckOutline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Pembayaran',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              ' | ' +
                                                  setNullStipe(_tglPembayaran(
                                                      _users[index])),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      setNullStipe(_jam_tglPembayaran(
                                              _users[index])) +
                                          ' WIB',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: setNull(
                                        _jam_tglPembayaran(_users[index])),
                                    child: Icon(
                                      MdiIcons.creditCardCheckOutline,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start, //Center Row contents horizontally,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Pembayaran',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'LeadsGo-Font',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                        Row(
                          children: <Widget>[
                            int.parse(_approvalSl(_users[index])) == 4
                                ? Container(
                                    padding: const EdgeInsets.only(
                                      left: 30.0,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    child: Text(
                                      'Selamat! Insentif telah berhasil ditransfer.\nSilahkan cek pada rekening yang terdaftar.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'LeadsGo-Font',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.black45),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    child: Text(
                                      'Insentif masih dalam proses\nMohon menunggu.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  )
                          ],
                        ),

                        // ./PEMBAYARAN -----------------------------------------------
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {}
    }
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'Rp ' + fmf.output.withoutFractionDigits;
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty || data == 'NULL') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setNullStipe(String data) {
    if (data == null ||
        data == '' ||
        data.isEmpty ||
        data == 'NULL' ||
        data == '00-00-0000' ||
        data == '00:00') {
      return '-';
    } else {
      return data;
    }
  }
}
