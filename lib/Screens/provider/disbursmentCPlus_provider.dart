import 'package:leadsgo_apps/Screens/models/disbursmentCPlus_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisbursmentCPlusItem {
  String nik;

  DisbursmentCPlusItem(this.nik);
}

class DisbursmentCPlusProvider extends ChangeNotifier {
  List<DisbursmentCPlusModel> _data = [];
  List<DisbursmentCPlusModel> get dataDisbursmentCPlus => _data;

  Future<List<DisbursmentCPlusModel>> getDisbursmentCPlus(
      DisbursmentCPlusItem disbursmentCPlusItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentCPlus');
    final response =
        await http.post(url, body: {'nik_sales': disbursmentCPlusItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Disbursment']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<DisbursmentCPlusModel>(
              (json) => DisbursmentCPlusModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
