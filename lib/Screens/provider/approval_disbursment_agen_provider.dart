import 'package:leadsgo_apps/Screens/models/approval_disbursment_agen_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApprovalDisbursmentAgenItem {
  String nik;

  ApprovalDisbursmentAgenItem(this.nik);
}

class ApprovalDisbursmentAgenProvider extends ChangeNotifier {
  List<ApprovalDisbursmentAgenModel> _data = [];
  List<ApprovalDisbursmentAgenModel> get dataApprovalDisbursmentAgen => _data;

  Future<List<ApprovalDisbursmentAgenModel>> getApprovalDisbursmentAgen(
      ApprovalDisbursmentAgenItem approvalDisbursmentAgenItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getApprovalDisbursmentAgen');
    final response = await http.post(url, body: {'nik_sales': approvalDisbursmentAgenItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['Daftar_Approval_Disbursment'];
      print(result);
      if (result != '') {
        _data = result
            .map<ApprovalDisbursmentAgenModel>(
                (json) => ApprovalDisbursmentAgenModel.fromJson(json))
            .toList();
      }

      return _data;
    } else {
      throw Exception();
    }
  }
}
