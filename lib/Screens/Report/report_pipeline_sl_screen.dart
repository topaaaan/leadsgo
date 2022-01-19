import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:leadsgo_apps/Screens/Report/filter_pipeline_sl_screen.dart';
import 'package:leadsgo_apps/Screens/provider/report_pipeline_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportPipelineSlScreen extends StatefulWidget {
  @override
  _ReportPipelineSlScreen createState() => _ReportPipelineSlScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportPipelineSlScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportPipelineSlScreen extends State<ReportPipelineSlScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.nik);
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
            'Laporan Pipeline',
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
                            builder: (context) => FilterPipelineSlScreen(widget.nik)));
                  },
                  child: Icon(Icons.filter_list),
                )),
          ],
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<ReportPipelineSlProvider>(context, listen: false)
                .getPipelineSlReport(
                    ReportPipelineSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
            color: Colors.red,
            child: Container(
              child: FutureBuilder(
                future: Provider.of<ReportPipelineSlProvider>(context, listen: false)
                    .getPipelineSlReport(
                        ReportPipelineSlItem(widget.nik, widget.tglAwal, widget.tglAkhir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<ReportPipelineSlProvider>(
                    builder: (context, data, _) {
                      print(data.dataPipelineSlReport.length);
                      if (data.dataPipelineSlReport.length == 0) {
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
                              'Pipeline Tidak Ditemukan!',
                              style: TextStyle(
                                  fontFamily: "LeadsGo-Font",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        );
                      } else {
                        return GridView.builder(
                            itemCount: data.dataPipelineSlReport.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              if (data.dataPipelineSlReport[i].cadeb.length > 15) {
                                calonDebitur = data.dataPipelineSlReport[i].cadeb.substring(0, 15);
                              } else {
                                calonDebitur = data.dataPipelineSlReport[i].cadeb;
                              }

                              if (data.dataPipelineSlReport[i].nominal != '') {
                                if (data.dataPipelineSlReport[i].nominal.length > 15) {
                                  rencanaPinjaman =
                                      data.dataPipelineSlReport[i].nominal.substring(0, 15);
                                } else {
                                  rencanaPinjaman = data.dataPipelineSlReport[i].nominal;
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
                                        print(
                                          data.dataPipelineSlReport[i].cabang,
                                        );
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => PipelineViewScreen(
                                                data.dataPipelineSlReport[i].cadeb,
                                                data.dataPipelineSlReport[i].tglPipeline,
                                                data.dataPipelineSlReport[i].alamat,
                                                data.dataPipelineSlReport[i].telepon,
                                                data.dataPipelineSlReport[i].jenisProduk,
                                                data.dataPipelineSlReport[i].nominal,
                                                data.dataPipelineSlReport[i].cabang,
                                                data.dataPipelineSlReport[i].keterangan,
                                                data.dataPipelineSlReport[i].status,
                                                data.dataPipelineSlReport[i].tampatLahir,
                                                data.dataPipelineSlReport[i].tanggalLahir,
                                                data.dataPipelineSlReport[i].jenisKelamin,
                                                data.dataPipelineSlReport[i].noKtp,
                                                data.dataPipelineSlReport[i].npwp,
                                                data.dataPipelineSlReport[i].tglPenyerahan,
                                                data.dataPipelineSlReport[i].tanggalAkad,
                                                data.dataPipelineSlReport[i].statusKredit,
                                                data.dataPipelineSlReport[i].pengelolaPensiun,
                                                data.dataPipelineSlReport[i].bankTakeOver,
                                                data.dataPipelineSlReport[i].foto1,
                                                data.dataPipelineSlReport[i].foto2,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '')));
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                child: Image.network(
                                                  'https://tetranabasainovasi.com/marsit/${data.dataPipelineSlReport[i].foto1}',
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
                                                    '${data.dataPipelineSlReport[i].tglPipeline}',
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
                                                  '${data.dataPipelineSlReport[i].namaSales}',
                                                  style: cardTextStyleFooter2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
