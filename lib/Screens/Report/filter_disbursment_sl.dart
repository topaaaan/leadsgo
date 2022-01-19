import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:leadsgo_apps/Screens/Report/filter_interaction_sl_screen.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_disbursment_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class FilterDisbursmentSlReportScreen extends StatefulWidget {
  @override
  _FilterDisbursmentSlReportScreen createState() => _FilterDisbursmentSlReportScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  FilterDisbursmentSlReportScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _FilterDisbursmentSlReportScreen extends State<FilterDisbursmentSlReportScreen> {
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
            'Laporan Pencairan',
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
            onRefresh: () => Provider.of<FilterReportDisbursmentSlProvider>(context, listen: false)
                .getDisbursmentFilterSlReport(
                    FilterReportDisbursmentSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
            color: Colors.red,
            child: Container(
              child: FutureBuilder(
                future: Provider.of<FilterReportDisbursmentSlProvider>(context, listen: false)
                    .getDisbursmentFilterSlReport(
                        FilterReportDisbursmentSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<FilterReportDisbursmentSlProvider>(
                    builder: (context, data, _) {
                      print(data.dataDisbursmentFilterSlReport.length);
                      if (data.dataDisbursmentFilterSlReport.length == 0) {
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
                              'Pencairan Tidak Ditemukan!',
                              style: TextStyle(
                                  fontFamily: "LeadsGo-Font",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        );
                      } else {
                        return GridView.builder(
                            itemCount: data.dataDisbursmentFilterSlReport.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              if (data.dataDisbursmentFilterSlReport[i].debitur.length > 15) {
                                calonDebitur =
                                    data.dataDisbursmentFilterSlReport[i].debitur.substring(0, 15);
                              } else {
                                calonDebitur = data.dataDisbursmentFilterSlReport[i].debitur;
                              }

                              if (data.dataDisbursmentFilterSlReport[i].plafond != '') {
                                if (data.dataDisbursmentFilterSlReport[i].plafond.length > 15) {
                                  rencanaPinjaman = data.dataDisbursmentFilterSlReport[i].plafond
                                      .substring(0, 15);
                                } else {
                                  rencanaPinjaman = data.dataDisbursmentFilterSlReport[i].plafond;
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
                                            builder: (context) => DisbursmentViewScreen(
                                                data.dataDisbursmentFilterSlReport[i].debitur,
                                                data.dataDisbursmentFilterSlReport[i].alamat,
                                                data.dataDisbursmentFilterSlReport[i].telepon,
                                                data.dataDisbursmentFilterSlReport[i].tanggalAkad,
                                                data.dataDisbursmentFilterSlReport[i].nomorAkad,
                                                data.dataDisbursmentFilterSlReport[i].noJanji,
                                                data.dataDisbursmentFilterSlReport[i].plafond,
                                                data.dataDisbursmentFilterSlReport[i].nominal,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .nominal_os_akhir,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .jenisPencairan,
                                                data.dataDisbursmentFilterSlReport[i].jenisProduk,
                                                data.dataDisbursmentFilterSlReport[i].cabang,
                                                data.dataDisbursmentFilterSlReport[i].infoSales,
                                                data.dataDisbursmentFilterSlReport[i].foto1,
                                                data.dataDisbursmentFilterSlReport[i].foto2,
                                                data.dataDisbursmentFilterSlReport[i].foto3,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .tanggalPencairan,
                                                data.dataDisbursmentFilterSlReport[i].jamPencairan,
                                                data.dataDisbursmentFilterSlReport[i].namaTl,
                                                data.dataDisbursmentFilterSlReport[i].jabatanTl,
                                                data.dataDisbursmentFilterSlReport[i].teleponTl,
                                                data.dataDisbursmentFilterSlReport[i].namaSales,
                                                data.dataDisbursmentFilterSlReport[i].cabang,
                                                data.dataDisbursmentFilterSlReport[i].infoSales,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .statusPipeline,
                                                data.dataDisbursmentFilterSlReport[i].statusKredit,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .pengelolaPensiun,
                                                data.dataDisbursmentFilterSlReport[i].bankTakeover,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .tanggalPenyerahan,
                                                data.dataDisbursmentFilterSlReport[i].namaPenerima,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .teleponPenerima,
                                                data.dataDisbursmentFilterSlReport[i]
                                                    .tanggalPipeline,
                                                data.dataDisbursmentFilterSlReport[i].tempatLahir,
                                                data.dataDisbursmentFilterSlReport[i].tanggalLahir,
                                                data.dataDisbursmentFilterSlReport[i].jenisKelamin,
                                                data.dataDisbursmentFilterSlReport[i].noKtp,
                                                data.dataDisbursmentFilterSlReport[i].npwp,
                                                data.dataDisbursmentFilterSlReport[i].kodeProduk)));
                                      },
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: Image.network(
                                                    'https://tetranabasainovasi.com/marsit/${data.dataDisbursmentFilterSlReport[i].foto2}',
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
                                                      '${formatRupiah(rencanaPinjaman)}',
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
                                                      '${data.dataDisbursmentFilterSlReport[i].tanggalPencairan}',
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
                                                    '${data.dataDisbursmentFilterSlReport[i].namaSales}',
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
