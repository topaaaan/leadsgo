import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leadsgo_apps/Screens/provider/simulation_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

// ignore: must_be_immutable
class SimulationResult extends StatefulWidget {
  String simulasiJenis;
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String tanggalPensiun;
  String tht;
  String plafondPinjaman;
  String bankBayarPensiun;
  String jangkaWaktu;
  String bunga;
  String niksales;
  // String jenisSimulasi;
  // String jenisKredit;
  // String jenisAsuransi;
  // String blokirAngsuran;
  // String takeoverBankLain;
  // String angsuranPerbulan;
  // String batasUsiaPensiun;
  SimulationResult(
    this.simulasiJenis,
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.tanggalPensiun,
    this.tht,
    this.plafondPinjaman,
    this.bankBayarPensiun,
    this.jangkaWaktu,
    this.bunga,
    this.niksales,
    // this.jenisSimulasi,
    // this.jenisKredit,
    // this.jenisAsuransi,
    // this.blokirAngsuran,
    // this.takeoverBankLain,
    // this.angsuranPerbulan,
    // this.batasUsiaPensiun,
  );

  @override
  _SimulationResultState createState() => _SimulationResultState();
}

class _SimulationResultState extends State<SimulationResult> {
  void initState() {
    //print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Hasil Simulasi',
            style: TextStyle(fontFamily: 'LeadsGo-Font'),
          ),
          actions: <Widget>[],
        ),
        body: FutureBuilder(
          future: Provider.of<SimulationProvider>(context, listen: false)
              .getSimulation(simulationItem(
                  widget.simulasiJenis,
                  widget.namaPensiun,
                  widget.gajiPensiun,
                  widget.tanggalLahir,
                  widget.tanggalPensiun,
                  widget.tht,
                  widget.plafondPinjaman,
                  widget.bankBayarPensiun,
                  widget.jangkaWaktu,
                  widget.bunga,
                  // widget.jenisSimulasi,
                  // widget.jenisKredit,
                  // widget.jenisAsuransi,
                  // widget.blokirAngsuran,
                  // widget.takeoverBankLain,
                  // widget.angsuranPerbulan,
                  // widget.batasUsiaPensiun,
                  widget.niksales)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                ),
              );
            }
            return Consumer<SimulationProvider>(builder: (context, data, _) {
              // return Container(
              //   decoration: BoxDecoration(color: Colors.white54),
              //   padding: EdgeInsets.only(
              //       left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              //   child: Text('adaw'),
              // );
              print(data.dataSimulation.length);
              if (data.dataSimulation[0].messageText == "dsr_tinggi") {
                return Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Text(
                      'Simulasi gagal, DSR ${data.dataSimulation[0].nilai} % melebihi 90.00 %, silahkan coba lagi...'),
                );
              } else if (data.dataSimulation[0].messageText ==
                  "jangka_waktu_tinggi") {
                return Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Text(
                      'Simulasi gagal, jangka waktu maksimal ${data.dataSimulation[0].nilai} bulan, silahkan coba lagi...'),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: leadsGoColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'DATA PRIBADI',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'LeadsGo-Font',
                                        color: leadsGoColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nama Lengkap',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].namaPensiun}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Gaji Terakhir',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].gajiPensiun)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Tanggal Lahir',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].tanggalLahir}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Usia',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].umur} TAHUN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Status',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].jenisSimulasi}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Bank Ambil Gaji',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].bankBayarPensiun}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            // SizedBox(height: 10),
                            // widget.simulasiJenis == 'prapensiun' ||
                            //         widget.simulasiJenis == 'tht'
                            //     ? Container(
                            //         child: Stack(
                            //           children: <Widget>[
                            //             Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: Text(
                            //                 'Lama Grace Period',
                            //                 style: TextStyle(
                            //                     fontFamily: 'LeadsGo-Font'),
                            //               ),
                            //             ),
                            //             Align(
                            //                 alignment: Alignment.centerRight,
                            //                 child: Text(
                            //                   '${data.dataSimulation[0].lamaGracePeriod} BULAN',
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                       fontFamily: 'LeadsGo-Font'),
                            //                 )),
                            //           ],
                            //         ),
                            //       )
                            //     : SizedBox(height: 0),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calculate_rounded,
                                  color: leadsGoColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text('PERHITUNGAN PINJAMAN',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'LeadsGo-Font',
                                          color: leadsGoColor)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nominal Pinjaman',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].plafond)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            // widget.simulasiJenis == 'tht'
                            //     ? SizedBox(height: 10)
                            //     : SizedBox(height: 0),
                            // widget.simulasiJenis == 'tht'
                            //     ? Container(
                            //         child: Stack(
                            //           children: <Widget>[
                            //             Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: Text(
                            //                 'THT',
                            //                 style: TextStyle(
                            //                     fontFamily: 'LeadsGo-Font'),
                            //               ),
                            //             ),
                            //             Align(
                            //                 alignment: Alignment.centerRight,
                            //                 child: Text(
                            //                   '${formatRupiah(data.dataSimulation[0].tht)}',
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                       fontFamily: 'LeadsGo-Font'),
                            //                 )),
                            //           ],
                            //         ),
                            //       )
                            //     : SizedBox(height: 0),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Jangka Waktu',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].jangWaktu} BULAN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Angsuran per Bulan',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].angsuranPerbulan)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'DSR Pinjaman',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].iirPinjaman} %',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Bunga',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].bungaAnuitas} %',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Sisa Gaji',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].sisaGaji)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Status Pinjaman',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: leadsGoColor,
                                        child: Text(
                                          "${data.dataSimulation[0].messageText}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'LeadsGo-Font',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.attach_money,
                                  color: leadsGoColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'PERHITUNGAN TERIMA BERSIH',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'LeadsGo-Font',
                                        color: leadsGoColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biaya Provisi',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaProvisi)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biaya Administrasi',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaAdministrasi)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Asuransi',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaAsuransi)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Biaya',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].totalBiaya)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Blokir Mutasi Rekening',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].blokirAngsuran)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            widget.simulasiJenis == 'prapensiun'
                                ? SizedBox(height: 10)
                                : SizedBox(height: 0),
                            widget.simulasiJenis == 'prapensiun'
                                ? Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Bunga Grace Period',
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font'),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${formatRupiah(data.dataSimulation[0].gracePeriod)}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'LeadsGo-Font'),
                                            )),
                                      ],
                                    ),
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Potongan',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].totalPotongan)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'LeadsGo-Font'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Estimasi Terima Bersih',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        color: leadsGoColor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          '${formatRupiah(data.dataSimulation[0].terimaBersih)}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'LeadsGo-Font',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '*note : Perhitungan belum termasuk potongan asuransi',
                                      style:
                                          TextStyle(fontFamily: 'LeadsGo-Font'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
            });
          },
        ),
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
