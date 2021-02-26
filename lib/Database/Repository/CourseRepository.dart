import 'package:movitronia/Database/Models/courseModel.dart';

abstract class CourseDataRepository {
  Future<int> insertCourse(CourseData courseData);

  Future updateCourse(CourseData courseData);

  Future deleteCourse(String gifDataId);

  Future<List<CourseData>> getAllCourse();

  Future<List<CourseData>> getCourseID(String id);
}
