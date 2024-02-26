
import 'package:quran_app/model/dzikir_detail_model.dart';
import 'package:quran_app/repository/dzikir_repo.dart';

class DzikirDetailViewModel {
  final _repository = DzikirRepository();
  Future<DzikirDetailModel> getListDzikirDetail(String id_dzikir) async {
    try {
      final response = await _repository.getListDzikirDetail(id_dzikir);
      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
