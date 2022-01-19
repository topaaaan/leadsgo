import 'package:leadsgo_apps/Screens/models/report_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportInteractionItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  ReportInteractionItem(this.nik, this.tglAwal, this.tglAkhir);
}

class ReportInteractionProvider extends ChangeNotifier {
  List<ReportInteractionModel> _data = [];
  List<ReportInteractionModel> get dataInteractionReport => _data;

  Future<List<ReportInteractionModel>> getInteractionReport(
      ReportInteractionItem reportInteractionItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteractionReport');
    final response = await http.post(url, body: {
      'nik_sales': reportInteractionItem.nik,
      'tgl_awal': reportInteractionItem.tglAwal,
      'tgl_akhir': reportInteractionItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Report_Interaction'].cast<Map<String, dynamic>>();
      _data = result
          .map<ReportInteractionModel>((json) => ReportInteractionModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
