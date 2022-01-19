class ReportPipelineModel {
  String id;
  String tglPipeline;
  String nikSales;
  String namaSales;
  String tampatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String noKtp;
  String npwp;
  String cadeb;
  String alamat;
  String telepon;
  String jenisProduk;
  String nominal;
  String cabang;
  String keterangan;
  String status;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeOver;
  String foto1;
  String foto2;
  String tglPenyerahan;
  String tanggalAkad;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ReportPipelineModel({
    this.id,
    this.tglPipeline,
    this.nikSales,
    this.namaSales,
    this.tampatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.noKtp,
    this.npwp,
    this.cadeb,
    this.alamat,
    this.telepon,
    this.jenisProduk,
    this.nominal,
    this.cabang,
    this.keterangan,
    this.status,
    this.statusKredit,
    this.pengelolaPensiun,
    this.bankTakeOver,
    this.foto1,
    this.foto2,
    this.tglPenyerahan,
    this.tanggalAkad,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory ReportPipelineModel.fromJson(Map<String, dynamic> json) =>
      ReportPipelineModel(
        id: json['id'],
        tglPipeline: json['tgl_pipeline'],
        nikSales: json['niksales'],
        namaSales: json['namasales'],
        tampatLahir: json['tempat_lahir'],
        tanggalLahir: json['tgl_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        noKtp: json['no_ktp'],
        npwp: json['npwp'],
        cadeb: json['cadeb'],
        alamat: json['alamat'],
        telepon: json['telepon'],
        jenisProduk: json['jenis_produk'],
        nominal: json['nominal'],
        cabang: json['cabang'],
        keterangan: json['keterangan'],
        status: json['status'],
        statusKredit: json['status_kredit'],
        pengelolaPensiun: json['pengelola_pensiun'],
        bankTakeOver: json['bank_takeover'],
        foto1: json['foto1'],
        foto2: json['foto2'],
      );
}
