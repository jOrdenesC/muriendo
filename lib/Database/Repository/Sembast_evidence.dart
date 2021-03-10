import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/evidencesSend.dart';
import 'package:sembast/sembast.dart';
import 'EvidencesSentRepository.dart';

class SembastEvidenceRepository extends EvidencesRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("evidence_store");

  Future<int> insertEvidence(EvidencesSend gifData) async {
    return await _store.add(_database, gifData.toMap());
  }

  Future updateEvidence(EvidencesSend gifData) async {
    await _store.delete(_database,
        finder: Finder(filter: Filter.equals("number", gifData.number)));
    await _store.add(_database, gifData.toMap());
  }

  Future deleteEvidence(String gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  Future<List<EvidencesSend>> getAllEvidences() async {
    final snapshots = await _store.find(_database,
        finder: Finder(sortOrders: [
          SortOrder("number"),
        ]));
    return snapshots
        .map((snapshot) => EvidencesSend.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<List<EvidencesSend>> getEvidenceID(String uuid) async {
    final finder = Finder(filter: Filter.byKey(uuid));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => EvidencesSend.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future<List<EvidencesSend>> getEvidenceNumber(int number) async {
    final finder = Finder(filter: Filter.equals("number", number));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => EvidencesSend.fromMap(snapshot.value))
        .toList(growable: false);
  }

  Future deleteAll() async {
    print("eliminadas todas las evidencias");
    await _store.delete(_database);
    return null;
  }
}
