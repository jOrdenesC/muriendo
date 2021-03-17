import 'package:movitronia/Database/Models/ExcerciseData.dart';

abstract class ExcerciseDataRepository {
  Future<int> insertExcercise(ExcerciseData gifdata);

  Future updateExcercise(ExcerciseData gifdata);

  Future deleteExcercise(int gifDataId);

  Future deleteAll();

  Future<List<ExcerciseData>> getAllExcercise();

   Future<List<ExcerciseData>> getExercisesPie(String category);

  Future<List<ExcerciseData>> getExcerciseID(int id);

  Future<List<ExcerciseData>> getExerciseById(String id);

  Future<List<ExcerciseData>> getExcerciseName(String name);

  Future<List<ExcerciseData>> getExcerciseVideoName(String name);

  Future<List<ExcerciseData>> getExercisesByCategories(String stage, String category, String subCategory, String level);

  Future<List<ExcerciseData>> loopSearch(List<int> listId);
}
