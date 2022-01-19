import 'package:leadsgo_apps/Screens/models/report_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportInteractionSlItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  ReportInteractionSlItem(this.nik, this.tglAwal, this.tglAkhir);
}

class ReportInteractionSlProvider extends ChangeNotifier {
  List<ReportInteractionModel> _data = [];
  List<ReportInteractionModel> get dataInteractionSlReport => _data;

  Future<List<ReportInteractionModel>> getInteractionSlReport(
      ReportInteractionSlItem reportInteractionSlItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteractionSlReport');
    final response = await http.post(url, body: {
      'nik_sales': reportInteractionSlItem.nik,
      'tgl_awal': reportInteractionSlItem.tglAwal,
      'tgl_akhir': reportInteractionSlItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Report_Interaction_Sl'].cast<Map<String, dynamic>>();
      _data = result
          .map<ReportInteractionModel>((json) => ReportInteractionModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
