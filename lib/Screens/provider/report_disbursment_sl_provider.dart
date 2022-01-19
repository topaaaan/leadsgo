import 'package:leadsgo_apps/Screens/models/report_disbursment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportDisbursmentSlItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  ReportDisbursmentSlItem(this.nik, this.tglAwal, this.tglAkhir);
}

class ReportDisbursmentSlProvider extends ChangeNotifier {
  List<ReportDisbursmentModel> _data = [];
  List<ReportDisbursmentModel> get dataDisbursmentSlReport => _data;

  Future<List<ReportDisbursmentModel>> getDisbursmentSlReport(
      ReportDisbursmentSlItem reportDisbursmentSlItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentSlReport');
    final response = await http.post(url, body: {
      'nik_sales': reportDisbursmentSlItem.nik,
      'tgl_awal': reportDisbursmentSlItem.tglAwal,
      'tgl_akhir': reportDisbursmentSlItem.tglAkhir
    });

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Report_Disbursment_Sl'].cast<Map<String, dynamic>>();
      _data = result
          .map<ReportDisbursmentModel>((json) => ReportDisbursmentModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
