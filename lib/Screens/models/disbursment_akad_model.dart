class DisbursmentAkadModel {
  String id;
  String idPipeline;
  String debitur;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String nominalPinjaman;
  String jenisProduk;
  String salesInfo;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String alamat;
  String telepon;
  String selectedJenisDebitur;
  String selectedJenisProduk;
  String selectedJenisCabang;
  String selectedJenisInfo;
  String selectedStatusKredit;
  String selectedPengelolaPensiun;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  DisbursmentAkadModel(
      {this.id,
      this.idPipeline,
      this.debitur,
      this.tanggalAkad,
      this.nomorAplikasi,
      this.nomorPerjanjian,
      this.nominalPinjaman,
      this.jenisProduk,
      this.salesInfo,
      this.namaPetugasBank,
      this.jabatanPetugasBank,
      this.teleponPetugasBank,
      this.alamat,
      this.telepon,
      this.selectedJenisDebitur,
      this.selectedJenisProduk,
      this.selectedJenisCabang,
      this.selectedJenisInfo,
      this.selectedStatusKredit,
      this.selectedPengelolaPensiun});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory DisbursmentAkadModel.fromJson(Map<String, dynamic> json) =>
      DisbursmentAkadModel(
          id: json['id'],
          idPipeline: json['id_pipeline'],
          debitur: json['debitur'],
          tanggalAkad: json['tanggal_akad'],
          nomorAplikasi: json['nomor_aplikasi'],
          nomorPerjanjian: json['nomor_perjanjian'],
          nominalPinjaman: json['nominal_pinjaman'],
          jenisProduk: json['jenis_produk'],
          salesInfo: json['sales_info'],
          namaPetugasBank: json['nama_petugas_bank'],
          jabatanPetugasBank: json['jabatan_petugas_bank'],
          teleponPetugasBank: json['telepon_petugas_bank'],
          alamat: json['alamat'],
          telepon: json['telepon'],
          selectedJenisDebitur: json['selected_jenis_debitur'],
          selectedJenisProduk: json['selected_jenis_produk'],
          selectedJenisCabang: json['selected_jenis_cabang'],
          selectedJenisInfo: json['selected_jenis_info'],
          selectedStatusKredit: json['selected_status_kredit'],
          selectedPengelolaPensiun: json['selected_pengelola_pensiun']);
}
