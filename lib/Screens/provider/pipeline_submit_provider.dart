import 'package:leadsgo_apps/Screens/models/pipeline_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PipelineSubmitItem {
  String nik;

  PipelineSubmitItem(this.nik);
}

class PipelineSubmitProvider extends ChangeNotifier {
  List<PipelineModel> _data = [];
  List<PipelineModel> get dataPipeline => _data;

  Future<List<PipelineModel>> getPipeline(PipelineSubmitItem pipelineItem) async {
    final url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getPipelineSubmit');
    final response = await http.post(url, body: {'nik_sales': pipelineItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Pipeline'].cast<Map<String, dynamic>>();
      _data = result.map<PipelineModel>((json) => PipelineModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
