import 'package:leadsgo_apps/Screens/models/disbursment_akad_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisbursmentAkadItem {
  String nik;

  DisbursmentAkadItem(this.nik);
}

class DisbursmentAkadProvider extends ChangeNotifier {
  List<DisbursmentAkadModel> _data = [];
  List<DisbursmentAkadModel> get dataDisbursmentAkad => _data;

  Future<List<DisbursmentAkadModel>> getDisbursmentAkad(
      DisbursmentAkadItem disbursmentAkadItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentAkad');
    final response = await http.post(url, body: {'nik_sales': disbursmentAkadItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Disbursment_Akad'].cast<Map<String, dynamic>>();
      _data =
          result.map<DisbursmentAkadModel>((json) => DisbursmentAkadModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
