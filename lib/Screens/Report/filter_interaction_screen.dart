import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:leadsgo_apps/Screens/Report/filter_interaction.dart';

import '../../constants.dart';

class FilterInteractionScreen extends StatefulWidget {
  String nik;

  FilterInteractionScreen(this.nik);
  @override
  _FilterInteractionScreenState createState() => _FilterInteractionScreenState();
}

class _FilterInteractionScreenState extends State<FilterInteractionScreen> {
  final formKey = GlobalKey<FormState>();
  String tanggalAwal;
  String tanggalAkhir;
  //Getting value from TextField widget.
  final tanggalAwalController = TextEditingController();
  final tanggalAkhirController = TextEditingController();

  getDataInputan() {
    //Getting value from controller.
    tanggalAwal = tanggalAwalController.text;
    tanggalAkhir = tanggalAkhirController.text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Filter Interaction',
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
                  tanggalAwalField(),
                  tanggalAkhirField(),
                  filterButton(),
                ],
              ),
            )),
      ),
    );
  }

  Widget tanggalAwalField() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        controller: tanggalAwalController,
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return 'Tanggal awal wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Tanggal Awal'),
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

  Widget tanggalAkhirField() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        controller: tanggalAkhirController,
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return 'Tanggal akhir wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Tanggal Akhir'),
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

  Widget filterButton() {
    //MEMBUAT TOMBOL SUBMIT
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: leadsGoColor, //MENGATUR WARNA TOMBOL
        onPressed: () {
          setState(() {
            getDataInputan();
            //print(selectedAsuransiType);
          });
          if (formKey.currentState.validate()) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FilterInteractionReportScreen(widget.nik, tanggalAwal, tanggalAkhir)));
          }
        },
        child: Text(
          'Cari',
          style: TextStyle(color: Colors.white, fontFamily: 'LeadsGo-Font'),
        ),
      ),
    );
  }
}