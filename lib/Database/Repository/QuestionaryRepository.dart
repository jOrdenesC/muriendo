import 'package:movitronia/Database/Models/QuestionaryData.dart';

abstract class QuestionaryRepository{
  Future<int> insert(QuestionaryData offlineData);

  Future update(QuestionaryData offlineData);

  Future delete(int uuid);

  Future<List<QuestionaryData>> getAll();

  Future<List<QuestionaryData>> getForId(String uuid);
}
