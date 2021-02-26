// import 'package:get_it/get_it.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';
// import 'ExcerciseRepository/ExcerciseDataRepository.dart';
// import 'ExcerciseRepository/sembast_excercisedata.dart';
// import 'QuestionDataRepository/QuestionDataRepository.dart';
// import 'QuestionDataRepository/sembast_questiondata.dart';
// import 'TipsDataRepository/TipsDataRepository.dart';
// import 'TipsDataRepository/sembast_tipsdata.dart';

// class Init {
//   static Future initialize() async {
//     await _initSembast();
//     _registerRepositories();
//   }

//   static Future _initSembast() async {
//     final appDir = await getApplicationDocumentsDirectory();
//     await appDir.create(recursive: true);
//     final databasePath = join(appDir.path, "sembast.db");
//     final database = await databaseFactoryIo.openDatabase(databasePath);
//     GetIt.I.registerSingleton<Database>(database);
//   }

//   static _registerRepositories() {
//     GetIt.I.registerLazySingleton<ExcerciseDataRepository>(
//         () => SembastExcerciseDataRepository());

//     // GetIt.I.registerLazySingleton<ClassDataRepository>(
//     //     () => SembastClassDataRepository());

//     GetIt.I.registerLazySingleton<QuestionDataRepository>(
//         () => SembastQuestionDataRepository());

//     // GetIt.I.registerLazySingleton<GifDataRepository>(
//     //     () => SembastGifDataRepository());

//     // GetIt.I.registerLazySingleton<QuestionaryRepository>(
//     //     () => SembastQuestionaryRepository());

//     GetIt.I.registerLazySingleton<TipsDataRepository>(
//         () => SembastTipsDataRepository());
//   }
// }
