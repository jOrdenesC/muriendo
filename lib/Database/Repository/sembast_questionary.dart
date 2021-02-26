import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/QuestionaryData.dart';
import 'package:sembast/sembast.dart';
import 'QuestionaryRepository.dart';

class SembastQuestionaryRepository extends QuestionaryRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("questionary_store");

  Future<int> insert(QuestionaryData gifData) async {
    print('inside insertGif');
    print(gifData.toMap());
    return await _store.add(_database, gifData.toMap());
  }

  Future update(QuestionaryData gifData) async {
    await _store.record(gifData.uuid).update(_database, gifData.toMap());
  }

  Future delete(int gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  Future<List<QuestionaryData>> getAll() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => QuestionaryData.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<List<QuestionaryData>> getForId(String uuid) async {
    final finder = Finder(filter: Filter.equals("uuid", uuid));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => QuestionaryData.fromMap(snapshot.value))
        .toList(growable: false);
  }
}
