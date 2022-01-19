import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_interaksi_view_screen.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/approval_interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class ApprovalInteractionScreen extends StatefulWidget {
  @override
  _ApprovalInteractionScreen createState() => _ApprovalInteractionScreen();

  String username;
  String nik;
  String hakAkses;
  String nikSdm;

  ApprovalInteractionScreen(this.username, this.nik, this.hakAkses, this.nikSdm);
}

class _ApprovalInteractionScreen extends State<ApprovalInteractionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Approval Interaksi',
            style: fontFamily,
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<ApprovalInteractionProvider>(context, listen: false)
                .getApprovalInteraction(ApprovalInteractionItem(widget.nikSdm)),
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                future: Provider.of<ApprovalInteractionProvider>(context, listen: false)
                    .getApprovalInteraction(ApprovalInteractionItem(widget.nikSdm)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<ApprovalInteractionProvider>(
                    builder: (context, data, _) {
                      print(data.dataApprovalInteraction.length);
                      if (data.dataApprovalInteraction.length == 0) {
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
                              'Approval Interaksi Yuk!',
                              style: TextStyle(
                                  fontFamily: "LeadsGo-Font",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Interaksi tim kamu tidak tersedia.',
                              style: TextStyle(
                                fontFamily: "LeadsGo-Font",
                                fontSize: 12,
                              ),
                            ),
                          ]),
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: data.dataApprovalInteraction.length,
                                itemBuilder: (context, i) {
                                  String nama;
                                  if (data.dataApprovalInteraction[i].namaSales.length > 15) {
                                    nama =
                                        data.dataApprovalInteraction[i].namaSales.substring(0, 15);
                                  } else {
                                    nama = data.dataApprovalInteraction[i].namaSales;
                                  }
                                  String debitur;
                                  if (data.dataApprovalInteraction[i].calonDebitur.length > 15) {
                                    debitur = data.dataApprovalInteraction[i].calonDebitur
                                        .substring(0, 15);
                                  } else {
                                    debitur = data.dataApprovalInteraction[i].calonDebitur;
                                  }
                                  return Card(
                                    elevation: 4,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ApprovalInteractionViewScreen(
                                                  widget.username,
                                                  widget.nik,
                                                  widget.hakAkses,
                                                  widget.nikSdm,
                                                  data.dataApprovalInteraction[i].id,
                                                  data.dataApprovalInteraction[i].calonDebitur,
                                                  data.dataApprovalInteraction[i].alamat,
                                                  data.dataApprovalInteraction[i].email,
                                                  data.dataApprovalInteraction[i].telepon,
                                                  data.dataApprovalInteraction[i].plafond,
                                                  data.dataApprovalInteraction[i].salesFeedback,
                                                  data.dataApprovalInteraction[i].foto,
                                                  data.dataApprovalInteraction[i].tanggalInteraksi,
                                                  data.dataApprovalInteraction[i].jamInteraksi,
                                                  data.dataApprovalInteraction[i].statusInteraksi,
                                                  data.dataApprovalInteraction[i].namaSales,
                                                  data.dataApprovalInteraction[i].kelurahan,
                                                  data.dataApprovalInteraction[i].kecamatan,
                                                  data.dataApprovalInteraction[i].kabupaten,
                                                  data.dataApprovalInteraction[i].propinsi,
                                                )));
                                      },
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Tooltip(
                                              message: messageStatus(
                                                  '${data.dataApprovalInteraction[i].statusInteraksi}'),
                                              child: Icon(
                                                iconStatus(
                                                    '${data.dataApprovalInteraction[i].statusInteraksi}'),
                                                color: colorStatus(
                                                    '${data.dataApprovalInteraction[i].statusInteraksi}'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              nama,
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
                                                  'Plafond : ${data.dataApprovalInteraction[i].plafond}',
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
                                        )),
                                        trailing: Text(
                                          '${data.dataApprovalInteraction[i].tanggalInteraksi}',
                                          style: fontFamily,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            )),
      ),
    );
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Sudah di interaksi';
    } else if (status == '1') {
      return 'Disetujui Sales Leader';
    } else if (status == '11') {
      return 'Ditolak Sales Leader ';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Icons.info;
    } else if (status == '1') {
      return Icons.check;
    } else if (status == '11') {
      return Icons.cancel;
    }
  }

  colorStatus(String status) {
    if (status == '0') {
      return Colors.blue;
    } else if (status == '1') {
      return Colors.green;
    } else if (status == '11') {
      return Colors.red;
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
