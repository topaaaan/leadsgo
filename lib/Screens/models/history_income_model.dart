class HistoryIncomeModel {
  String id;
  String status;
  String tglIncome;
  String namaNasabah;
  String plafond;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  HistoryIncomeModel(
      {this.id, this.status, this.tglIncome, this.namaNasabah, this.plafond});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory HistoryIncomeModel.fromJson(Map<String, dynamic> json) =>
      HistoryIncomeModel(
          id: json['id'],
          status: json['status'],
          tglIncome: json['tgl_input'],
          namaNasabah: json['nama_nasabah'],
          plafond: json['plafond']);
}
