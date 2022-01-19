class InteractionModel {
  String id;
  String notas;
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
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String propinsi;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  InteractionModel(
      {this.id,
      this.notas,
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
      this.kelurahan,
      this.kecamatan,
      this.kabupaten,
      this.propinsi});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory InteractionModel.fromJson(Map<String, dynamic> json) =>
      InteractionModel(
          id: json['id'],
          notas: json['notas'],
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
          kelurahan: json['kelurahan'],
          kecamatan: json['kecamatan'],
          kabupaten: json['kota_kab'],
          propinsi: json['provinsi']);
}
