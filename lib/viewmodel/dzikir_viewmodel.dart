import 'package:quran_app/model/dzikir_model.dart';
import 'package:quran_app/repository/dzikir_repo.dart';

class DzikirViewmodel {
  final DzikirRepository _repository = DzikirRepository();

  Future<List<Dzikir>> getListDzikir() async {
    return await _repository.getListDzikir();
  }
}
