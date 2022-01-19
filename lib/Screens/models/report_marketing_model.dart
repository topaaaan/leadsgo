class ReportMarketingModel {
  String nik;
  String nama;
  String jabatan;
  String jenisKelamin;
  String joinDate;
  String alamatEmail;
  String noTelepon;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ReportMarketingModel({
    this.nik,
    this.nama,
    this.jabatan,
    this.jenisKelamin,
    this.joinDate,
    this.alamatEmail,
    this.noTelepon,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory ReportMarketingModel.fromJson(Map<String, dynamic> json) =>
      ReportMarketingModel(
          nik: json['nik'],
          nama: json['nama'],
          jabatan: json['jabatan'],
          jenisKelamin: json['jenis_kelamin'],
          joinDate: json['join_date'],
          alamatEmail: json['alamat_email'],
          noTelepon: json['no_telepon_2']);
}
