import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/sembast_classlevel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'Repository/ExcerciseRepository/sembast_excercisedata.dart';
import 'Repository/QuestionDataRepository/QuestionDataRepository.dart';
import 'Repository/CourseRepository.dart';
import 'Repository/QuestionDataRepository/sembast_questiondata.dart';
import 'Repository/TipsDataRepository/TipsDataRepository.dart';
import 'Repository/TipsDataRepository/sembast_tipsdata.dart';
import 'Repository/QuestionaryRepository.dart';
import 'Repository/sembast_questionary.dart';
import 'Repository/Sembast_evidence.dart';
import 'Repository/sembast_course.dart';
import 'Repository/EvidencesSentRepository.dart';

class Init {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "sembast.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }

  static _registerRepositories() {
    GetIt.I.registerLazySingleton<EvidencesRepository>(
        () => SembastEvidenceRepository());

    GetIt.I.registerLazySingleton<ExcerciseDataRepository>(
        () => SembastExcerciseDataRepository());

    GetIt.I.registerLazySingleton<ClassDataRepository>(
        () => SembastClassDataRepository());

    GetIt.I.registerLazySingleton<QuestionDataRepository>(
        () => SembastQuestionDataRepository());

    GetIt.I.registerLazySingleton<TipsDataRepository>(
        () => SembastTipsDataRepository());

    GetIt.I.registerLazySingleton<QuestionaryRepository>(
        () => SembastQuestionaryRepository());

    GetIt.I.registerLazySingleton<CourseDataRepository>(
        () => SembastCourseRepository());
  }
}
