import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_app/model/dzikir_detail_model.dart';
import 'package:quran_app/model/dzikir_model.dart';

class DzikirRepository {
  Future<List<Dzikir>> getListDzikir() async {
    String data = await rootBundle.loadString('assets/data/list-dzikir.json');
    return dzikirFromJson(data);
  }

  Future<DzikirDetailModel> getListDzikirDetail(String id_dzikir) async {
    String data = await rootBundle.loadString('assets/data/list-dzikir-detail.json');

    List<dynamic> jsonData = jsonDecode(data);

    // Convert id_dzikir to int
    int? idDzikirInt = int.tryParse(id_dzikir);

    if (idDzikirInt != null) {
      // Find the entry with the matching 'nomor'
      var entry = jsonData.firstWhere(
        (element) => element['nomor'] == idDzikirInt,
        orElse: () => null,
      );

      if (entry != null) {
        return DzikirDetailModel.fromJson(entry);
      } else {
        throw Exception("Entry not found for id_dzikir: $id_dzikir");
      }
    } else {
      throw Exception("Invalid id_dzikir: $id_dzikir");
    }
  }
}
