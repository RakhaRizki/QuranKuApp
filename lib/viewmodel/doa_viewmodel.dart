import 'package:quran_app/model/doa_model.dart';
import 'package:quran_app/repository/doa_repo.dart';

class DoaViewmodel {
  final DoaRepository  _repository = DoaRepository();

  Future<List<ListDoa>> getListDoa() async {
    return await _repository.getListDoa();
  }
}
