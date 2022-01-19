import 'package:leadsgo_apps/Screens/models/filter_report_disbursment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterReportDisbursmentItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  FilterReportDisbursmentItem(this.nik, this.tglAwal, this.tglAkhir);
}

class FilterReportDisbursmentProvider extends ChangeNotifier {
  List<FilterReportDisbursmentModel> _data = [];
  List<FilterReportDisbursmentModel> get dataFilterDisbursmentReport => _data;

  Future<List<FilterReportDisbursmentModel>> getDisbursmentFilterReport(
      FilterReportDisbursmentItem filterReportDisbursmentItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentReportFilter');
    final response = await http.post(url, body: {
      'nik_sales': filterReportDisbursmentItem.nik,
      'tgl_awal': filterReportDisbursmentItem.tglAwal,
      'tgl_akhir': filterReportDisbursmentItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Report_Disbursment_Filter']
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
