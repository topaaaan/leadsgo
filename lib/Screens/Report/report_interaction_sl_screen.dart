import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:leadsgo_apps/Screens/Report/filter_interaction_sl_screen.dart';
import 'package:leadsgo_apps/Screens/provider/report_interaction_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportInteractionSlScreen extends StatefulWidget {
  @override
  _ReportInteractionSlScreen createState() => _ReportInteractionSlScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportInteractionSlScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportInteractionSlScreen extends State<ReportInteractionSlScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
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
                            builder: (context) => FilterInteractionSlScreen(widget.nik)));
                  },
                  child: Icon(Icons.filter_list),
                )),
          ],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<ReportInteractionSlProvider>(context, listen: false)
                .getInteractionSlReport(
                    ReportInteractionSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
            color: Colors.red,
            child: Container(
              child: FutureBuilder(
                future: Provider.of<ReportInteractionSlProvider>(context, listen: false)
                    .getInteractionSlReport(
                        ReportInteractionSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<ReportInteractionSlProvider>(
                    builder: (context, data, _) {
                      print(data.dataInteractionSlReport.length);
                      if (data.dataInteractionSlReport.length == 0) {
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
                            itemCount: data.dataInteractionSlReport.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              if (data.dataInteractionSlReport[i].calonDebitur.length > 15) {
                                calonDebitur =
                                    data.dataInteractionSlReport[i].calonDebitur.substring(0, 15);
                              } else {
                                calonDebitur = data.dataInteractionSlReport[i].calonDebitur;
                              }

                              if (data.dataInteractionSlReport[i].plafond != '') {
                                if (data.dataInteractionSlReport[i].plafond.length > 15) {
                                  rencanaPinjaman = data.dataInteractionSlReport[i].plafond;
                                } else {
                                  rencanaPinjaman = data.dataInteractionSlReport[i].plafond;
                                }
                              } else {
                                rencanaPinjaman = '';
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
                                                  data.dataInteractionSlReport[i].calonDebitur,
                                                  data.dataInteractionSlReport[i].alamat,
                                                  data.dataInteractionSlReport[i].email,
                                                  data.dataInteractionSlReport[i].telepon,
                                                  data.dataInteractionSlReport[i].plafond,
                                                  data.dataInteractionSlReport[i].salesFeedback,
                                                  data.dataInteractionSlReport[i].foto,
                                                  data.dataInteractionSlReport[i].tanggalInteraksi,
                                                  data.dataInteractionSlReport[i].jamInteraksi,
                                                  data.dataInteractionSlReport[i].statusInteraksi,
                                                  data.dataInteractionSlReport[i].kelurahan,
                                                  data.dataInteractionSlReport[i].kecamatan,
                                                  data.dataInteractionSlReport[i].kabupaten,
                                                  data.dataInteractionSlReport[i].propinsi,
                                                )));
                                      },
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: Image.network(
                                                    'https://tetranabasainovasi.com/marsit/${data.dataInteractionSlReport[i].foto}',
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
                                                      '${data.dataInteractionSlReport[i].tanggalInteraksi}',
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
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person_outline,
                                                  color: leadsGoColor,
                                                  size: 12,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${data.dataInteractionSlReport[i].namasales}',
                                                    style: cardTextStyleFooter2,
                                                  ),
                                                ),
                                              ],
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
