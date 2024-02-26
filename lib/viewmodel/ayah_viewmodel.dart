import 'package:quran_app/model/ayah_model.dart';
import 'package:quran_app/repository/quran_repo.dart';

class AyahViewModel {
  final _repository = QuranRepository();
  Future<AyahModel> getListAyah(String id_surah) async {
    try {
      final response = await _repository.getListAyah(id_surah);
      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
