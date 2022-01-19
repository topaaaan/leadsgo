import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:leadsgo_apps/Screens/Simulation/simulation_result.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';

class SimulationGpScreen extends StatefulWidget {
  String nik;

  SimulationGpScreen(this.nik);
  @override
  _SimulationGpScreenState createState() => _SimulationGpScreenState();
}

class _SimulationGpScreenState extends State<SimulationGpScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String tanggalPensiun;
  String plafondPinjaman;
  String tht;
  String takeoverBankLain;
  String angsuranPerbulan;
  String bankAmbilGaji;
  String batasUsiaPensiun;

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
  var selectedBankPilihanType;
  List<String> _bankPilihan = <String>['KB Bukopin', 'Bank Lain'];
  var selectedAsuransiType;
  List<String> _asuransiType = <String>['TIB', 'GRM', 'BNI LIFE'];
  var selectedBungaType;
  List<String> _bunga = <String>['12', '12.5', '13'];

  //Getting value from TextField widget.
  final namaPensiunController = TextEditingController();
  final gajiPensiunController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final tanggalPensiunController = TextEditingController();
  final plafondPinjamanController = TextEditingController();
  final thtController = TextEditingController();
  final takeoverBankLainController = TextEditingController();
  final angsuranController = TextEditingController();
  final bankAmbilGajiController = TextEditingController();
  final batasUsiaPensiunController = TextEditingController();

  getDataInputan() {
    //Getting value from controller.
    namaPensiun = namaPensiunController.text;
    gajiPensiun = gajiPensiunController.text;
    tanggalLahir = tanggalLahirController.text;
    tanggalPensiun = tanggalPensiunController.text;
    plafondPinjaman = plafondPinjamanController.text;
    tht = thtController.text;
    takeoverBankLain = takeoverBankLainController.text;
    angsuranPerbulan = angsuranController.text;
    bankAmbilGaji = bankAmbilGajiController.text;
    batasUsiaPensiun = batasUsiaPensiunController.text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Prapensiun',
            style: TextStyle(fontFamily: 'LeadsGo-Font'),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
            child: Form(
              key: formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  namaCalonDebitur(),
                  gajiCalonDebitur(),
                  tanggalLahirCalonDebitur(),
                  tanggalPensiunCalonDebitur(),
                  plafondCalonDebitur(),
                  danaTht(),
                  pilihanBank(),
                  // pelunasanCalonDebitur(),
                  // bankGajiCalonDebitur(),
                  // batasUsiaPensiunDebitur(),
                  // typeSimulasiCalonDebitur(),
                  // typeCreditCalonDebitur(),
                  jangkaWaktuCalonDebitur(),
                  bunga(),
                  // asuransiCalonDebitur(),
                  // blokirAngsuranDebitur(),
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
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
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
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
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
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
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
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
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
          hintText: "Isi Nama Debitur Anda",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Nama Lengkap"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
          hintText: "Estimasi Gaji Pokok Pensiun",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Estimasi Gaji Pensiun"),
      keyboardType: TextInputType.number,
      inputFormatters: [DecimalFormatter()],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
        style: TextStyle(fontFamily: 'LeadsGo-Font'),
      ),
    ]);
  }

  Widget tanggalPensiunCalonDebitur() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        controller: tanggalPensiunController,
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return 'Tanggal pensiun wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(
            //Add th Hint text here.
            hintText: "Tanggal Pensiun",
            hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
            labelText: "Tanggal Pensiun"),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget pilihanBank() {
    return DropdownButtonFormField(
      items: _bankPilihan
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedBankPilihan) {
        setState(() {
          selectedBankPilihanType = selectedBankPilihan;
        });
      },
      decoration: InputDecoration(
          labelText: 'Bank Ambil Gaji',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
      value: selectedBankPilihanType,
      isExpanded: true,
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
          hintText: "Plafond yang diminta debitur",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Plafond"),
      keyboardType: TextInputType.number,
      inputFormatters: [DecimalFormatter()],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget danaTht() {
    return TextFormField(
      controller: thtController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Dana THT wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Isi 80% dari dana THT debitur",
          hintStyle: TextStyle(fontFamily: 'LeadsGo-Font'),
          labelText: "Dana THT"),
      keyboardType: TextInputType.number,
      inputFormatters: [DecimalFormatter()],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget jangkaWaktuCalonDebitur() {
    return DropdownButtonFormField(
      items: _jangkaWaktu
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
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
          labelText: 'Jangka Waktu (bulan)',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
      value: selectedJangkaWaktuType,
      isExpanded: true,
    );
  }

  Widget bunga() {
    return DropdownButtonFormField(
      items: _bunga
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedBunga) {
        setState(() {
          selectedBungaType = selectedBunga;
        });
      },
      decoration: InputDecoration(
          labelText: 'Rate Bunga',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
      value: selectedBungaType,
      isExpanded: true,
    );
  }

  Widget blokirAngsuranDebitur() {
    return DropdownButtonFormField(
      items: _blokirAngsuran
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
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
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
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
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
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
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget angsuranCalonDebitur() {
    return TextFormField(
      controller: angsuranController,
      decoration: InputDecoration(
        labelText: 'Angsuran per Bulan',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'LeadsGo-Font'),
    );
  }

  Widget asuransiCalonDebitur() {
    return DropdownButtonFormField(
      items: _asuransiType
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'LeadsGo-Font',
                  ),
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
          labelStyle: TextStyle(
            fontFamily: 'LeadsGo-Font',
          )),
      value: selectedAsuransiType,
      isExpanded: true,
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
            if (selectedBankPilihanType == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih Bank ambil gaji debitur...'),
                duration: Duration(seconds: 3),
              ));
            } else if (selectedJangkaWaktuType == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Mohon pilih jangka waktu...'),
                duration: Duration(seconds: 3),
              ));
            } else {
              setState(() {
                getDataInputan();
                //print(selectedAsuransiType);
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SimulationResult(
                          'prapensiun',
                          namaPensiun,
                          gajiPensiun,
                          tanggalLahir,
                          tanggalPensiun,
                          tht,
                          plafondPinjaman,
                          selectedBankPilihanType,
                          // bankAmbilGaji,
                          selectedJangkaWaktuType,
                          selectedBungaType,
                          // selectedPensiun,
                          // selectedJenisKredit,
                          // selectedAsuransiType,
                          // selectedBlokirAngsuranType,
                          // takeoverBankLain,
                          // angsuranPerbulan,
                          // batasUsiaPensiun,
                          // '0',
                          widget.nik))).then((result) {});
            }
          }
        },
        child: Text(
          'Hitung',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'LeadsGo-Font',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9\.]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > this.decimalDigits)) {
        return oldValue;
      } else
        return newValue;
    }

    //in case if input is empty or zero
    if (newText.trim() == '' || newText.trim() == '0') {
      return newValue.copyWith(text: '');
    } else if (int.parse(newText) < 1) {
      return newValue.copyWith(text: '');
    }

    double newDouble = double.parse(newText);
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = NumberFormat("#,##0.##").format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
