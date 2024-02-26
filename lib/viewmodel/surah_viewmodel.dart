import 'package:quran_app/model/surah_model.dart';
import 'package:quran_app/repository/quran_repo.dart';

class SurahViewmodel {
  final QuranRepository _repository = QuranRepository();

  Future<List<Surah>> getListSurah() async {
    return await _repository.getListSurah();
  }
}
