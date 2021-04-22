import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/TipsData.dart';
import 'package:movitronia/Database/Repository/TipsDataRepository/TipsDataRepository.dart';
import 'package:sembast/sembast.dart';

class SembastTipsDataRepository extends TipsDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("tipsData_store");

  @override
  Future<int> insertTips(TipsData gifData) async {
    print('inside insertExcercise');
    print(gifData.toMap());
    return await _store.add(_database, gifData.toMap());
  }

  @override
  Future updateTips(TipsData gifData) async {
    await _store.record(gifData.id).update(_database, gifData.toMap());
  }

  @override
  Future deleteTips(int gifDataId) async {
    print("Deleting $gifDataId");
    await _store.record(gifDataId).delete(_database);
  }

  @override
  Future<List<TipsData>> getAllTips() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => TipsData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<TipsData>> getTips(String id) async {
    final finder = Finder(filter: Filter.equals('documentID', id));

    final snapshots = await _store.find(_database, finder: finder);
    //print("Snapshot: " + snapshots.toString());
    // var records = await _store.records([12, 14]).get(_database);
    //final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => TipsData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  Future deleteAll() async {
    print("eliminadas todos los tips");
    await _store.delete(_database);
    return null;
  }
}
