import 'package:leadsgo_apps/Screens/models/filter_report_disbursment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterReportDisbursmentSlItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  FilterReportDisbursmentSlItem(this.nik, this.tglAwal, this.tglAkhir);
}

class FilterReportDisbursmentSlProvider extends ChangeNotifier {
  List<FilterReportDisbursmentModel> _data = [];
  List<FilterReportDisbursmentModel> get dataDisbursmentFilterSlReport => _data;

  Future<List<FilterReportDisbursmentModel>> getDisbursmentFilterSlReport(
      FilterReportDisbursmentSlItem filterReportDisbursmentSlItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentReportSlFilter');
    final response = await http.post(url, body: {
      'nik_sales': filterReportDisbursmentSlItem.nik,
      'tgl_awal': filterReportDisbursmentSlItem.tglAwal,
      'tgl_akhir': filterReportDisbursmentSlItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Report_Disbursment_Filter_Sl']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<FilterReportDisbursmentModel>((json) => FilterReportDisbursmentModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
