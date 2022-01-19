import 'package:leadsgo_apps/Screens/models/modul_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModulProvider extends ChangeNotifier {
  List<ModulModel> _data = [];
  List<ModulModel> get dataModul => _data;

  Future<List<ModulModel>> getModul() async {
    final url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getModul');
    final response = await http.get(url);
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Modul'].cast<Map<String, dynamic>>();
      _data = result.map<ModulModel>((json) => ModulModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
