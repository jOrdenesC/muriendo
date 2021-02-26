import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/QuestionData.dart';
import 'package:sembast/sembast.dart';

import 'QuestionDataRepository.dart';

class SembastQuestionDataRepository extends QuestionDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("questionData_store");

  @override
  Future<int> insertQuestion(QuestionData gifData) async {
    print(gifData.toMap().toString());
    print(gifData.toMap());
    return await _store.add(_database, gifData.toMap());
  }

  @override
  Future updateQuestion(QuestionData gifData) async {
    await _store.record(gifData.id).update(_database, gifData.toMap());
  }

  @override
  Future deleteQuestion(int gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  @override
  Future<List<QuestionData>> getAllQuestions() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => QuestionData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<QuestionData>> getQuestion(String id) async {
    final finder = Finder(filter: Filter.equals('tipID', id));

    final snapshots = await _store.find(_database, finder: finder);
    //print("Snapshot: " + snapshots.toString());
    // var records = await _store.records([12, 14]).get(_database);
    //final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => QuestionData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
