import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';
import 'filter_disbursment_screen.dart';

// ignore: must_be_immutable
class FilterDisbursmentReportScreen extends StatefulWidget {
  @override
  _FilterDisbursmentReportScreen createState() => _FilterDisbursmentReportScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  FilterDisbursmentReportScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _FilterDisbursmentReportScreen extends State<FilterDisbursmentReportScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
    var cardTextStyle = TextStyle(
        fontFamily: "LeadsGo-Font",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "LeadsGo-Font", fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold);
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
                            builder: (context) => FilterDisbursmentScreen(widget.nik)));
                  },
                  child: Icon(Icons.filter_list),
                )),
          ],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<FilterReportDisbursmentProvider>(context, listen: false)
                .getDisbursmentFilterReport(
                    FilterReportDisbursmentItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
            color: Colors.red,
            child: Container(
              child: FutureBuilder(
                future: Provider.of<FilterReportDisbursmentProvider>(context, listen: false)
                    .getDisbursmentFilterReport(
                        FilterReportDisbursmentItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<FilterReportDisbursmentProvider>(
                    builder: (context, data, _) {
                      print(data.dataFilterDisbursmentReport.length);
                      if (data.dataFilterDisbursmentReport.length == 0) {
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
                            itemCount: data.dataFilterDisbursmentReport.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              if (data.dataFilterDisbursmentReport[i].debitur.length > 15) {
                                calonDebitur =
                                    data.dataFilterDisbursmentReport[i].debitur.substring(0, 15);
                              } else {
                                calonDebitur = data.dataFilterDisbursmentReport[i].debitur;
                              }

                              if (data.dataFilterDisbursmentReport[i].plafond != '') {
                                if (data.dataFilterDisbursmentReport[i].plafond.length > 15) {
                                  rencanaPinjaman =
                                      data.dataFilterDisbursmentReport[i].plafond.substring(0, 15);
                                } else {
                                  rencanaPinjaman = data.dataFilterDisbursmentReport[i].plafond;
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
                                                data.dataFilterDisbursmentReport[i].debitur,
                                                data.dataFilterDisbursmentReport[i].alamat,
                                                data.dataFilterDisbursmentReport[i].telepon,
                                                data.dataFilterDisbursmentReport[i].tanggalAkad,
                                                data.dataFilterDisbursmentReport[i].nomorAkad,
                                                data.dataFilterDisbursmentReport[i].noJanji,
                                                data.dataFilterDisbursmentReport[i].plafond,
                                                data.dataFilterDisbursmentReport[i].nominal,
                                                data.dataFilterDisbursmentReport[i]
                                                    .nominal_os_akhir,
                                                data.dataFilterDisbursmentReport[i].jenisPencairan,
                                                data.dataFilterDisbursmentReport[i].jenisProduk,
                                                data.dataFilterDisbursmentReport[i].cabang,
                                                data.dataFilterDisbursmentReport[i].infoSales,
                                                data.dataFilterDisbursmentReport[i].foto1,
                                                data.dataFilterDisbursmentReport[i].foto2,
                                                data.dataFilterDisbursmentReport[i].foto3,
                                                data.dataFilterDisbursmentReport[i]
                                                    .tanggalPencairan,
                                                data.dataFilterDisbursmentReport[i].jamPencairan,
                                                data.dataFilterDisbursmentReport[i].namaTl,
                                                data.dataFilterDisbursmentReport[i].jabatanTl,
                                                data.dataFilterDisbursmentReport[i].teleponTl,
                                                data.dataFilterDisbursmentReport[i].namaSales,
                                                data.dataFilterDisbursmentReport[i].cabang,
                                                data.dataFilterDisbursmentReport[i].infoSales,
                                                data.dataFilterDisbursmentReport[i].statusPipeline,
                                                data.dataFilterDisbursmentReport[i].statusKredit,
                                                data.dataFilterDisbursmentReport[i]
                                                    .pengelolaPensiun,
                                                data.dataFilterDisbursmentReport[i].bankTakeover,
                                                data.dataFilterDisbursmentReport[i]
                                                    .tanggalPenyerahan,
                                                data.dataFilterDisbursmentReport[i].namaPenerima,
                                                data.dataFilterDisbursmentReport[i].teleponPenerima,
                                                data.dataFilterDisbursmentReport[i].tanggalPipeline,
                                                data.dataFilterDisbursmentReport[i].tempatLahir,
                                                data.dataFilterDisbursmentReport[i].tanggalLahir,
                                                data.dataFilterDisbursmentReport[i].jenisKelamin,
                                                data.dataFilterDisbursmentReport[i].noKtp,
                                                data.dataFilterDisbursmentReport[i].npwp,
                                                data.dataFilterDisbursmentReport[i].kodeProduk)));
                                      },
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: Image.network(
                                                    'https://tetranabasainovasi.com/marsit/${data.dataFilterDisbursmentReport[i].foto2}',
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
                                                      '${data.dataFilterDisbursmentReport[i].tanggalPencairan}',
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
