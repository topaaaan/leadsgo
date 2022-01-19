class PipelineModel {
  String id;
  String tglPipeline;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String noKtp;
  String noNip;
  String npwp;
  String namaNasabah;
  String alamat;
  String telepon;
  String jenisProduk;
  String plafond;
  String cabang;
  String keterangan;
  String status;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String tglPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String foto1;
  // String foto2;
  String fotoTandaTerima;
  String tanggalAkad;
  // String nomorAplikasi;
  String nomorRekening;
  String nomorPerjanjian;
  String nominalPinjaman;
  String finalOS;
  String nominalTopUp;
  String akadProduk;
  String salesInfo;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String kodeAO;
  String teleponPetugasBank;
  String fotoAkad1;
  String fotoAkad2;
  String idKeterangan;
  String keluhan;
  String idFoto;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  PipelineModel({
    this.id,
    this.tglPipeline,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.noKtp,
    this.noNip,
    this.npwp,
    this.namaNasabah,
    this.alamat,
    this.telepon,
    this.jenisProduk,
    this.plafond,
    this.cabang,
    this.keterangan,
    this.status,
    this.statusKredit,
    this.pengelolaPensiun,
    this.bankTakeover,
    this.tglPenyerahan,
    this.namaPenerima,
    this.teleponPenerima,
    this.foto1,
    // this.foto2,
    this.fotoTandaTerima,
    this.tanggalAkad,
    // this.nomorAplikasi,
    this.nomorRekening,
    this.nomorPerjanjian,
    this.nominalPinjaman,
    this.finalOS,
    this.nominalTopUp,
    this.akadProduk,
    this.salesInfo,
    this.namaPetugasBank,
    this.jabatanPetugasBank,
    this.kodeAO,
    this.teleponPetugasBank,
    this.fotoAkad1,
    this.fotoAkad2,
    this.idKeterangan,
    this.keluhan,
    this.idFoto,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory PipelineModel.fromJson(Map<String, dynamic> json) => PipelineModel(
        id: json['id'],
        tglPipeline: json['tgl_pipeline'],
        tempatLahir: json['tempat_lahir'],
        tanggalLahir: json['tgl_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        noKtp: json['no_ktp'],
        noNip: json['no_nip'],
        npwp: json['npwp'],
        namaNasabah: json['cadeb'],
        alamat: json['alamat'],
        telepon: json['telepon'],
        jenisProduk: json['jenis_produk'],
        plafond: json['nominal'],
        cabang: json['cabang'],
        keterangan: json['keterangan'],
        status: json['status'],
        statusKredit: json['status_kredit'],
        pengelolaPensiun: json['pengelola_pensiun'],
        bankTakeover: json['bank_takeover'],
        tglPenyerahan: json['tgl_penyerahan'],
        namaPenerima: json['nama_penerima'],
        teleponPenerima: json['telepon_penerima'],
        foto1: json['foto1'],
        // foto2: json['foto2'],
        fotoTandaTerima: json['foto_tanda_submit'],
        tanggalAkad: json['tanggal_akad'],
        // nomorAplikasi: json['nomor_aplikasi'],
        nomorRekening: json['nomor_rekening'],
        nomorPerjanjian: json['nomor_perjanjian'],
        nominalPinjaman: json['nominal_pinjaman'],
        finalOS: json['nominal_os_akhir'],
        nominalTopUp: json['nominal_top_up'],
        akadProduk: json['akad_produk'],
        salesInfo: json['sales_info'],
        kodeAO: json['kode_ao'],
        namaPetugasBank: json['nama_petugas_bank'],
        jabatanPetugasBank: json['jabatan_petugas_bank'],
        teleponPetugasBank: json['telepon_petugas_bank'],
        fotoAkad1: json['foto_akad1'],
        fotoAkad2: json['foto_akad2'],
        idKeterangan: json['idKeterangan'],
        keluhan: json['keluhan'],
        idFoto: json['id_foto'],
      );
}
