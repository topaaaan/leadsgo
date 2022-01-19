import 'package:leadsgo_apps/Screens/models/berita_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeritaProvider extends ChangeNotifier {
  List<BeritaModel> _data = [];
  List<BeritaModel> get dataBerita => _data;

  Future<List<BeritaModel>> getBerita() async {
    final url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getBerita');
    final response = await http.get(url);
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Berita'].cast<Map<String, dynamic>>();
      _data = result.map<BeritaModel>((json) => BeritaModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
