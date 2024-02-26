import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_app/model/doa_detail_model.dart';
import 'package:quran_app/model/doa_model.dart';

class DoaRepository {
  Future<List<ListDoa>> getListDoa() async {
    String data = await rootBundle.loadString('assets/data/list-doa.json');
    return doaFromJson(data);
  }

  Future<DoaDetailModel> getListDoaDetail(String id_doa) async {
    String data = await rootBundle.loadString('assets/data/list-doa-detail.json');

    List<dynamic> jsonData = jsonDecode(data);

    // Convert id_dzikir to int
    int? idDoaInt = int.tryParse(id_doa);

    if (idDoaInt != null) {
      // Find the entry with the matching 'nomor'
      var entry = jsonData.firstWhere(
        (element) => element['nomor'] == idDoaInt,
        orElse: () => null,
      );

      if (entry != null) {
        return DoaDetailModel.fromJson(entry);
      } else {
        throw Exception("Entry not found for id_doa: $id_doa");
      }
    } else {
      throw Exception("Invalid id_doa: $id_doa");
    }
  }
}
