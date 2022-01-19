import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Disbursment/view_image.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class InteractionViewScreen extends StatefulWidget {
  String calonDebitur;
  String alamat;
  String email;
  String telepon;
  String rencanaPinjaman;
  String salesFeedback;
  String foto;
  String tanggalInteraksi;
  String jamInteraksi;
  String status;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String propinsi;

  InteractionViewScreen(
    this.calonDebitur,
    this.alamat,
    this.email,
    this.telepon,
    this.rencanaPinjaman,
    this.salesFeedback,
    this.foto,
    this.tanggalInteraksi,
    this.jamInteraksi,
    this.status,
    this.kelurahan,
    this.kecamatan,
    this.kabupaten,
    this.propinsi,
  );
  @override
  _InteractionViewScreenState createState() => _InteractionViewScreenState();
}

class _InteractionViewScreenState extends State<InteractionViewScreen> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    String foto = 'https://tetranabasainovasi.com/marsit/' + widget.foto;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            '${widget.calonDebitur}',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                String teleponFix = '+62' + widget.telepon.substring(1);
                launchWhatsApp(phone: teleponFix, message: 'Tes');
              },
              icon: Icon(MdiIcons.whatsapp),
              iconSize: 20,
            ),
            IconButton(
              onPressed: () {
                _makePhoneCall('tel:${widget.telepon}');
              },
              icon: Icon(Icons.call),
              iconSize: 20,
            )
          ],
        ),
        body: Container(
          color: grey,
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Dokumen Interaksi',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImageView(foto, 'Foto Interaksi')));
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(foto),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Interaksi',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Alamat', setNull(widget.alamat), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Kelurahan', setNull(widget.kelurahan), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Kecamatan', setNull(widget.kecamatan), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Kabupaten',
                      setNull(widget.kabupaten),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur(
                      'Propinsi',
                      setNull(widget.propinsi),
                      120.0,
                    ),
                    SizedBox(height: 10),
                    fieldDebitur('Email', setNull(widget.email), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('No Telepon', setNull(widget.telepon), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Rencana Pinjaman', formatRupiah(setNull(widget.rencanaPinjaman)), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Sales Feedback', setNull(widget.salesFeedback), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Tanggal', setNull(widget.tanggalInteraksi), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Jam', setNull(widget.jamInteraksi), 120.0),
                    SizedBox(height: 10),
                    fieldDebitur('Status', setStatusInteraksi(setNull(widget.status)), 120.0),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldDebitur(title, value, size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          decoration: new BoxDecoration(
            color: leadsGoColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: TextStyle(fontFamily: 'LeadsGo-Font', fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
      ],
    );
  }

  setNull(String data) {
    if (data == null || data == '') {
      return '-';
    } else {
      return data;
    }
  }

  setColorStatusInteraksi(String nilai) {
    if (nilai == '0') {
      return Colors.blue;
    } else if (nilai == '1') {
      return Colors.green;
    } else if (nilai == '11') {
      return Colors.red;
    }
  }

  setStatusInteraksi(String nilai) {
    if (nilai == '0') {
      return 'Menunggu Persetujuan';
    } else if (nilai == '1') {
      return 'Disetujui Sales Leader';
    } else if (nilai == '11') {
      return 'Ditolak Sales Leader ';
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
    return 'IDR ' + fmf.output.withoutFractionDigits;
  }
}
