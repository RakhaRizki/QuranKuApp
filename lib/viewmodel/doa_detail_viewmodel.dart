
import 'package:quran_app/model/doa_detail_model.dart';
import 'package:quran_app/repository/doa_repo.dart';

class DoaDetailViewmodel {
  final _repository = DoaRepository();
  Future<DoaDetailModel> getListDoaDetail(String id_doa) async {
    try {
      final response = await _repository.getListDoaDetail(id_doa);
      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
