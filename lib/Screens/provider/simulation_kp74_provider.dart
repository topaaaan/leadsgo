import 'package:leadsgo_apps/Screens/models/simulation_kp74_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class simulationKp74Item {
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String sukuBunga;
  String angsuranPerbulan;
  String jangkaWaktu;

  simulationKp74Item(
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.sukuBunga,
    this.angsuranPerbulan,
    this.jangkaWaktu,
  );
}

class SimulationKp74Provider extends ChangeNotifier {
  List<SimulationKp74Model> _data = [];
  List<SimulationKp74Model> get dataSimulationKp74 => _data;

  Future<List<SimulationKp74Model>> getSimulationKp74(simulationKp74Item simulationkp74) async {
    var url =
        Uri.parse('https://tetranabasainovasi.com/api_marsit_v1/service.php/getSimulationKp74');
    final response = await http.post(url, body: {
      'nama': simulationkp74.namaPensiun,
      'gaji': simulationkp74.gajiPensiun,
      'tgllahir': simulationkp74.tanggalLahir,
      'bunga': simulationkp74.sukuBunga,
      'angsuran': simulationkp74.angsuranPerbulan,
      'jangka': simulationkp74.jangkaWaktu,
    });

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Daftar_Simulasi_Kp74'].cast<Map<String, dynamic>>();
      _data =
          result.map<SimulationKp74Model>((json) => SimulationKp74Model.fromJson(json)).toList();
      return _data;
      print(result);
    } else {
      throw Exception();
    }
  }
}
