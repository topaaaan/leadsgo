import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/report_interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';
import 'filter_interaction_screen.dart';

// ignore: must_be_immutable
class ReportInteractionScreen extends StatefulWidget {
  @override
  _ReportInteractionScreen createState() => _ReportInteractionScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportInteractionScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportInteractionScreen extends State<ReportInteractionScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
    String alamat;
    var cardTextStyle = TextStyle(
        fontFamily: "LeadsGo-Font",
        fontSize: 13,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "LeadsGo-Font", fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold);
    var cardTextStyleFooter1 =
        TextStyle(fontFamily: "LeadsGo-Font", fontSize: 12, color: Color.fromRGBO(63, 63, 63, 1));
    var cardTextStyleFooter2 =
        TextStyle(fontFamily: "LeadsGo-Font", fontSize: 12, color: Color.fromRGBO(63, 63, 63, 1));
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Laporan Interaksi',
            style: fontFamily,
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterInteractionScreen(widget.nik)));
                  },
                  child: Icon(Icons.filter_list),
                )),
          ],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<ReportInteractionProvider>(context, listen: false)
                .getInteractionReport(
                    ReportInteractionItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
            color: Colors.red,
            child: Container(
              child: FutureBuilder(
                future: Provider.of<ReportInteractionProvider>(context, listen: false)
                    .getInteractionReport(
                        ReportInteractionItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<ReportInteractionProvider>(
                    builder: (context, data, _) {
                      print(data.dataInteractionReport.length);
                      if (data.dataInteractionReport.length == 0) {
                        return Center(
                          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.hourglass_empty_outlined, size: 70),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Interaksi Tidak Ditemukan!',
                              style: TextStyle(
                                  fontFamily: "LeadsGo-Font",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        );
                      } else {
                        return GridView.builder(
                            itemCount: data.dataInteractionReport.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              if (data.dataInteractionReport[i].calonDebitur.length > 15) {
                                calonDebitur =
                                    data.dataInteractionReport[i].calonDebitur.substring(0, 15);
                              } else {
                                calonDebitur = data.dataInteractionReport[i].calonDebitur;
                              }

                              if (data.dataInteractionReport[i].plafond != '') {
                                if (data.dataInteractionReport[i].plafond.length > 15) {
                                  rencanaPinjaman = data.dataInteractionReport[i].plafond;
                                } else {
                                  rencanaPinjaman = data.dataInteractionReport[i].plafond;
                                }
                              } else {
                                rencanaPinjaman = '';
                              }

                              if (data.dataInteractionReport[i].alamat != '') {
                                if (data.dataInteractionReport[i].alamat.length > 15) {
                                  alamat = data.dataInteractionReport[i].alamat;
                                } else {
                                  alamat = data.dataInteractionReport[i].alamat;
                                }
                              } else {
                                alamat = '';
                              }

                              return Card(
                                elevation: 0,
                                child: GridTile(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => InteractionViewScreen(
                                                  data.dataInteractionReport[i].calonDebitur,
                                                  data.dataInteractionReport[i].alamat,
                                                  data.dataInteractionReport[i].email,
                                                  data.dataInteractionReport[i].telepon,
                                                  data.dataInteractionReport[i].plafond,
                                                  data.dataInteractionReport[i].salesFeedback,
                                                  data.dataInteractionReport[i].foto,
                                                  data.dataInteractionReport[i].tanggalInteraksi,
                                                  data.dataInteractionReport[i].jamInteraksi,
                                                  data.dataInteractionReport[i].statusInteraksi,
                                                  data.dataInteractionReport[i].kelurahan,
                                                  data.dataInteractionReport[i].kecamatan,
                                                  data.dataInteractionReport[i].kabupaten,
                                                  data.dataInteractionReport[i].propinsi,
                                                )));
                                      },
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: Image.network(
                                                    'https://tetranabasainovasi.com/marsit/${data.dataInteractionReport[i].foto}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  height: 100.0,
                                                  width: double.infinity,
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Text(
                                                      formatRupiah(rencanaPinjaman),
                                                      style: cardTextStyleChild,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Text(
                                                      '${data.dataInteractionReport[i].tanggalInteraksi}',
                                                      style: cardTextStyleFooter1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '$calonDebitur',
                                                style: cardTextStyle,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  );
                },
              ),
            )),
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
