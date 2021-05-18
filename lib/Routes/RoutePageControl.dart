import 'package:get/get.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/TipsDataRepository/TipsDataRepository.dart';
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
import '../Design/All/Support/Support.dart';
import '../Design/All/EvidencesTeacher/MenuEvidences.dart';
import '../Design/All/Reports/CaloricExpenditure.dart';
import '../Design/All/Reports/reports.dart';
import 'dart:developer';
import '../Design/All/Reports/ApplicationUse.dart';
import '../Database/Repository/QuestionDataRepository/QuestionDataRepository.dart';

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

goToPlanification(ClassLevel data, int number, bool isTeacher, Map dataClass,
    String phase, bool isCustom) {
  log("IS CUSTOOOM : $isCustom");
  Get.toNamed(AppRoutes.planification.name, arguments: {
    "data": data,
    "number": number,
    "isTeacher": isTeacher,
    "dataClass": dataClass,
    "phase": phase,
    "isCustom": isCustom
  });
}

goToExcercisesPage(String name, List data, bool isTeacher) {
  Get.toNamed(AppRoutes.excercisesPage.name,
      arguments: {"data": data, "name": name, "isTeacher": isTeacher});
}

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
    String phase,
    bool isCustom}) {
  log("IS CUSTOOOM go to evidences : $isCustom");
  Get.toNamed(AppRoutes.evidencesSession.name, arguments: {
    "questionnaire": questionnaire,
    "idClass": idClass,
    "kCal": kCal,
    "number": number,
    "exercises": exercises,
    "phase": phase,
    "isCustom": isCustom
  });
}

goToUploadData(
    {String uuidQuestionary,
    String idClass,
    double mets,
    int number,
    List exercises,
    String phase,
    bool isCustom}) {
  log("IS CUSTOOOM go to uploaddata : $isCustom");
  Get.toNamed(AppRoutes.uploadData.name, arguments: {
    "uuid": uuidQuestionary,
    "idClass": idClass,
    "mets": mets,
    "number": number,
    "exercises": exercises,
    "phase": phase,
    "isCustom": isCustom
  });
}

goToVideosToRecord(
    {String uuidQuestionary,
    String idClass,
    double kCal,
    int number,
    List exercises,
    bool isCustom}) {
  Get.toNamed(AppRoutes.videosToRecord.name, arguments: {
    "uuid": uuidQuestionary,
    "idClass": idClass,
    "kCal": kCal,
    "number": number,
    "exercises": exercises,
    "isCustom": isCustom
  });
}

goToQuestionary(
    {List questionnaire,
    String idClass,
    List mets,
    int number,
    bool isCustom}) {
  Get.toNamed(AppRoutes.questionary.name, arguments: {
    "questionnaire": questionnaire,
    "idClass": idClass,
    "mets": mets,
    "number": number,
    "isCustom": isCustom
  });
}

goToFinalPage() {
  Get.toNamed(AppRoutes.finalPage.name);
}

goToCaloricExpenditure(bool isTeacher, List data) {
  // Get.toNamed(AppRoutes.caloricExpenditure.name);
  Get.to(CaloricExpenditure(
    isTeacher: isTeacher,
    data: data,
  ));
}

goToApplicationUse(bool isTeacher, List data) {
  // Get.toNamed(AppRoutes.applicationUse.name);
  Get.to(ApplicationUse(
    isTeacher: isTeacher,
    data: data,
  ));
}

goToAllEvidences() {
  Get.toNamed(AppRoutes.allEvidences.name);
}

goToReports(bool drawer, bool isTeacher, List data) {
  // Get.toNamed(AppRoutes.reports.name,
  //     arguments: {"drawer": drawer, "isTeacher": isTeacher, "data": data});
  log(data.toString());
  Get.to(Reports(
    isTeacher: isTeacher,
    drawerMenu: drawer,
    data: data,
  ));
}

goToEvidencesVideos() {
  Get.toNamed(AppRoutes.evidencesVideos.name);
}

goToEvidencesQuestionary() {
  Get.toNamed(AppRoutes.evidencesQuestionary.name);
}

goToHomeReplacement() {
  // Get.offAndToNamed(AppRoutes.homeUser.name, arguments: "user");
  Get.back();
  Get.back();
  Get.back();
  Get.back();
  Get.back();
  Get.back();
}

goToshowCycle(String nameCourse, int cycle, List courses) {
  Get.toNamed(AppRoutes.showCycle.name, arguments: {
    "nameCourse": nameCourse,
    "cycle": cycle,
    "courses": courses
  });
}

goToShowPhases(int cycle, String title, bool isEvidence, bool isDefault,
    String level, List courses) {
  Get.toNamed(AppRoutes.showPhases.name, arguments: {
    "cycle": cycle,
    "title": title,
    "isEvidence": isEvidence,
    "isDefault": isDefault,
    "level": level,
    "courses": courses
  });
}

goToCreateClass(String level, String number, bool isNew, bool fromCourses,
    String idCourse) {
  ListController().finishCreateClass();
  Get.toNamed(AppRoutes.createClass.name, arguments: {
    "level": level,
    "number": number,
    "isNew": isNew,
    "fromCourses": fromCourses,
    "idCourse": idCourse
  });
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

goToFinishCreateClass(
    String level, String number, var response, bool isNew, String courseId) {
  Get.toNamed(AppRoutes.finishCreateClass.name, arguments: {
    "level": level,
    "number": number,
    "response": response,
    "isNew": isNew,
    "courseId": courseId
  });
}

goToAssignCreatedClass(
    String level, String number, var response, String courseId, bool isNew) {
  Get.toNamed(AppRoutes.assignCreatedClass.name, arguments: {
    "level": level,
    "number": number,
    "response": response,
    "isNew": isNew,
    "courseId": courseId
  });
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

goToMenuEvidences(List data) {
  // Get.toNamed(AppRoutes.menuEvidences.name);
  Get.to(MenuEvidences(data: data));
}

goToSupport(bool isFull) {
  Get.to(Support(
    isFull: isFull,
  ));
}

goToManuals(bool isFull) {
  Get.toNamed(AppRoutes.manuals.name, arguments: isFull);
}

closeSession() async {
  var prefs = await SharedPreferences.getInstance();

  QuestionDataRepository questionDataRepository = GetIt.I.get();
  CourseDataRepository courseDataRepository = GetIt.I.get();
  TipsDataRepository tipsDataRepository = GetIt.I.get();
  ClassDataRepository classDataRepository = GetIt.I.get();
  EvidencesRepository evidencesRepository = GetIt.I.get();
  ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();

  await courseDataRepository.deleteAll();
  await evidencesRepository.deleteAll();
  await excerciseDataRepository.deleteAll();
  await classDataRepository.deleteAll();
  await tipsDataRepository.deleteAll();
  await questionDataRepository.deleteAll();

  var resCourse = await courseDataRepository.getAllCourse();
  var resTips = await tipsDataRepository.getAllTips();
  var resEvidence = await evidencesRepository.getAllEvidences();
  var resExercises = await excerciseDataRepository.getAllExcercise();
  var resClass = await classDataRepository.getAllClassLevel();
  var resQuestions = await questionDataRepository.getAllQuestions();
  print(resClass.length);
  print(resEvidence.length);
  print(resExercises.length);
  print(resTips.length);
  print("""
    course ${resCourse.length}
    evidence ${resEvidence.length}
    exercises ${resExercises.length}
    classes ${resClass.length}
    tips ${resTips.length}
    questions ${resQuestions.length}
    """);

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
  // Get.offAllNamed(AppRoutes.homeTeacher.name);
  Get.back();
  Get.back();
  Get.back();
  Get.back();
  Get.back();
  Get.back();
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

goToChangePass() {
  Get.toNamed(AppRoutes.changePass.name);
}
