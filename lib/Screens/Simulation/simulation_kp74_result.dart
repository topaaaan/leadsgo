import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leadsgo_apps/Screens/provider/simulation_kp74_provider.dart';
import 'package:leadsgo_apps/Screens/provider/simulation_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

// ignore: must_be_immutable
class SimulationKp74Result extends StatefulWidget {
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String sukuBunga;
  String angsuranPerbulan;
  String jangkaWaktu;

  SimulationKp74Result(
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.sukuBunga,
    this.angsuranPerbulan,
    this.jangkaWaktu,
  );

  @override
  _SimulationKp74ResultState createState() => _SimulationKp74ResultState();
}

class _SimulationKp74ResultState extends State<SimulationKp74Result> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.namaPensiun +
        ' ' +
        widget.gajiPensiun +
        ' ' +
        widget.tanggalLahir +
        ' ' +
        widget.sukuBunga +
        ' ' +
        widget.angsuranPerbulan);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Hasil Simulasi',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
            actions: <Widget>[],
          ),
          body: FutureBuilder(
              future: Provider.of<SimulationKp74Provider>(context, listen: false).getSimulationKp74(
                  simulationKp74Item(widget.namaPensiun, widget.gajiPensiun, widget.tanggalLahir,
                      widget.sukuBunga, widget.angsuranPerbulan, widget.jangkaWaktu)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
                    ),
                  );
                }
                return Consumer<SimulationKp74Provider>(builder: (context, data, _) {
                  print(data.dataSimulationKp74[0]);
                  if (data.dataSimulationKp74[0].messageText == 'iir') {
                    return Container(
                      decoration: BoxDecoration(color: Colors.white54),
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: Text(
                          'Simulasi gagal, iir kamu ${data.dataSimulationKp74[0].nilai} % , maksimal iir 90 %'),
                    );
                  } else if (data.dataSimulationKp74[0].messageText == 'umur') {
                    return Container(
                      decoration: BoxDecoration(color: Colors.white54),
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: Text(
                          'Simulasi gagal, umur kamu ${data.dataSimulationKp74[0].nilai} tahun , minimal umur 73 tahun dan maksimal umur 79 tahun'),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(color: Colors.white54),
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.black12))),
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
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].namaPensiun}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Gaji Pensiun',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].gajiPensiun)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].tanggalLahir}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Umur',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].umur} Tahun',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      color: leadsGoColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'PERHITUNGAN PINJAMAN',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'LeadsGo-Font',
                                            color: leadsGoColor),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Plafond',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].plafond)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Angsuran',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].jumlahAngsuran)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Suku Bunga',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].sukuBunga} %',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Tarif Asuransi',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].premi} %',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Jangka Waktu',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].jw} Bulan',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'IIR',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataSimulationKp74[0].iir} %',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].sisaGaji)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Administrasi',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].madm)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Provisi',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].mprovi)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].mpremi)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Materai',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].bmeterai)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Simpanan Sukarela',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].simpananSukarela)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Simpanan Pokok',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].simpananPokok)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Simpanan Wajib',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].simpananWajib)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Jumlah Biaya',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].jumlahBiaya)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
                                          'Terima Bersih',
                                          style: TextStyle(fontFamily: 'LeadsGo-Font'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          color: Colors.blue,
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '${formatRupiah(data.dataSimulationKp74[0].jumlahBersih)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'LeadsGo-Font',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                });
              })),
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
