class LeaderboardModel {
  String nama;
  String cabang;
  String rekening;
  String nominal;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  LeaderboardModel({
    this.nama,
    this.cabang,
    this.rekening,
    this.nominal,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardModel(
        nama: json['NAMA_KARYAWAN'],
        cabang: json['cabang'],
        rekening: json['rekening'],
        nominal: json['nominal'],
      );
}
