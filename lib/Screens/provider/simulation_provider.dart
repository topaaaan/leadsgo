import 'package:leadsgo_apps/Screens/models/simulation_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class simulationItem {
  String simulasiJenis;
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String tanggalPensiun;
  String tht;
  String plafondPinjaman;
  String bankBayarPensiun;
  String jangkaWaktu;
  String bunga;
  String niksales;
  // String jenisSimulasi;
  // String jenisKredit;
  // String jenisAsuransi;
  // String blokirAngsuran;
  // String takeoverBankLain;
  // String angsuranPerbulan;
  // String batasUsiaPensiun;
  simulationItem(
    this.simulasiJenis,
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.tanggalPensiun,
    this.tht,
    this.plafondPinjaman,
    this.bankBayarPensiun,
    this.jangkaWaktu,
    this.bunga,
    this.niksales,
    // this.jenisSimulasi,
    // this.jenisKredit,
    // this.jenisAsuransi,
    // this.blokirAngsuran,
    // this.takeoverBankLain,
    // this.angsuranPerbulan,
    // this.batasUsiaPensiun,
  );
}

class SimulationProvider extends ChangeNotifier {
  List<SimulationModel> _data = [];
  List<SimulationModel> get dataSimulation => _data;

  Future<List<SimulationModel>> getSimulation(simulationItem simulation) async {
    String url = '';
    if (simulation.simulasiJenis == 'prapensiun') {
      url =
          'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSimulasiPrapensiunBNew';
    } else {
      url =
          'https://tetranabasainovasi.com/api_marsit_v1/service.php/getSimulasiPensiunNew';
    }
    final response = await http.post(Uri.parse(url), body: {
      'nama_pensiun': simulation.namaPensiun,
      'gaji_pensiun': simulation.gajiPensiun,
      'tanggal_lahir': simulation.tanggalLahir,
      'tanggal_pensiun': simulation.tanggalPensiun,
      'tht': simulation.tht,
      'plafond_pinjaman': simulation.plafondPinjaman,
      'bank_bayar_pensiun': simulation.bankBayarPensiun,
      'jangka_waktu': simulation.jangkaWaktu,
      'bunga': simulation.bunga,
      'niksales': simulation.niksales,
      // 'jenis_simulasi': simulation.jenisSimulasi,
      // 'jenis_kredit': simulation.jenisKredit,
      // 'jenis_asuransi': simulation.jenisAsuransi,
      // 'blokir_pinjaman': simulation.blokirAngsuran,
      // 'takeover_bank_lain': simulation.takeoverBankLain,
      // 'angsuran_perbulan': simulation.angsuranPerbulan,
      // 'batas_usia_pensiun': simulation.batasUsiaPensiun,
    });

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Simulasi']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<SimulationModel>((json) => SimulationModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
