import 'package:get/get.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Design/All/DetailsExercise/DetailsExcercise.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppRoutes.dart';

goToLogin() {
  Get.toNamed(AppRoutes.login.name);
}

goToHome(
  String role,
) {
  if (role == "user") {
    Get.toNamed(AppRoutes.homeUser.name, arguments: role);
  } else {
    Get.toNamed(AppRoutes.homeTeacher.name, arguments: role);
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

goToPlanification(ClassLevel data, int number) {
  Get.toNamed(AppRoutes.planification.name,
      arguments: {"data": data, "number": number});
}

goToExcercisesPage(String name, List data) {
  Get.toNamed(AppRoutes.excercisesPage.name,
      arguments: {"data": data, "name": name});
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
    List exercises}) {
  Get.toNamed(AppRoutes.evidencesSession.name, arguments: {
    "questionnaire": questionnaire,
    "idClass": idClass,
    "kCal": kCal,
    "number": number,
    "exercises": exercises
  });
}

goToUploadData(
    {String uuidQuestionary, String idClass, double mets, int number}) {
  Get.toNamed(AppRoutes.uploadData.name, arguments: {
    "uuid": uuidQuestionary,
    "idClass": idClass,
    "mets": mets,
    "number": number
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

goToShowPhases(int cycle, String title, bool isEvidence) {
  Get.toNamed(AppRoutes.showPhases.name,
      arguments: {"cycle": cycle, "title": title, "isEvidence": isEvidence});
}

goToCreateClass() {
  Get.toNamed(AppRoutes.createClass.name);
}

goToExcercisesClass(String title) {
  Get.toNamed(AppRoutes.excercisesClass.name, arguments: title);
}

goToFilterExcercises(String title) {
  Get.toNamed(AppRoutes.filterExcercises.name, arguments: title);
}

goToAddExcercises(String title) {
  Get.toNamed(AppRoutes.addExcercises.name, arguments: title);
}

goToFinishCreateClass() {
  Get.toNamed(AppRoutes.finishCreateClass.name);
}

goToAssignCreatedClass() {
  Get.toNamed(AppRoutes.assignCreatedClass.name);
}

goToMessageUploadData() {
  Get.toNamed(AppRoutes.messageUploadData.name);
}

goToSearchEvidences(bool isFull) {
  Get.toNamed(AppRoutes.searchEvidences.name, arguments: isFull);
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
  var prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Get.offAllNamed(AppRoutes.login.name);
}

goToDetailsExcercises(String name, String asset, String kcal, String desc) {
  Get.to(DetailsExcercise(name, kcal, desc));
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
