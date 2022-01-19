import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Login/components/body.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(MdiIcons.arrowLeft, color: Colors.black),
            onPressed: () => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()), (route) => false)),
        backgroundColor: Colors.white,
        elevation: 0, // 1
        title: Text(
          'Selamat datang',
          style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
