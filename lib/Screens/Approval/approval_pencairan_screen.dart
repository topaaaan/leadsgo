import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Approval/approval_pencairan_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/approval_disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class ApprovalDisbursmentScreen extends StatefulWidget {
  @override
  _ApprovalDisbursmentScreen createState() => _ApprovalDisbursmentScreen();

  String username;
  String nik;
  String nikSdm;

  ApprovalDisbursmentScreen(this.username, this.nik, this.nikSdm);
}

class _ApprovalDisbursmentScreen extends State<ApprovalDisbursmentScreen> {
  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    var cardTextStyle = TextStyle(fontFamily: "LeadsGo-Font", fontSize: 14, color: Colors.white);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Pencairan',
            style: fontFamily,
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<ApprovalDisbursmentProvider>(context, listen: false)
                .getApprovalDisbursment(ApprovalDisbursmentItem(widget.nikSdm)),
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
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
                              'Pencairan tim kamu tidak tersedia.',
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
                            Card(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.note,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'PENCAIRAN PERIODE $bulan $tahun',
                                    style: cardTextStyle,
                                  ),
                                  subtitle: Text(
                                    'Selamat bekerja, sukses selalu',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ]),
                            ),
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
                                      debitur =
                                          data.dataApprovalDisbursment[i].debitur.substring(0, 15);
                                    } else {
                                      debitur = data.dataApprovalDisbursment[i].debitur;
                                    }
                                    return Card(
                                        elevation: 4,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => ApprovalDisbursmentViewScreen(
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
                                                      data.dataApprovalDisbursment[i].jamPencairan,
                                                      data.dataApprovalDisbursment[i].namaTl,
                                                      data.dataApprovalDisbursment[i].jabatanTl,
                                                      data.dataApprovalDisbursment[i].teleponTl,
                                                      data.dataApprovalDisbursment[i].namaSales,
                                                      data.dataApprovalDisbursment[i].cabang,
                                                      data.dataApprovalDisbursment[i].infoSales,
                                                      data.dataApprovalDisbursment[i]
                                                          .statusPipeline,
                                                      data.dataApprovalDisbursment[i].statusKredit,
                                                      data.dataApprovalDisbursment[i]
                                                          .pengelolaPensiun,
                                                      data.dataApprovalDisbursment[i].bankTakeover,
                                                      data.dataApprovalDisbursment[i]
                                                          .tanggalPenyerahan,
                                                      data.dataApprovalDisbursment[i].namaPenerima,
                                                      data.dataApprovalDisbursment[i]
                                                          .teleponPenerima,
                                                      data.dataApprovalDisbursment[i]
                                                          .tanggalPipeline,
                                                      data.dataApprovalDisbursment[i].tempatLahir,
                                                      data.dataApprovalDisbursment[i].tanggalLahir,
                                                      data.dataApprovalDisbursment[i].jenisKelamin,
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
                                                        'Plafond: ${formatRupiah(data.dataApprovalDisbursment[i].plafond)}',
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
            )),
      ),
    );
  }

  messageStatus(String status) {
    if (status == 'waiting') {
      return 'Menunggu Persetujuan';
    } else if (status == 'success') {
      return 'Disetujui Sales Leader';
    } else if (status == 'failed') {
      return 'Ditolak Sales Leader ';
    }
  }

  iconStatus(String status) {
    if (status == 'waiting') {
      return Icons.info;
    } else if (status == 'success') {
      return Icons.check;
    } else if (status == 'failed') {
      return Icons.cancel;
    }
  }

  colorStatus(String status) {
    if (status == 'waiting') {
      return Colors.blue;
    } else if (status == 'success') {
      return Colors.green;
    } else if (status == 'failed') {
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
