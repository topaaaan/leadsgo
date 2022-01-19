import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:leadsgo_apps/Screens/Simulation/simulation_result.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';

class SimulationThtScreen extends StatefulWidget {
  String nik;
  SimulationThtScreen(this.nik);
  @override
  _SimulationThtScreenState createState() => _SimulationThtScreenState();
}

class _SimulationThtScreenState extends State<SimulationThtScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String plafondPinjaman;
  String takeoverBankLain;
  String angsuranPerbulan;
  String bankAmbilGaji;
  String batasUsiaPensiun;
  String tht;

  var selectedBlokirAngsuranType;
  List<String> _blokirAngsuran = <String>['0', '1', '2', '3', '4', '5'];
  var selectedPensiun;
  List<String> _jenisKredit = <String>['Kredit Baru', 'Renewal'];
  var selectedJenisKredit;
  List<String> _jenisPensiun = <String>['Prapensiun'];
  var selectedJangkaWaktuType;
  List<String> _jangkaWaktu = <String>[
    '12',
    '24',
    '36',
    '48',
    '60',
    '72',
    '84',
    '96',
    '108',
    '120',
    '132',
    '144',
    '156',
    '168',
    '180'
  ];
  var selectedAsuransiType;
  List<String> _asuransiType = <String>['TIB', 'GRM', 'BNI LIFE'];

  //Getting value from TextField widget.
  final namaPensiunController = TextEditingController();
  final gajiPensiunController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final tanggalLahirController = TextEditingController();
  final plafondPinjamanController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final takeoverBankLainController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final angsuranController = TextEditingController();
  final bankAmbilGajiController = TextEditingController();
  final batasUsiaPensiunController = TextEditingController();
  final thtController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  getDataInputan() {
    //Getting value from controller.
    namaPensiun = namaPensiunController.text;
    gajiPensiun = gajiPensiunController.text;
    tanggalLahir = tanggalLahirController.text;
    plafondPinjaman = plafondPinjamanController.text;
    takeoverBankLain = takeoverBankLainController.text;
    angsuranPerbulan = angsuranController.text;
    bankAmbilGaji = bankAmbilGajiController.text;
    batasUsiaPensiun = batasUsiaPensiunController.text;
    tht = thtController.text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Prapensiun THT',
            style: TextStyle(fontFamily: 'LeadsGo-Font'),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
            child: Form(
              key: formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  namaCalonDebitur(),
                  gajiCalonDebitur(),
                  tanggalLahirCalonDebitur(),
                  plafondCalonDebitur(),
                  pelunasanCalonDebitur(),
                  bankGajiCalonDebitur(),
                  batasUsiaPensiunDebitur(),
                  thtDebitur(),
                  typeSimulasiCalonDebitur(),
                  typeCreditCalonDebitur(),
                  jangkaWaktuCalonDebitur(),
                  asuransiCalonDebitur(),
                  blokirAngsuranDebitur(),
                  //angsuranCalonDebitur(),

                  calculationButton(),
                ],
              ),
            )),
      ),
    );
  }

  Widget typeSimulasiCalonDebitur() {
    return DropdownButtonFormField(
      items: _jenisPensiun
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedJenisPensiunType) {
        setState(() {
          selectedPensiun = selectedJenisPensiunType;
        });
      },
      decoration: InputDecoration(
          labelText: 'Simulasi',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
      value: selectedPensiun,
      isExpanded: true,
    );
  }

  Widget typeCreditCalonDebitur() {
    return DropdownButtonFormField(
      items: _jenisKredit
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedJenisKreditType) {
        setState(() {
          selectedJenisKredit = selectedJenisKreditType;
        });
      },
      decoration: InputDecoration(
          labelText: 'Kredit',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
      value: selectedJenisKredit,
      isExpanded: true,
    );
  }

  Widget namaCalonDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama lengkap wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Nama Lengkap",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Nama Lengkap"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget gajiCalonDebitur() {
    return TextFormField(
      controller: gajiPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Gaji terakhir wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Gaji Terakhir",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Gaji Terakhir"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget tanggalLahirCalonDebitur() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        controller: tanggalLahirController,
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return 'Tanggal lahir wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(
            //Add th Hint text here.
            hintText: "Tanggal Lahir",
            hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
            labelText: "Tanggal Lahir"),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
      ),
    ]);
  }

  Widget bankGajiCalonDebitur() {
    return TextFormField(
      controller: bankAmbilGajiController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Bank ambil gaji wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Bank Ambil Gaji",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Bank Ambil Gaji"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget plafondCalonDebitur() {
    return TextFormField(
      controller: plafondPinjamanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Plafond wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Plafond",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Plafond"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget jangkaWaktuCalonDebitur() {
    return DropdownButtonFormField(
      items: _jangkaWaktu
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedJangkaWaktu) {
        setState(() {
          selectedJangkaWaktuType = selectedJangkaWaktu;
        });
      },
      decoration: InputDecoration(
          labelText: 'Jangka Waktu',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
      value: selectedJangkaWaktuType,
      isExpanded: true,
    );
  }

  Widget blokirAngsuranDebitur() {
    return DropdownButtonFormField(
      items: _blokirAngsuran
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedBlokirAngsuran) {
        setState(() {
          selectedBlokirAngsuranType = selectedBlokirAngsuran;
        });
      },
      decoration: InputDecoration(
          labelText: 'Blokir Angsuran',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
      value: selectedBlokirAngsuranType,
      isExpanded: true,
    );
  }

  Widget batasUsiaPensiunDebitur() {
    return TextFormField(
      controller: batasUsiaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Batas usia pensiun wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Batas Usia Pensiun (bulan)",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Batas Usia Pensiun (bulan)"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget pelunasanCalonDebitur() {
    return TextFormField(
      controller: takeoverBankLainController,
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Hutang Bank Lain",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Hutang Bank Lain"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget angsuranCalonDebitur() {
    return TextFormField(
      controller: angsuranController,
      decoration: InputDecoration(
        labelText: 'Angsuran per Bulan',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget asuransiCalonDebitur() {
    return DropdownButtonFormField(
      items: _asuransiType
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedAsuransi) {
        setState(() {
          selectedAsuransiType = selectedAsuransi;
        });
      },
      decoration: InputDecoration(
          labelText: 'Asuransi',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(fontFamily: 'LeadsGo-Font', fontSize: 12)),
      value: selectedAsuransiType,
      isExpanded: true,
    );
  }

  Widget thtDebitur() {
    return TextFormField(
      controller: thtController,
      validator: (value) {
        if (value.isEmpty) {
          return 'THT wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "THT",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "THT"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 12, fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget calculationButton() {
    //MEMBUAT TOMBOL SUBMIT
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        color: leadsGoColor, //MENGATUR WARNA TOMBOL
        onPressed: () {
          if (formKey.currentState.validate()) {
            if (selectedPensiun == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih jenis simulasi...'),
                duration: Duration(seconds: 3),
              ));
            } else if (selectedJenisKredit == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih jenis kredit...'),
                duration: Duration(seconds: 3),
              ));
            } else if (selectedJangkaWaktuType == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih jangka waktu...'),
                duration: Duration(seconds: 3),
              ));
            } else if (selectedAsuransiType == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih jenis asuransi...'),
                duration: Duration(seconds: 3),
              ));
            } else if (selectedBlokirAngsuranType == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih blokir angsuran...'),
                duration: Duration(seconds: 3),
              ));
            } else {
              setState(() {
                getDataInputan();
                //print(selectedAsuransiType);
              });
              String gajiFix = gajiPensiun.substring(0, gajiPensiun.length - 3);
              gajiFix = gajiFix.replaceAll(',', '');
              String plafondFix = plafondPinjaman.substring(0, plafondPinjaman.length - 3);
              plafondFix = plafondFix.replaceAll(',', '');
              String takeoverBankLainFix =
                  takeoverBankLain.substring(0, takeoverBankLain.length - 3);
              takeoverBankLainFix = takeoverBankLainFix.replaceAll(',', '');
              String thtFix = tht.substring(0, tht.length - 3);
              thtFix = thtFix.replaceAll(',', '');
              //print(gajiFix);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SimulationResult(
                          'tht',
                          namaPensiun,
                          gajiFix,
                          tanggalLahir,
                          selectedPensiun,
                          selectedJenisKredit,
                          bankAmbilGaji,
                          plafondFix,
                          selectedJangkaWaktuType,
                          selectedAsuransiType,
                          selectedBlokirAngsuranType,
                          takeoverBankLainFix,
                          angsuranPerbulan,
                          batasUsiaPensiun,
                          thtFix,
                          widget.nik))).then((result) {});
            }
          }
        },
        child: Text(
          'Hitung',
          style: TextStyle(color: Colors.white, fontFamily: 'LeadsGo-Font'),
        ),
      ),
    );
  }
}
