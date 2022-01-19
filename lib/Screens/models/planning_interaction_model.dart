class PlanningInteractionModel {
  String id;
  String nopen;
  String nama;
  String tglLahir;
  String gajiPokok;
  String alamat;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String provinsi;
  String kodepos;
  String namaKantor;
  String tmtPensiun;
  String penerbitSkep;
  String telepon;
  String visitStatus;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  PlanningInteractionModel(
      {this.id,
      this.nopen,
      this.nama,
      this.tglLahir,
      this.gajiPokok,
      this.alamat,
      this.kelurahan,
      this.kecamatan,
      this.kabupaten,
      this.provinsi,
      this.kodepos,
      this.namaKantor,
      this.tmtPensiun,
      this.penerbitSkep,
      this.telepon,
      this.visitStatus});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory PlanningInteractionModel.fromJson(Map<String, dynamic> json) =>
      PlanningInteractionModel(
          id: json['id'],
          nopen: json['nopen'],
          nama: json['namapensiunan'],
          tglLahir: json['tgl_lahir_pensiunan'],
          gajiPokok: json['penpok'],
          alamat: json['alm_peserta'],
          kelurahan: json['kelurahan'],
          kecamatan: json['kecamatan'],
          kabupaten: json['kota_kab'],
          provinsi: json['provinsi'],
          kodepos: json['kodepos'],
          namaKantor: json['nmkanbyr'],
          tmtPensiun: json['tmtpensiun'],
          penerbitSkep: json['penerbit_skep'],
          telepon: json['telepon'],
          visitStatus: json['visit_status']);
}
