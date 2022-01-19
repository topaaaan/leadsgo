import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Report/report_marketing_rsl_screen.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class KantorWilayahScreen extends StatefulWidget {
  @override
  _KantorWilayahScreen createState() => _KantorWilayahScreen();

  String kode;

  KantorWilayahScreen(this.kode);
}

class _KantorWilayahScreen extends State<KantorWilayahScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://tetranabasainovasi.com/api_marsit_v1/service.php/getKantorWilayahRslReport';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(Uri.parse(apiUrl), body: {'kode': widget.kode});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Report_Kantor_Rsl'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Report_Kantor_Rsl'];
          _isLoading = false;
        }
      });
    }
  }

  String _kode(dynamic user) {
    return user['kode'];
  }

  String _nama(dynamic user) {
    return user['nama'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Kantor Cabang',
            style: fontFamily,
          ),
          actions: <Widget>[],
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReportMarketingRslScreen(
                              _kode(_users[index]), _nama(_users[index]))));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${_nama(_users[index])}'),
                    ),
                  ),
                ),
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty_outlined, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Kantor Cabang Tidak Ditemukan!',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }
}
