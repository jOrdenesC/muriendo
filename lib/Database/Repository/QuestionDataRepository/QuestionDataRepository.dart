import 'package:movitronia/Database/Models/QuestionData.dart';

abstract class QuestionDataRepository {
  Future<int> insertQuestion(QuestionData gifdata);

  Future updateQuestion(QuestionData gifdata);

  Future deleteQuestion(int gifDataId);

  Future deleteAll();

  Future<List<QuestionData>> getAllQuestions();

  Future<List<QuestionData>> getQuestion(String id);

  //Future<List<ExcerciseData>> loopSearch(List<int> listId);
}
