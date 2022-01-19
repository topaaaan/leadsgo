import 'package:leadsgo_apps/Screens/models/report_pipeline_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportPipelineSlItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  ReportPipelineSlItem(this.nik, this.tglAwal, this.tglAkhir);
}

class ReportPipelineSlProvider extends ChangeNotifier {
  List<ReportPipelineModel> _data = [];
  List<ReportPipelineModel> get dataPipelineSlReport => _data;

  Future<List<ReportPipelineModel>> getPipelineSlReport(
      ReportPipelineSlItem reportPipelineSlItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getPipelineSlReport');
    final response = await http.post(url, body: {
      'nik_sales': reportPipelineSlItem.nik,
      'tgl_awal': reportPipelineSlItem.tglAwal,
      'tgl_akhir': reportPipelineSlItem.tglAkhir
    });

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Report_Pipeline_Sl'].cast<Map<String, dynamic>>();
      _data =
          result.map<ReportPipelineModel>((json) => ReportPipelineModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
