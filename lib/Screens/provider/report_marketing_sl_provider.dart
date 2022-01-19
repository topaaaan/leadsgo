import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leadsgo_apps/Screens/models/report_marketing_model.dart';

class ReportMarketingSlItem {
  String nik;

  ReportMarketingSlItem(this.nik);
}

class ReportMarketingSlProvider extends ChangeNotifier {
  List<ReportMarketingModel> _data = [];
  List<ReportMarketingModel> get dataMarketingSlReport => _data;

  Future<List<ReportMarketingModel>> getMarketingSlReport(
      ReportMarketingSlItem reportMarketingSlItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getMarketingSlReport');
    final response = await http.post(url, body: {
      'nik_sales': reportMarketingSlItem.nik,
    });

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Report_Marketing_Sl'].cast<Map<String, dynamic>>();
      _data =
          result.map<ReportMarketingModel>((json) => ReportMarketingModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
