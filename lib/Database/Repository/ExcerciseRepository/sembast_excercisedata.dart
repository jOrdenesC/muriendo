import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:sembast/sembast.dart';
import 'ExcerciseDataRepository.dart';

class SembastExcerciseDataRepository extends ExcerciseDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("gifData_store");

  @override
  Future<int> insertExcercise(ExcerciseData gifData) async {
    return await _store.add(_database, gifData.toMap());
  }

  @override
  Future updateExcercise(ExcerciseData gifData) async {
    await _store.record(gifData.id).update(_database, gifData.toMap());
  }

  @override
  Future deleteExcercise(int gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  @override
  Future<List<ExcerciseData>> getAllExcercise() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<ExcerciseData>> getExcerciseID(int id) async {
    final finder = Finder(filter: Filter.equals('excerciseID', id));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<ExcerciseData>> getExerciseById(String id) async {
    final finder = Finder(filter: Filter.equals('idMongo', id));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }


  @override
  Future<List<ExcerciseData>> getExcerciseName(String name) async {
    final finder = Finder(filter: Filter.equals('videoName', name));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<ExcerciseData>> getExcerciseVideoName(String name) async {
    final finder = Finder(filter: Filter.equals('nameExcercise', name));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<ExcerciseData>> getExcerciseByLevelAndStage(int level, String stage) async {
    final finder = Finder(
      filter: Filter.and([
        Filter.equals('level', level, anyInList: true),
        Filter.equals('stages', stage, anyInList: true,)
      ]),
    );

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  Future<List<ExcerciseData>> getExercisesByCategories(
      String stage, String category, String subCategory, String level) async {
    final finder = Finder(
        filter: Filter.and([
      Filter.equals('stages', stage, anyInList: true),
      Filter.equals('categories', category, anyInList: true),
      Filter.equals('categories', subCategory, anyInList: true)
    ]));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  Future<List<ExcerciseData>> getExercisesPie(String category) async {
    final finder = Finder(
      filter: Filter.equals('categories', category, anyInList: true),
    );

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ExcerciseData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<ExcerciseData>> loopSearch(List<int> listId) async {
    List<ExcerciseData> listGifs = [];
    for (var i = 0; i < listId.length; i++) {
      final gifs = await getExcerciseID(listId[i]);
      listGifs.add(gifs[0]);
    }

    return listGifs;
  }

  Future deleteAll() async {
    await _store.delete(_database);
    return null;
  }
}
