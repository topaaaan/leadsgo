import 'package:leadsgo_apps/Screens/models/planning_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlanningItem {
  String nik;

  PlanningItem(this.nik);
}

class PlanningProvider extends ChangeNotifier {
  List<PlanningModel> _data = [];
  List<PlanningModel> get dataPlanning => _data;

  Future<List<PlanningModel>> getPlanning(PlanningItem planningItem) async {
    final url = Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getPlanning');
    final response = await http.post(url, body: {'nik_sales': planningItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Planning'].cast<Map<String, dynamic>>();
      _data = result.map<PlanningModel>((json) => PlanningModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
