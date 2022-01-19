import 'package:leadsgo_apps/Screens/models/filter_report_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterReportInteractionSlItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  FilterReportInteractionSlItem(this.nik, this.tglAwal, this.tglAkhir);
}

class FilterReportInteractionSlProvider extends ChangeNotifier {
  List<FilterReportInteractionModel> _data = [];
  List<FilterReportInteractionModel> get dataInteractionFilterSlReport => _data;

  Future<List<FilterReportInteractionModel>> getInteractionFilterSlReport(
      FilterReportInteractionSlItem filterReportInteractionSlItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getInteractionReportSlFilter');
    final response = await http.post(url, body: {
      'nik_sales': filterReportInteractionSlItem.nik,
      'tgl_awal': filterReportInteractionSlItem.tglAwal,
      'tgl_akhir': filterReportInteractionSlItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Report_Interaction_Filter_Sl']
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
