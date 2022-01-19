class ApprovalInteractionModel {
  String id;
  String telepon;
  String calonDebitur;
  String plafond;
  String tanggalInteraksi;
  String alamat;
  String email;
  String salesFeedback;
  String foto;
  String statusInteraksi;
  String jamInteraksi;
  String namaSales;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String propinsi;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ApprovalInteractionModel({
    this.id,
    this.telepon,
    this.calonDebitur,
    this.plafond,
    this.tanggalInteraksi,
    this.alamat,
    this.email,
    this.salesFeedback,
    this.foto,
    this.statusInteraksi,
    this.jamInteraksi,
    this.namaSales,
    this.kelurahan,
    this.kecamatan,
    this.kabupaten,
    this.propinsi,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory ApprovalInteractionModel.fromJson(Map<String, dynamic> json) =>
      ApprovalInteractionModel(
          id: json['id'],
          telepon: json['telepon'],
          calonDebitur: json['calon_debitur'],
          plafond: json['plafond'],
          tanggalInteraksi: json['tanggal_interaksi'],
          alamat: json['alamat'],
          email: json['email'],
          salesFeedback: json['sales_feedback'],
          foto: json['foto'],
          statusInteraksi: json['approval_sl'],
          jamInteraksi: json['jam_kunj'],
          namaSales: json['nama_sales'],
          kelurahan: json['kelurahan'],
          kecamatan: json['kecamatan'],
          kabupaten: json['kota_kab'],
          propinsi: json['provinsi']);
}
