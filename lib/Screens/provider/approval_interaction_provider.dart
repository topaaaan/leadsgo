import 'package:leadsgo_apps/Screens/models/approval_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApprovalInteractionItem {
  String nik;

  ApprovalInteractionItem(this.nik);
}

class ApprovalInteractionProvider extends ChangeNotifier {
  List<ApprovalInteractionModel> _data = [];
  List<ApprovalInteractionModel> get dataApprovalInteraction => _data;

  Future<List<ApprovalInteractionModel>> getApprovalInteraction(
      ApprovalInteractionItem interactionItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getApprovalInteraction');
    final response = await http.post(url, body: {'nik_sales': interactionItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Approval_Interaction'].cast<Map<String, dynamic>>();
      _data = result
          .map<ApprovalInteractionModel>((json) => ApprovalInteractionModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
