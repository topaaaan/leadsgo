import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Voucher/tracking_voucher_screen.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_provider.dart';
import 'package:leadsgo_apps/Screens/provider/leaderboard_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LeaderboardScreen extends StatefulWidget {
  String nik;

  LeaderboardScreen(this.nik);
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: leadsGoColor,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Leaderboard',
              style: TextStyle(
                fontFamily: 'CourrierPrime',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Toast.show(
                      'Leaderboard Pencapaian ' + bulan + ' ' + tahun, context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.CENTER,
                      backgroundColor: Colors.amber[300],
                      textColor: Colors.black);
                },
              )
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<LeaderboardProvider>(context, listen: false)
                      .getLeaderboard(LeaderboardItem(widget.nik)),
              color: leadsGoColor,
              child: FadeAnimation(
                  0.5,
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: Provider.of<LeaderboardProvider>(context,
                              listen: false)
                          .getLeaderboard(LeaderboardItem(widget.nik)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    leadsGoColor)),
                          );
                        }
                        return Consumer<LeaderboardProvider>(
                          builder: (context, data, _) {
                            print(data.dataLeaderboard.length);
                            if (data.dataLeaderboard.length == 0) {
                              return Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Icon(Icons.hourglass_empty,
                                                size: 70),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Pencairan Kredit Yuk!',
                                        style: TextStyle(
                                            fontFamily: "LeadsGo-Font",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Dapatkan insentif besar dari pencairanmu.',
                                        style: TextStyle(
                                          fontFamily: "LeadsGo-Font",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ]),
                              );
                            } else {
                              return ListView.builder(
                                  padding: EdgeInsets.only(bottom: 100),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.dataLeaderboard.length,
                                  itemBuilder: (context, i) {
                                    double nominal = double.parse(
                                        data.dataLeaderboard[i].nominal);
                                    int nomor = (i + 1);

                                    return InkWell(
                                      onTap: () {},
                                      child: _buildCreditCard(
                                        nomor.toString(),
                                        formatRupiah(nominal.toString()),
                                        data.dataLeaderboard[i].nama,
                                        data.dataLeaderboard[i].rekening,
                                        data.dataLeaderboard[i].cabang,
                                      ),
                                    );
                                  });
                            }
                          },
                        );
                      },
                    ),
                  )))),
    );
  }

  Widget _buildCreditCard(String nomor, String nominal, String nama,
      String rekening, String cabang) {
    return Card(
      elevation: 4.0,
      // color: insentifCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft, end: Alignment.topRight,
              // Add one stop for each color
              // Values should increase from 0.0 to 1.0
              stops: [0.1, 0.7],
              colors: [leadsGoColor, Colors.deepOrange[300]],
            )),
        height: 140,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(nomor),
            Text(
              '$nominal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'CourrierPrime',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(cabang, nama),
                _buildDetailsBlock('Rekening', rekening),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsBlock(String label, String value) {
    if (value.length >= 25) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value.substring(0, 25) + '...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }
  }

  Widget _buildLogosBlock(nomor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
            child: Text(
              nomor,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        iconStatus(nomor)
      ],
    );
  }

  iconStatus(String nomor) {
    if (nomor == '1') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.chessKing,
          size: 20,
          color: Colors.white,
        ),
      );
    } else if (nomor == '2') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.chessQueen,
          size: 20,
          color: Colors.white,
        ),
      );
    } else if (nomor == '3') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.chessRook,
          size: 20,
          color: Colors.white,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Icon(
          MdiIcons.chessPawn,
          size: 20,
          color: Colors.white,
        ),
      );
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
    return 'Rp. ' + fmf.output.withoutFractionDigits;
  }
}
