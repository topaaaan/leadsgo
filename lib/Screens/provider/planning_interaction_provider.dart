import 'package:leadsgo_apps/Screens/models/planning_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InteractionItem {
  String nik;

  InteractionItem(this.nik);
}

class PlanningInteractionProvider extends ChangeNotifier {
  List<PlanningInteractionModel> _data = [];
  List<PlanningInteractionModel> get dataInteraction => _data;

  Future<List<PlanningInteractionModel>> getInteraction(InteractionItem interactionItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getPlanningInteraction');
    final response = await http.post(url, body: {'nik_sales': interactionItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Planning'].cast<Map<String, dynamic>>();
      _data = result
          .map<PlanningInteractionModel>((json) => PlanningInteractionModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
