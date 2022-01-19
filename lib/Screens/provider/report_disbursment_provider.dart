import 'package:leadsgo_apps/Screens/models/report_disbursment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportDisbursmentItem {
  String nik;
  String tglAwal;
  String tglAkhir;

  ReportDisbursmentItem(this.nik, this.tglAwal, this.tglAkhir);
}

class ReportDisbursmentProvider extends ChangeNotifier {
  List<ReportDisbursmentModel> _data = [];
  List<ReportDisbursmentModel> get dataDisbursmentReport => _data;

  Future<List<ReportDisbursmentModel>> getDisbursmentReport(
      ReportDisbursmentItem reportDisbursmentItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getDisbursmentReport');
    final response = await http.post(url, body: {
      'nik_sales': reportDisbursmentItem.nik,
      'tgl_awal': reportDisbursmentItem.tglAwal,
      'tgl_akhir': reportDisbursmentItem.tglAkhir
    });
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Report_Disbursment'].cast<Map<String, dynamic>>();
      _data = result
          .map<ReportDisbursmentModel>((json) => ReportDisbursmentModel.fromJson(json))
          .toList();
      //print(result);
      return _data;
    } else {
      throw Exception();
    }
  }
}
