import 'dart:convert';

List<Dzikir> dzikirFromJson(String str) =>
List<Dzikir>.from(json.decode(str).map((x) => Dzikir.fromJson(x)));

class Dzikir {
  int? nomor;
  String? nama;

  Dzikir({this.nomor, this.nama});

  Dzikir.fromJson(Map<String, dynamic> json) {
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
