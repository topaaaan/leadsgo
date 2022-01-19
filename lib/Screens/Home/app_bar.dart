import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Account/LogDiamond/lod_diamond_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarsytAppBar extends AppBar {
  int income;
  String nik;
  int diamond;

  MarsytAppBar(this.income, this.nik, this.diamond, BuildContext context)
      : super(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          flexibleSpace: _buildMarsytAppBar(
              income.toString(), nik.toString(), diamond.toString(), context),
        );

  static Widget _buildMarsytAppBar(
      String income, String nik, String diamond, BuildContext context) {
    var date = DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    Size size = MediaQuery.of(context).size;
    return Container(
        color: leadsGoColor,
        height: 130.0,
        padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    // color: Colors.white,
                    child: Image.asset(
                      "assets/leadsgo_logo_white.png",
                      fit: BoxFit.fill,
                      width: size.width * 0.25,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(123)),
                                // color: Color(0xFF193366)),
                                color: Colors.black45),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/images/star.svg",
                                  width: 23.0,
                                  semanticsLabel: 'Points',
                                ),
                                // Image.asset(
                                //   "assets/images/star.svg",
                                //   fit: BoxFit.fill,
                                //   width: size.width * 0.05,
                                // ),
                                Tooltip(
                                  message: 'Total Points',
                                  child: Text(
                                    " ${diamond}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontFamily: 'LeadsGo-Font',
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LogDiamondScreen(nik)));
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                          // padding: EdgeInsets.all(7.0),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          //     // color: Color(0xFF193366)),
                          //     color: deepleadsGoColor),
                          // child: SvgPicture.asset(
                          //   "assets/images/bell.svg",
                          //   width: 25.0,
                          //   color: Colors.white54,
                          //   semanticsLabel: 'Notification',
                          // ),
                          child: Icon(
                            MdiIcons.bell,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                        onTap: () {},
                      )
                      // SizedBox(
                      //   width: 5,
                      // ),
                      // InkWell(
                      //   child: Container(
                      //       padding: EdgeInsets.all(7.0),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      //           // color: Color(0xFF193366)),
                      //           color: deepleadsGoColor),
                      //       child: Row(
                      //         children: <Widget>[
                      //           Icon(
                      //             Icons.attach_money_outlined,
                      //             color: Colors.white,
                      //             size: 20.0,
                      //           ),
                      //           Tooltip(
                      //             message: 'Terhitung periode $bulan $tahun',
                      //             child: Text(
                      //               "${formatRupiah(income)}  ",
                      //               style: TextStyle(fontSize: 14.0, color: Colors.white),
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      //   onTap: () {},
                      // )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

namaBulan(String bulan) {
  switch (bulan) {
    case '1':
      return 'Januari';
      break;
    case '2':
      return 'Februari';
      break;
    case '3':
      return 'Maret';
      break;
    case '4':
      return 'April';
      break;
    case '5':
      return 'Mei';
      break;
    case '6':
      return 'Juni';
      break;
    case '7':
      return 'Juli';
      break;
    case '8':
      return 'Agustus';
      break;
    case '9':
      return 'September';
      break;
    case '10':
      return 'Oktober';
      break;
    case '11':
      return 'November';
      break;
    case '12':
      return 'Desember';
      break;
  }
}

formatRupiah(String a) {
  FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
      amount: double.parse(a),
      settings: MoneyFormatterSettings(
        symbol: 'Rp',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 3,
      ));
  return 'Rp ' + fmf.output.withoutFractionDigits;
}
