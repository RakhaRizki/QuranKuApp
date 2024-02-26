import 'dart:convert';

List<ListDoa> doaFromJson(String str) =>
List<ListDoa>.from(json.decode(str).map((x) => ListDoa.fromJson(x)));

class ListDoa {
  int? nomor;
  String? nama;

  ListDoa({this.nomor, this.nama});

  ListDoa.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor'] = this.nomor;
    data['nama'] = this.nama;
    return data;
  }
}
