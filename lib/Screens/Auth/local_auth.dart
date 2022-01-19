import 'package:flutter/material.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:local_auth/local_auth.dart';

class AutheticatedScreen extends StatefulWidget {
  @override
  _AutheticatedScreenState createState() => _AutheticatedScreenState();
}

class _AutheticatedScreenState extends State<AutheticatedScreen> {
  bool isAvailable = false;
  bool isAuthenticated = false;
  String text = "Please Check Biometric Availability";
  LocalAuthentication localAuthentication = LocalAuthentication();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Center(
              child: Text(
                'Check Biometrics',
                style: TextStyle(
                  fontFamily: 'LeadsGo-Font',
                  color: Colors.white,
                ),
              ),
            ),
            automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 200,
                margin: EdgeInsets.only(bottom: 6),
                child: RaisedButton(
                  onPressed: () async {
                    isAvailable = await localAuthentication.canCheckBiometrics;
                    if (isAvailable) {
                      List<BiometricType> types =
                          await localAuthentication.getAvailableBiometrics();
                      text = "Biometrics Availables:";
                      for (var item in types) {
                        text += "\n- $item";
                      }
                      setState(() {});
                    }
                  },
                  child: Text('Check Biometrics'),
                ),
              ),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  onPressed: isAvailable
                      ? () async {
                          isAuthenticated = await localAuthentication.authenticateWithBiometrics(
                            localizedReason: "Please authenticate",
                            stickyAuth: true,
                            useErrorDialogs: true,
                          );
                          setState(() {});
                        }
                      : null,
                  child: Text('Authenticate'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: isAuthenticated ? Colors.green : Colors.red),
              ),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}
