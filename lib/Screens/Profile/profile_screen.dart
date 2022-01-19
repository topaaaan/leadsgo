import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Profile/address_data_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/bank_account_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/employee_data_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/income_data_screen.dart';
import 'package:leadsgo_apps/Screens/Profile/personal_data_screen.dart';
import 'package:leadsgo_apps/constants.dart';

class ProfileScreen extends StatefulWidget {
  List personalData;
  ProfileScreen(this.personalData);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              'Profil',
              style: TextStyle(fontFamily: 'LeadsGo-Font'),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black12,
                    ))),
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PersonalDataScreen(widget.personalData)));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Pribadi',
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.chevron_right,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black12,
                    ))),
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddressDataScreen(widget.personalData)));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Alamat',
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.chevron_right,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black12,
                    ))),
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BankAccountDataScreen(
                                    widget.personalData)));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.credit_card,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Rekening',
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.chevron_right,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black12,
                    ))),
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeDataScreen(widget.personalData)));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person_outline,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Karyawan',
                                      style: TextStyle(
                                        fontFamily: 'LeadsGo-Font',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.chevron_right,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    )),
                // Container(
                //     padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                //     decoration: BoxDecoration(
                //         border: Border(
                //             bottom: BorderSide(
                //       color: Colors.black12,
                //     ))),
                //     child: FlatButton(
                //       padding: EdgeInsets.only(left: 0.0),
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => IncomeDataScreen(widget.personalData)));
                //       },
                //       child: Stack(
                //         children: <Widget>[
                //           Align(
                //               alignment: Alignment.centerLeft,
                //               child: Row(
                //                 children: <Widget>[
                //                   Icon(
                //                     Icons.monetization_on,
                //                   ),
                //                   SizedBox(
                //                     width: 10,
                //                   ),
                //                   Expanded(
                //                     child: Text(
                //                       'Pendapatan',
                //                       style: TextStyle(
                //                           fontFamily: 'LeadsGo-Font',
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 16.0),
                //                     ),
                //                   ),
                //                 ],
                //               )),
                //           Align(
                //             alignment: Alignment.centerRight,
                //             child: Icon(
                //               Icons.chevron_right,
                //               size: 20,
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
              ],
            ),
          )),
    );
  }
}
