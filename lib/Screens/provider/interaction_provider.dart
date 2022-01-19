import 'package:leadsgo_apps/Screens/models/interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InteractionItem {
  String nik;

  InteractionItem(this.nik);
}

class InteractionProvider extends ChangeNotifier {
  List<InteractionModel> _data = [];
  List<InteractionModel> get dataInteraction => _data;

  Future<List<InteractionModel>> getInteraction(InteractionItem interactionItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteraction');
    final response = await http.post(url, body: {'nik_sales': interactionItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Interaction'].cast<Map<String, dynamic>>();
      _data = result.map<InteractionModel>((json) => InteractionModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
