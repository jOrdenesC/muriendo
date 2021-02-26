import 'package:movitronia/Database/Models/TipsData.dart';

abstract class TipsDataRepository {
  Future<int> insertTips(TipsData gifdata);

  Future updateTips(TipsData gifdata);

  Future deleteTips(int gifDataId);

  Future<List<TipsData>> getAllTips();

  Future<List<TipsData>> getTips(String id);

  //Future<List<ExcerciseData>> loopSearch(List<int> listId);
}
