class DoaDetailModel {
  int? nomor;
  String? nama;
  List<Doa>? doa;

  DoaDetailModel({this.nomor, this.nama, this.doa});

  DoaDetailModel.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    nama = json['nama'];
    if (json['doa'] != null) {
      doa = <Doa>[];
      json['doa'].forEach((v) {
        doa!.add(new Doa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor'] = this.nomor;
    data['nama'] = this.nama;
    if (this.doa != null) {
      data['doa'] = this.doa!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doa {
  String? title;
  String? arabic;
  String? latin;
  String? translation;
  Null notes;
  String? fawaid;
  String? source;

  Doa(
      {this.title,
      this.arabic,
      this.latin,
      this.translation,
      this.notes,
      this.fawaid,
      this.source});

  Doa.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    arabic = json['arabic'];
    latin = json['latin'];
    translation = json['translation'];
    notes = json['notes'];
    fawaid = json['fawaid'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['arabic'] = this.arabic;
    data['latin'] = this.latin;
    data['translation'] = this.translation;
    data['notes'] = this.notes;
    data['fawaid'] = this.fawaid;
    data['source'] = this.source;
    return data;
  }
}
