//import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class SimulationKp74Model {
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String sukuBunga;
  String angsuran;
  String iir;
  String sisaGaji;
  String umur;
  String premi;
  String plafond;
  String jw;
  String madm;
  String mprovi;
  String mpremi;
  String bmeterai;
  String simpananSukarela;
  String simpananPokok;
  String simpananWajib;
  String jumlahBiaya;
  String jumlahBersih;
  String jumlahAngsuran;
  String messageText;
  String nilai;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  SimulationKp74Model(
      {this.namaPensiun,
      this.gajiPensiun,
      this.tanggalLahir,
      this.sukuBunga,
      this.angsuran,
      this.iir,
      this.sisaGaji,
      this.umur,
      this.premi,
      this.plafond,
      this.jw,
      this.madm,
      this.mprovi,
      this.mpremi,
      this.bmeterai,
      this.simpananSukarela,
      this.simpananPokok,
      this.simpananWajib,
      this.jumlahBiaya,
      this.jumlahBersih,
      this.jumlahAngsuran,
      this.messageText,
      this.nilai});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory SimulationKp74Model.fromJson(Map<String, dynamic> json) =>
      SimulationKp74Model(
          namaPensiun: json['nama_pensiun'],
          gajiPensiun: json['gaji_pensiun'],
          tanggalLahir: json['tanggal_lahir'],
          sukuBunga: json['suku_bunga'],
          angsuran: json['angsuran_perbulan'],
          iir: json['iir'],
          sisaGaji: json['sisa_gaji'],
          umur: json['umur'],
          premi: json['premi'],
          plafond: json['plafond'],
          jw: json['jw'],
          madm: json['madm'],
          mprovi: json['mprovi'],
          mpremi: json['mpremi'],
          bmeterai: json['bmeterai'],
          simpananSukarela: json['simpanan_sukarela'],
          simpananPokok: json['simpanan_pokok'],
          simpananWajib: json['simpanan_wajib'],
          jumlahBiaya: json['jumlah_biaya'],
          jumlahBersih: json['jumlah_bersih'],
          jumlahAngsuran: json['jumlah_angsuran'],
          messageText: json['message'],
          nilai: json['nilai']);
}
