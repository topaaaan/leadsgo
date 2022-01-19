import 'package:leadsgo_apps/Screens/models/approval_disbursment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApprovalDisbursmentItem {
  String nik;

  ApprovalDisbursmentItem(this.nik);
}

class ApprovalDisbursmentProvider extends ChangeNotifier {
  List<ApprovalDisbursmentModel> _data = [];
  List<ApprovalDisbursmentModel> get dataApprovalDisbursment => _data;

  Future<List<ApprovalDisbursmentModel>> getApprovalDisbursment(
      ApprovalDisbursmentItem approvalDisbursmentItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getApprovalDisbursment');
    final response = await http.post(url, body: {'nik_sales': approvalDisbursmentItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Approval_Disbursment'];
      print(result);
      if (result != '') {
        _data = result
            .map<ApprovalDisbursmentModel>((json) => ApprovalDisbursmentModel.fromJson(json))
            .toList();
      }
      return _data;
    } else {
      throw Exception();
    }
  }
}
