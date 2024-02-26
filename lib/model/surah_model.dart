import 'dart:convert';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

class Surah {
  int nomor;
  int jumlah_ayat;
  String nama;
  String nama_latin;
  String tempat_turun;
  String arti;
  String deskripsi;
  String audio;

  Surah({
    required this.nomor,
    required this.jumlah_ayat,
    required this.nama,
    required this.nama_latin,
    required this.tempat_turun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
      nomor: json['nomor'],
      jumlah_ayat: json['jumlah_ayat'],
      nama: json['nama'],
      nama_latin: json['nama_latin'],
      tempat_turun: json['tempat_turun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audio: json['audio']);
}