class DisbursmentAModel {
  String statusGaji;
  String income;
  String idStatusGaji;
  String plafond;
  String target;
  String rate;
  String insentif;
  String gaji;
  String nasabah;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  DisbursmentAModel({
    this.statusGaji,
    this.income,
    this.idStatusGaji,
    this.plafond,
    this.target,
    this.rate,
    this.insentif,
    this.gaji,
    this.nasabah,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory DisbursmentAModel.fromJson(Map<String, dynamic> json) =>
      DisbursmentAModel(
        statusGaji: json['status_gaji_text'],
        income: json['income'],
        idStatusGaji: json['status_gaji'],
        plafond: json['jum_plafond'],
        target: json['target'],
        rate: json['rate'],
        insentif: json['insentif'],
        gaji: json['gaji'],
        nasabah: json['jum_rek'],
      );
}
