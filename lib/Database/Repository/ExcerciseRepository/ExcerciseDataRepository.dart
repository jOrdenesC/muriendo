import 'package:movitronia/Database/Models/ExcerciseData.dart';

abstract class ExcerciseDataRepository {
  Future<int> insertExcercise(ExcerciseData gifdata);

  Future updateExcercise(ExcerciseData gifdata);

  Future deleteExcercise(int gifDataId);

  Future<List<ExcerciseData>> getAllExcercise();

  Future<List<ExcerciseData>> getExcerciseID(int id);

  Future<List<ExcerciseData>> getExerciseById(String id);

  Future<List<ExcerciseData>> getExcerciseName(String name);

  Future<List<ExcerciseData>> loopSearch(List<int> listId);
}
