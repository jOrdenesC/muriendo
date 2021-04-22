import 'package:movitronia/Design/All/BasalPage/BasalTeacher.dart';
import 'package:movitronia/Design/All/BasalPage/BasalUser.dart';
import 'package:movitronia/Design/All/Cycles/AddExcercises.dart';
import 'package:movitronia/Design/All/Cycles/CreateClass.dart';
import 'package:movitronia/Design/All/Cycles/AssignCreatedClass.dart';
import 'package:movitronia/Design/All/Cycles/ExcercisesClass.dart';
import 'package:movitronia/Design/All/Cycles/FilterExcercises.dart';
import 'package:movitronia/Design/All/Cycles/FinishCreateClass.dart';
import 'package:movitronia/Design/All/Cycles/MessageUploadData.dart';
import 'package:movitronia/Design/All/Cycles/ShowCycle.dart';
import 'package:movitronia/Design/All/Cycles/ShowPhases.dart';
import 'package:movitronia/Design/All/EvidencesTeacher/MenuEvidences.dart';
import 'package:movitronia/Design/All/EvidencesTeacher/SearchEvidences.dart';
import 'package:movitronia/Design/All/EvidencesUser/AllEvidences.dart';
import 'package:movitronia/Design/All/EvidencesUser/EvidencesQuestionary.dart';
import 'package:movitronia/Design/All/EvidencesUser/EvidencesVideos.dart';
import 'package:movitronia/Design/All/HomePage/HomePageTeacher.dart';
import 'package:movitronia/Design/All/HomePage/HomepageUser.dart';
import 'package:movitronia/Design/All/Login/Login.dart';
import 'package:movitronia/Design/All/Login/RecoverPass.dart';
import 'package:movitronia/Design/All/Manuals/Manuals.dart';
import 'package:movitronia/Design/All/Reports/ApplicationUse.dart';
import 'package:movitronia/Design/All/Reports/CaloricExpenditure.dart';
import 'package:movitronia/Design/All/Reports/reports.dart';
import 'package:movitronia/Design/All/SessionPage/FinalPage.dart';
import 'package:movitronia/Design/All/SessionPage/Questionary.dart';
import 'package:movitronia/Design/All/SessionPage/ExcercisesPage.dart';
import 'package:movitronia/Design/All/SessionPage/Planification.dart';
import 'package:movitronia/Design/All/SessionPage/ShowCalories.dart';
import 'package:movitronia/Design/All/SessionPage/EvidencesSession.dart';
import 'package:movitronia/Design/All/SessionPage/UploadData.dart';
import 'package:movitronia/Design/All/SessionPage/VideosToRecord.dart';
import 'package:movitronia/Design/All/Settings/ProfilePage.dart';
import 'package:movitronia/Design/All/Settings/SettingsPage.dart';
import 'package:movitronia/Design/All/Settings/changePass.dart';
import 'package:movitronia/Design/All/Support/Support.dart';
import 'package:movitronia/Design/All/Terms/terms.dart';
import 'package:movitronia/Design/All/Welcome/WelcomePage.dart';
import 'package:movitronia/Design/All/splash/splash.dart';
import 'package:orientation_helper/orientation_helper.dart';
import './../Design/All/Login/TeacherSelectCollege.dart';

class AppRoutes {
  static var splash = RouteDetails(
    name: '/splash',
    page: Splash(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var login = RouteDetails(
    name: '/login',
    page: Login(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var homeUser = RouteDetails(
    name: '/homeUser',
    page: HomePageUser(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var homeTeacher = RouteDetails(
    name: '/homeTeacher',
    page: HomePageTeacher(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var basalUser = RouteDetails(
    name: '/basalUser',
    page: BasalUser(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var basalTeacher = RouteDetails(
    name: '/basalTeacher',
    page: BasalTeacher(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var terms = RouteDetails(
    name: '/terms',
    page: Terms(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var welcome = RouteDetails(
    name: '/welcome',
    page: WelcomePage(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var planification = RouteDetails(
    name: '/planification',
    page: Planification(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var excercisesPage = RouteDetails(
    name: '/excercisesPage',
    page: ExcercisesPage(),
    orientation: ScreenOrientation.portraitOnly,
  );

  // static var sessionPage = RouteDetails(
  //   name: '/sessionPage',
  //   page: ExcerciseVideo(),
  //   orientation: ScreenOrientation.rotating,
  // );

  static var showCalories = RouteDetails(
    name: '/showCalories',
    page: ShowCalories(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var evidencesSession = RouteDetails(
    name: '/evidencesSession',
    page: EvidencesSession(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var uploadData = RouteDetails(
    name: '/uploadData',
    page: UploadData(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var videosToRecord = RouteDetails(
    name: '/videosToRecord',
    page: VideosToRecord(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var questionary = RouteDetails(
    name: '/questionary',
    page: Questionary(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var reports = RouteDetails(
    name: '/reports',
    page: Reports(
      drawerMenu: true,
    ),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var finalPage = RouteDetails(
    name: '/finalPage',
    page: FinalPage(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var caloricExpenditure = RouteDetails(
    name: '/caloricExpenditure',
    page: CaloricExpenditure(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var applicationUse = RouteDetails(
    name: '/applicationUse',
    page: ApplicationUse(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var allEvidences = RouteDetails(
    name: '/allEvidences',
    page: AllEvidences(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var evidencesVideos = RouteDetails(
    name: '/evidencesVideos',
    page: EvidencesVideos(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var evidencesQuestionary = RouteDetails(
    name: '/evidencesQuestionary',
    page: EvidencesQuestionary(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var showCycle = RouteDetails(
    name: '/showCycle',
    page: ShowCycle(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var showPhases = RouteDetails(
    name: '/showPhases',
    page: ShowPhases(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var createClass = RouteDetails(
    name: '/createClass',
    page: CreateClass(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var excercisesClass = RouteDetails(
    name: '/excercisesClass',
    page: ExcercisesClass(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var filterExcercises = RouteDetails(
    name: '/filterExcercises',
    page: FilterExcercises(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var addExcercises = RouteDetails(
    name: '/addExcercises',
    page: AddExcercises(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var finishCreateClass = RouteDetails(
    name: '/finishCreateClass',
    page: FinishCreateClass(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var assignCreatedClass = RouteDetails(
    name: '/assignCreatedClass',
    page: AssignCreatedClass(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var messageUploadData = RouteDetails(
    name: '/messageUploadData',
    page: MessageUploadData(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var support = RouteDetails(
    name: '/support',
    page: Support(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var manuals = RouteDetails(
    name: '/manuals',
    page: Manuals(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var searchEvidences = RouteDetails(
    name: '/searchEvidences',
    page: SearchEvidences(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var menuEvidences = RouteDetails(
    name: '/menuEvidences',
    page: MenuEvidences(),
    orientation: ScreenOrientation.portraitOnly,
  );
/*
  static var detailsExcercises = RouteDetails(
    name: '/detailsExcercises',
    page: DetailsExcercise(),
    orientation: ScreenOrientation.portraitOnly,
  );
*/
  static var recoverPass = RouteDetails(
    name: '/recoverPass',
    page: RecoverPass(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var settingsPage = RouteDetails(
    name: '/settingsPage',
    page: SettingsPage(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var teacherSelectCollege = RouteDetails(
    name: '/teacherSelectCollege',
    page: TeacherSelectCollege(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var profilePage = RouteDetails(
    name: '/profilePage',
    page: ProfilePage(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static var changePass = RouteDetails(
    name: '/changePass',
    page: ChangePass(),
    orientation: ScreenOrientation.portraitOnly,
  );

  static List<RouteDetails> get routes => [
        splash,
        login,
        //User
        homeUser,
        basalUser,
        terms,
        welcome,
        planification,
        excercisesPage,
        // sessionPage,
        showCalories,
        evidencesSession,
        uploadData,
        videosToRecord,
        questionary,
        reports,
        finalPage,
        caloricExpenditure,
        applicationUse,
        allEvidences,
        evidencesVideos,
        evidencesQuestionary,
        //Teacher
        homeTeacher,
        basalTeacher,
        showCycle,
        showPhases,
        createClass,
        excercisesClass,
        filterExcercises,
        addExcercises,
        finishCreateClass,
        assignCreatedClass,
        messageUploadData,
        searchEvidences,
        menuEvidences,
        manuals,
        support,
        // detailsExcercises,
        recoverPass,
        settingsPage,
        teacherSelectCollege,
        profilePage,
        changePass
      ];
}