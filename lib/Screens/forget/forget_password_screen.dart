import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool _loading = false;
  String telepon;
  final formKey = GlobalKey<FormState>();

  //getting value from TextField widget.
  final teleponController = TextEditingController();

  Future kirimForget() async {
    setState(() {
      _loading = true;
    });
    //server login api
    var url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/forgetPassword');
    telepon = teleponController.text;
    print(telepon);
    //starting web api call
    var response = await http.post(url, body: {'telepon': telepon});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Request_Forget'];
      print(message);
      if (message['message'].toString() == 'Forget Success') {
        setState(() {
          _loading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Password berhasil dikirim, mohon periksa handphone kamu...'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadsGoColor,
        title: Text(
          'Lupa Password',
          style: TextStyle(
            fontFamily: 'LeadsGo-Font',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: grey,
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Untuk konfirmasi lupa password, mohon masukkan nomor telepon yang terdaftar di aplikasi!',
                          style: TextStyle(
                              color: Colors.black54, fontFamily: 'LeadsGo-Font', fontSize: 13),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fieldTelepon(),
                        SizedBox(
                          height: 10,
                        ),
                        fieldKirim()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No Telepon minimal 10 angka...';
        } else if (value.length > 13) {
          return 'No Telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(
        //Add th Hint text here.
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: leadsGoColor.withOpacity(0.5), width: 1.0),
          borderRadius: BorderRadius.circular(123.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: leadsGoColor, width: 1.5),
          borderRadius: BorderRadius.circular(123.0),
        ),

        hintText: "Masukan Nomor Telepon Anda",
        hintStyle: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black45),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 1.0),
          borderRadius: BorderRadius.circular(123.0),
        ),
        prefixIcon: Icon(
          MdiIcons.phone,
          color: leadsGoColor,
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(
        fontFamily: 'LeadsGo-Font',
        color: leadsGoColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget fieldKirim() {
    return _loading
        ? SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
            height: 20.0,
            width: 20.0,
          )
        : FlatButton(
            color: leadsGoColor,
            child: Text('KIRIM',
                style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 16.0, color: Colors.white)),
            onPressed: () {
              if (formKey.currentState.validate()) {
                kirimForget();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          );
  }
}
