import 'package:leadsgo_apps/Screens/models/disbursmentA_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisbursmentAItem {
  String nik;

  DisbursmentAItem(this.nik);
}

class DisbursmentAProvider extends ChangeNotifier {
  List<DisbursmentAModel> _data = [];
  List<DisbursmentAModel> get dataDisbursmentA => _data;

  Future<List<DisbursmentAModel>> getDisbursmentA(
      DisbursmentAItem disbursmentAItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentA');
    final response =
        await http.post(url, body: {'nik_sales': disbursmentAItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Disbursment']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<DisbursmentAModel>((json) => DisbursmentAModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
