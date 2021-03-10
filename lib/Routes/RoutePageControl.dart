import 'package:get/get.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Design/All/DetailsExercise/DetailsExcercise.dart';
import 'package:movitronia/Functions/Controllers/ListsController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppRoutes.dart';
import 'package:get_it/get_it.dart';
import '../Database/Repository/EvidencesSentRepository.dart';
import '../Database/Repository/CourseRepository.dart';
import '../Design/All/EvidencesTeacher/SearchEvidences.dart';
import '../Design/All/HomePage/HomePageTeacher.dart';
import '../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';

goToLogin() {
  Get.toNamed(AppRoutes.login.name);
}

goToHome(String role, Map college) {
  if (role == "user") {
    Get.toNamed(AppRoutes.homeUser.name, arguments: role);
  } else {
    Get.to(HomePageTeacher(
      classId: college["_id"],
      nameCollege: college["name"],
    ));
  }
}

goToBasal(String role) {
  if (role == "user") {
    Get.toNamed(AppRoutes.basalUser.name, arguments: role);
  } else {
    Get.toNamed(AppRoutes.basalTeacher.name, arguments: role);
  }
}

goToTerms(String role) {
  Get.toNamed(AppRoutes.terms.name, arguments: role);
}

goToWelcome(String role) {
  Get.toNamed(AppRoutes.welcome.name, arguments: role);
}

goToPlanification(
    ClassLevel data, int number, bool isTeacher, Map dataClass, String phase) {
  Get.toNamed(AppRoutes.planification.name, arguments: {
    "data": data,
    "number": number,
    "isTeacher": isTeacher,
    "dataClass": dataClass,
    "phase": phase
  });
}

goToExcercisesPage(String name, List data, bool isTeacher) {
  Get.toNamed(AppRoutes.excercisesPage.name,
      arguments: {"data": data, "name": name, "isTeacher": isTeacher});
}

// goToSessionPage(String id) {
//   Get.toNamed(AppRoutes.sessionPage.name, arguments: id);
// }

goToShowCalories(
    {String idClass,
    List mets,
    List exercises,
    List questionnaire,
    int number}) {
  Get.offAllNamed(AppRoutes.showCalories.name, arguments: {
    "idClass": idClass,
    "mets": mets,
    'exercises': exercises,
    'questionnaire': questionnaire,
    'number': number
  });
}

goToEvidencesSession(
    {List questionnaire,
    String idClass,
    double kCal,
    int number,
    List exercises,
    String phase}) {
  Get.toNamed(AppRoutes.evidencesSession.name, arguments: {
    "questionnaire": questionnaire,
    "idClass": idClass,
    "kCal": kCal,
    "number": number,
    "exercises": exercises,
    "phase": phase
  });
}

goToUploadData(
    {String uuidQuestionary,
    String idClass,
    double mets,
    int number,
    List exercises,
    String phase}) {
  Get.toNamed(AppRoutes.uploadData.name, arguments: {
    "uuid": uuidQuestionary,
    "idClass": idClass,
    "mets": mets,
    "number": number,
    "exercises": exercises,
    "phase": phase
  });
}

goToVideosToRecord(
    {String uuidQuestionary,
    String idClass,
    double kCal,
    int number,
    List exercises}) {
  Get.toNamed(AppRoutes.videosToRecord.name, arguments: {
    "uuid": uuidQuestionary,
    "idClass": idClass,
    "kCal": kCal,
    "number": number,
    "exercises": exercises
  });
}

goToQuestionary({List questionnaire, String idClass, List mets, int number}) {
  Get.toNamed(AppRoutes.questionary.name, arguments: {
    "questionnaire": questionnaire,
    "idClass": idClass,
    "mets": mets,
    "number": number
  });
}

goToFinalPage() {
  Get.toNamed(AppRoutes.finalPage.name);
}

goToCaloricExpenditure() {
  Get.toNamed(AppRoutes.caloricExpenditure.name);
}

goToApplicationUse() {
  Get.toNamed(AppRoutes.applicationUse.name);
}

goToAllEvidences() {
  Get.toNamed(AppRoutes.allEvidences.name);
}

goToReports(bool drawer) {
  Get.toNamed(AppRoutes.reports.name, arguments: drawer);
}

goToEvidencesVideos() {
  Get.toNamed(AppRoutes.evidencesVideos.name);
}

goToEvidencesQuestionary() {
  Get.toNamed(AppRoutes.evidencesQuestionary.name);
}

goToHomeReplacement() {
  Get.offAndToNamed(AppRoutes.homeUser.name, arguments: "user");
}

goToshowCycle(String nameCourse, int cycle) {
  Get.toNamed(AppRoutes.showCycle.name,
      arguments: {"nameCourse": nameCourse, "cycle": cycle});
}

goToShowPhases(
    int cycle, String title, bool isEvidence, bool isDefault, String level) {
  Get.toNamed(AppRoutes.showPhases.name, arguments: {
    "cycle": cycle,
    "title": title,
    "isEvidence": isEvidence,
    "isDefault": isDefault,
    "level": level
  });
}

goToCreateClass(String level, String number) {
  ListController().finishCreateClass();
  Get.toNamed(AppRoutes.createClass.name,
      arguments: {"level": level, "number": number});
}

goToExcercisesClass(String title, String level, String number) {
  Get.toNamed(AppRoutes.excercisesClass.name,
      arguments: {"title": title, "level": level, "number": number});
}

goToFilterExcercises(
    String category, String stage, String level, String number, bool isPie) {
  Get.toNamed(AppRoutes.filterExcercises.name, arguments: {
    "category": category,
    "stage": stage,
    "level": level,
    "number": number,
    "isPie": isPie
  });
}

goToAddExcercises(String subCategory, String stage, String category,
    String level, String number) {
  Get.toNamed(AppRoutes.addExcercises.name, arguments: {
    "subCategory": subCategory,
    "stage": stage,
    "category": category,
    "level": level,
    "number": number
  });
}

goToFinishCreateClass(String level, String number, var response) {
  Get.toNamed(AppRoutes.finishCreateClass.name,
      arguments: {"level": level, "number": number, "response": response});
}

goToAssignCreatedClass(String level, String number, var response) {
  Get.toNamed(AppRoutes.assignCreatedClass.name,
      arguments: {"level": level, "number": number, "response": response});
}

goToMessageUploadData() {
  Get.toNamed(AppRoutes.messageUploadData.name);
}

goToSearchEvidences(bool isFull, String idCollege) {
  Get.to(SearchEvidences(
    isFull: isFull,
    idCollege: idCollege,
  ));
}

goToMenuEvidences() {
  Get.toNamed(AppRoutes.menuEvidences.name);
}

goToSupport(bool isFull) {
  Get.toNamed(AppRoutes.support.name, arguments: isFull);
}

goToManuals(bool isFull) {
  Get.toNamed(AppRoutes.manuals.name, arguments: isFull);
}

closeSession() async {
  CourseDataRepository courseDataRepository = GetIt.I.get();
  await courseDataRepository.deleteAll();
  EvidencesRepository evidencesRepository = GetIt.I.get();
  ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
  await evidencesRepository.deleteAll();
  await excerciseDataRepository.deleteAll();
  var prefs = await SharedPreferences.getInstance();
  prefs.setInt("phase", null);
  prefs.setString("rut", null);
  prefs.setString("name", null);
  prefs.setString("email", null);
  prefs.setString("token", null);
  prefs.setString("scope", null);
  prefs.setString("charge", null);
  prefs.setBool("termsAccepted", null);
  prefs.setString("gender", null);
  prefs.setString("phone", null);
  prefs.setString("uuid", null);
  prefs.setString("birthday", null);
  prefs.setString("weight", null);
  prefs.setString("height", null);
  prefs.setString("frequencyOfPhysicalActivity", null);
  prefs.setString("actualVideo", null);
  prefs.setBool("downloaded", null);
  Get.offAllNamed(AppRoutes.login.name);
}

goToDetailsExcercises(
    String nameVideo, String name, String kcal, String desc, bool isTeacher) {
  Get.to(DetailsExcercise(nameVideo, name, kcal, desc, isTeacher));
}

goToHomeTeacher() {
  Get.offAllNamed(AppRoutes.homeTeacher.name);
}

goToRecoverPass() {
  Get.toNamed(AppRoutes.recoverPass.name);
}

goToSettingsPage(String role) {
  Get.toNamed(AppRoutes.settingsPage.name, arguments: role);
}

goToTeacherSelectCollege() {
  Get.toNamed(AppRoutes.teacherSelectCollege.name);
}

goToProfilePage(bool isHome) {
  Get.toNamed(AppRoutes.profilePage.name, arguments: isHome);
}
