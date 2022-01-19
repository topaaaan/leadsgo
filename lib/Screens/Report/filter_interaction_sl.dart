import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:leadsgo_apps/Screens/Report/filter_interaction_sl_screen.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_interaction_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class FilterInteractionSlReportScreen extends StatefulWidget {
  @override
  _FilterInteractionSlReportScreen createState() => _FilterInteractionSlReportScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  FilterInteractionSlReportScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _FilterInteractionSlReportScreen extends State<FilterInteractionSlReportScreen> {
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
            onRefresh: () => Provider.of<FilterReportInteractionSlProvider>(context, listen: false)
                .getInteractionFilterSlReport(
                    FilterReportInteractionSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
            color: Colors.red,
            child: Container(
              child: FutureBuilder(
                future: Provider.of<FilterReportInteractionSlProvider>(context, listen: false)
                    .getInteractionFilterSlReport(
                        FilterReportInteractionSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<FilterReportInteractionSlProvider>(
                    builder: (context, data, _) {
                      print(data.dataInteractionFilterSlReport.length);
                      if (data.dataInteractionFilterSlReport.length == 0) {
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
                            itemCount: data.dataInteractionFilterSlReport.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              if (data.dataInteractionFilterSlReport[i].calonDebitur.length > 15) {
                                calonDebitur = data.dataInteractionFilterSlReport[i].calonDebitur
                                    .substring(0, 15);
                              } else {
                                calonDebitur = data.dataInteractionFilterSlReport[i].calonDebitur;
                              }

                              if (data.dataInteractionFilterSlReport[i].plafond != '') {
                                if (data.dataInteractionFilterSlReport[i].plafond.length > 15) {
                                  rencanaPinjaman = data.dataInteractionFilterSlReport[i].plafond;
                                } else {
                                  rencanaPinjaman = data.dataInteractionFilterSlReport[i].plafond;
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
                                                  data.dataInteractionFilterSlReport[i]
                                                      .calonDebitur,
                                                  data.dataInteractionFilterSlReport[i].alamat,
                                                  data.dataInteractionFilterSlReport[i].email,
                                                  data.dataInteractionFilterSlReport[i].telepon,
                                                  data.dataInteractionFilterSlReport[i].plafond,
                                                  data.dataInteractionFilterSlReport[i]
                                                      .salesFeedback,
                                                  data.dataInteractionFilterSlReport[i].foto,
                                                  data.dataInteractionFilterSlReport[i]
                                                      .tanggalInteraksi,
                                                  data.dataInteractionFilterSlReport[i]
                                                      .jamInteraksi,
                                                  data.dataInteractionFilterSlReport[i]
                                                      .statusInteraksi,
                                                  data.dataInteractionFilterSlReport[i].kelurahan,
                                                  data.dataInteractionFilterSlReport[i].kecamatan,
                                                  data.dataInteractionFilterSlReport[i].kabupaten,
                                                  data.dataInteractionFilterSlReport[i].propinsi,
                                                )));
                                      },
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: Image.network(
                                                    'https://tetranabasainovasi.com/marsit/${data.dataInteractionFilterSlReport[i].foto}',
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
                                                      '${data.dataInteractionFilterSlReport[i].tanggalInteraksi}',
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
                                                    '${data.dataInteractionFilterSlReport[i].namaSales}',
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
