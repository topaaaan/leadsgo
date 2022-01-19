import 'package:leadsgo_apps/Screens/models/filter_report_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterReportInteractionItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  FilterReportInteractionItem(this.nik, this.tglAwal, this.tglAkhir);
}

class FilterReportInteractionProvider extends ChangeNotifier {
  List<FilterReportInteractionModel> _data = [];
  List<FilterReportInteractionModel> get dataInteractionFilterReport => _data;

  Future<List<FilterReportInteractionModel>> getInteractionFilterReport(
      FilterReportInteractionItem filterReportInteractionItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteractionReportFilter');
    final response = await http.post(url, body: {
      'nik_sales': filterReportInteractionItem.nik,
      'tgl_awal': filterReportInteractionItem.tglAwal,
      'tgl_akhir': filterReportInteractionItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Report_Interaction_Filter']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<FilterReportInteractionModel>((json) => FilterReportInteractionModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
