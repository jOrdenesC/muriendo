import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Database/Models/ResponseModels/ResultClassModel.dart';

abstract class ClassDataRepository {
  Future<int> insertClass(ClassLevel classLevel);

  Future<int> insertClassJSON(ResultModel resultModel);

  Future updateClass(ClassLevel classLevel);

  Future deleteClass(int classlevelid);

  Future deleteAll();

  Future<List<ClassLevel>> getAllClassLevel();

  Future<List<ClassLevel>> getClassID(String id);

  Future<List<ClassLevel>> getClassByNumber(String number);
}
