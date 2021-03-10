import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/courseModel.dart';
import 'package:sembast/sembast.dart';
import 'CourseRepository.dart';

class SembastCourseRepository extends CourseDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("course_store");

  Future<int> insertCourse(CourseData courseData) async {
    print(courseData.toMap());
    return await _store.add(_database, courseData.toMap());
  }

  Future updateCourse(CourseData courseData) async {
    await _store
        .record(courseData.courseId)
        .update(_database, courseData.toMap());
  }

  Future deleteCourse(String gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  Future<List<CourseData>> getAllCourse() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => CourseData.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<List<CourseData>> getCourseID(String courseId) async {
    final finder = Finder(filter: Filter.equals("courseId", courseId));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => CourseData.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future deleteAll() async {
    print("eliminadas todos los cursos");
    await _store.delete(_database);
    return null;
  }
}
