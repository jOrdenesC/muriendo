import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/OfflineData.dart';
import 'package:sembast/sembast.dart';
import 'OfflineRepository.dart';

class SembastOfflineRepository extends OfflineRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("offline_store");

  Future<int> insert(OfflineData gifData) async {
    print(gifData.toMap());
    return await _store.add(_database, gifData.toMap());
  }

  Future update(OfflineData gifData) async {
    await _store.record(gifData.uuid).update(_database, gifData.toMap());
  }

  Future delete(int gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  Future deleteElement(String id) async {
    final finder = Finder(filter: Filter.equals('uuid', id));
    await _store.delete(_database, finder: finder);
    return true;
  }

  Future<List<OfflineData>> getAll() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => OfflineData.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<List<OfflineData>> getForId(String uuid) async {
    final finder = Finder(filter: Filter.byKey(uuid));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => OfflineData.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<List<OfflineData>> getAllFalse() async {
    final finder = Finder(filter: Filter.equals("upload", false));
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => OfflineData.fromMap(snapshot.value))
        .toList(growable: false);
  }
}
