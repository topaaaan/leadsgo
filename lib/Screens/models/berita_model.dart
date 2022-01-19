class BeritaModel {
  String id;
  String title;
  String path;
  String content;
  String createdAt;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  BeritaModel({this.id, this.title, this.path, this.content, this.createdAt});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory BeritaModel.fromJson(Map<String, dynamic> json) => BeritaModel(
      id: json['id'],
      title: json['title'],
      path: json['path'],
      content: json['content'],
      createdAt: json['created_at']);
}
