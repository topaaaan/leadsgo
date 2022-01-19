import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/WebView/webview_container_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  final _links = 'https://tetranabasainovasi.com/recruitment/marketing.html';
  final _links1 = 'https://tetranabasainovasi.com/recruitment/agen.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Daftar',
          style: TextStyle(color: Colors.black, fontFamily: 'LeadsGo-Font'),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _urlButtonMarketing(context, _links),
              _urlButtonAgen(context, _links1),
            ]),
      ),
    );
  }

  Widget _urlButtonMarketing(BuildContext context, String url) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            child: Card(
                elevation: 4,
                child: Container(
                  padding: new EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'SALES LEADER',
                        style: TextStyle(color: Colors.black, fontFamily: 'LeadsGo-Font'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/mr.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Jadilah Sales Leader, Capai Targetmu, Raih Insentifmu.')
                    ],
                  ),
                )),
            onPressed: () {
              _launchURL(_links);
            }));
  }

  Widget _urlButtonAgen(BuildContext context, String url) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            child: Card(
              elevation: 4,
              child: Container(
                padding: new EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'MARKETING AGENT',
                      style: TextStyle(color: Colors.black, fontFamily: 'LeadsGo-Font'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/agen.png'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Jadilah Marketing Agent, Kerja Fleksibel, Booking, Langsung Bayar.')
                  ],
                ),
              ),
            ),
            onPressed: () {
              _launchURL(_links1);
            }));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
