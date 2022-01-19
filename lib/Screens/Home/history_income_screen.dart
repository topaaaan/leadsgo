import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/provider/history_income_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class HistoryIncomeScreen extends StatefulWidget {
  @override
  _HistoryIncomeScreenScreen createState() => _HistoryIncomeScreenScreen();

  String nik;

  HistoryIncomeScreen(this.nik);
}

class _HistoryIncomeScreenScreen extends State<HistoryIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle =
        TextStyle(fontFamily: "LeadsGo-Font", fontSize: 14, color: Color.fromRGBO(63, 63, 63, 1));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Riwayat Pendapatan',
            style: fontFamily,
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<HistoryIncomeProvider>(context, listen: false)
                .getHistoryIncome(HistoryIncomeItem(widget.nik)),
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                future: Provider.of<HistoryIncomeProvider>(context, listen: false)
                    .getHistoryIncome(HistoryIncomeItem(widget.nik)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<HistoryIncomeProvider>(
                    builder: (context, data, _) {
                      print(data.dataHistoryIncome.length);
                      if (data.dataHistoryIncome.length == 0) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.hourglass_empty, size: 50),
                              title: Text(
                                'RIWAYAT PENDAPATAN TIDAK DITEMUKAN',
                                style: cardTextStyle,
                              ),
                              subtitle: Text(''),
                            ),
                          ]),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data.dataHistoryIncome.length,
                            itemBuilder: (context, i) {
                              String namaNasabah = '';
                              if (data.dataHistoryIncome[i].namaNasabah.length > 20) {
                                namaNasabah =
                                    data.dataHistoryIncome[i].namaNasabah.substring(0, 20);
                              } else {
                                namaNasabah = data.dataHistoryIncome[i].namaNasabah;
                              }
                              return Card(
                                  elevation: 8,
                                  child: InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Icon(
                                            iconStatus('${data.dataHistoryIncome[i].status}'),
                                            color:
                                                colorStatus('${data.dataHistoryIncome[i].status}'),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            namaNasabah,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'LeadsGo-Font'),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Tanggal : ${data.dataHistoryIncome[i].tglIncome}',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'LeadsGo-Font'),
                                      ),
                                      trailing: Text(
                                        '${formatRupiah(data.dataHistoryIncome[i].plafond)}',
                                        style: fontFamily,
                                      ),
                                    ),
                                  ));
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

  iconStatus(String status) {
    if (status == '5') {
      return Icons.note;
    } else if (status != '5') {
      return Icons.directions_walk;
    }
  }

  colorStatus(String status) {
    if (status == '5') {
      return Colors.blue;
    } else if (status != '5') {
      return Colors.green;
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
