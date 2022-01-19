import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leadsgo_apps/Screens/WebView/webview_container_screen.dart';
import 'package:leadsgo_apps/constants.dart';

class UtilityScreen extends StatefulWidget {
  @override
  _UtilityScreenState createState() => _UtilityScreenState();
}

class _UtilityScreenState extends State<UtilityScreen> {
  final _linkss = 'https://eform.bni.co.id/';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Bantuan',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    _handleURLButtonPress(context, _linkss);
                  },
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/menus/utilities.svg',
                        height: 50,
                      ),
                      title: Text(
                        'e-Form BNI',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Layanan Digital BNI',
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
            ],
          ),
        ),
      ),
    );
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
