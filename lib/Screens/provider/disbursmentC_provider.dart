import 'package:leadsgo_apps/Screens/models/disbursmentC_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisbursmentCItem {
  String nik;

  DisbursmentCItem(this.nik);
}

class DisbursmentCProvider extends ChangeNotifier {
  List<DisbursmentCModel> _data = [];
  List<DisbursmentCModel> get dataDisbursmentC => _data;

  Future<List<DisbursmentCModel>> getDisbursmentC(
      DisbursmentCItem disbursmentCItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentC');
    final response =
        await http.post(url, body: {'nik_sales': disbursmentCItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Disbursment']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<DisbursmentCModel>((json) => DisbursmentCModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
