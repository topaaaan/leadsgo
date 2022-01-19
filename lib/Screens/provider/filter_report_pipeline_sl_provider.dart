import 'package:leadsgo_apps/Screens/models/filter_report_pipeline_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterReportPipelineSlItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  FilterReportPipelineSlItem(this.nik, this.tglAwal, this.tglAkhir);
}

class FilterReportPipelineSlProvider extends ChangeNotifier {
  List<FilterReportPipelineModel> _data = [];
  List<FilterReportPipelineModel> get dataPipelineFilterSlReport => _data;

  Future<List<FilterReportPipelineModel>> getPipelineFilterSlReport(
      FilterReportPipelineSlItem filterReportPipelineSlItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getPipelineReportSlFilter');
    final response = await http.post(url, body: {
      'nik_sales': filterReportPipelineSlItem.nik,
      'tgl_awal': filterReportPipelineSlItem.tglAwal,
      'tgl_akhir': filterReportPipelineSlItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Report_Pipeline_Filter_Sl']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<FilterReportPipelineModel>((json) => FilterReportPipelineModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
