import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leadsgo_apps/Screens/Simulation/simulation_gp_screen.dart';
import 'package:leadsgo_apps/Screens/Simulation/simulation_image.dart';
import 'package:leadsgo_apps/Screens/Simulation/simulation_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';

class SimulationViewScreen extends StatefulWidget {
  String nik;
  SimulationViewScreen(this.nik);
  @override
  _SimulationViewScreenState createState() => _SimulationViewScreenState();
}

class _SimulationViewScreenState extends State<SimulationViewScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Simulasi',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: Colors.grey.shade50,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Colors.black12,
              //       ),
              //     ),
              //   ),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => SimulationPegawaiAktifScreen(widget.nik)));
              //     },
              //     child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              //       ListTile(
              //         leading: ScaleTransition(
              //           scale: _animation,
              //           child: Image.asset(
              //             'assets/images/pns_aktif.png',
              //             height: 50,
              //           ),
              //         ),
              //         title: Text(
              //           'PNS Aktif',
              //           style: TextStyle(
              //             fontSize: 20,
              //             color: Colors.cyan[600],
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         subtitle: Text(
              //           'PNS aktif reguler',
              //           style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //               fontStyle: FontStyle.italic),
              //         ),
              //       ),
              //     ]),
              //   ),
              // ),
              FadeAnimation(
                0.5,
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SimulationGpScreen(widget.nik)));
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: ScaleTransition(
                              scale: _animation,
                              child: Image.asset(
                                'assets/images/pns_aktif.png',
                                height: 50,
                              ),
                            ),
                            title: Text(
                              'Prapensiun',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Grace Period < 3 Tahun',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              // Container(
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(
              //           color: Colors.black12,
              //         ),
              //       ),
              //     ),
              //     child: InkWell(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) =>
              //                     SimulationRegulerPrapensiunScreen(
              //                         widget.nik)));
              //       },
              //       child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             ListTile(
              //               leading: ScaleTransition(
              //                 scale: _animation,
              //                 child: Image.asset(
              //                   'assets/images/prapens_10.png',
              //                   height: 50,
              //                 ),
              //               ),
              //               title: Text(
              //                 'Prapensiun',
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   color: Colors.orange[800],
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               subtitle: Text(
              //                 'Combo < 10 Tahun',
              //                 style: TextStyle(
              //                     fontSize: 14,
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.bold,
              //                     fontStyle: FontStyle.italic),
              //               ),
              //             ),
              //           ]),
              //     )),
              FadeAnimation(
                0.5,
                Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SimulationScreen(widget.nik)));
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: ScaleTransition(
                                scale: _animation,
                                child: Image.asset(
                                  'assets/images/pensiun.png',
                                  height: 50,
                                ),
                              ),
                              title: Text(
                                'Pensiun',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Pensiunan regular',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ]),
                    )),
              ),
              // Container(
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(
              //           color: Colors.black12,
              //         ),
              //       ),
              //     ),
              //     child: InkWell(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => SimulationKp74Screen()));
              //       },
              //       child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             ListTile(
              //               leading: ScaleTransition(
              //                 scale: _animation,
              //                 child: Image.asset(
              //                   'assets/images/platinum.png',
              //                   height: 50,
              //                 ),
              //               ),
              //               title: Text(
              //                 'Pensiunan Platinum',
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   color: Colors.indigo[900],
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               subtitle: Text(
              //                 'Pensiunan 70 tahun sampai 80 tahun',
              //                 style: TextStyle(
              //                     fontSize: 14,
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.bold,
              //                     fontStyle: FontStyle.italic),
              //               ),
              //             ),
              //           ]),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
