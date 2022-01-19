class DisbursmentCPlusModel {
  String new_to_plafond;
  String new_to_noa;
  String new_to_rate;
  String new_to_income;
  String top_up_plafond;
  String top_up_noa;
  String top_up_rate;
  String top_up_income;
  String plafond;
  String noa;
  String new_to_transport;
  String top_up_transport;
  String transport;
  String income;
  String thp;
  String new_to_done;
  String top_up_done;
  String sisa;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  DisbursmentCPlusModel({
    this.new_to_plafond,
    this.new_to_noa,
    this.new_to_rate,
    this.new_to_income,
    this.top_up_plafond,
    this.top_up_noa,
    this.top_up_rate,
    this.top_up_income,
    this.plafond,
    this.noa,
    this.new_to_transport,
    this.top_up_transport,
    this.transport,
    this.income,
    this.thp,
    this.new_to_done,
    this.top_up_done,
    this.sisa,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory DisbursmentCPlusModel.fromJson(Map<String, dynamic> json) =>
      DisbursmentCPlusModel(
        new_to_plafond: json['new_to_plafond'],
        new_to_noa: json['new_to_noa'],
        new_to_rate: json['new_to_rate'],
        new_to_income: json['new_to_income'],
        top_up_plafond: json['top_up_plafond'],
        top_up_noa: json['top_up_noa'],
        top_up_rate: json['top_up_rate'],
        top_up_income: json['top_up_income'],
        plafond: json['plafond'],
        noa: json['noa'],
        new_to_transport: json['new_to_transport'],
        top_up_transport: json['top_up_transport'],
        transport: json['transport'],
        income: json['income'],
        thp: json['thp'],
        new_to_done: json['new_to_done'],
        top_up_done: json['top_up_done'],
        sisa: json['sisa'],
      );
}
