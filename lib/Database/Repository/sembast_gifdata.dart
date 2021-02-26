import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/GifData.dart';
import 'package:sembast/sembast.dart';
import 'GifDataRepository.dart';

class SembastGifDataRepository extends GifDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("gifData_store");

  @override
  Future<int> insertGif(GifData gifData) async {
    print('inside insertGif');
    print(gifData.toMap());
    return await _store.add(_database, gifData.toMap());
  }

  @override
  Future updateGif(GifData gifData) async {
    await _store.record(gifData.id).update(_database, gifData.toMap());
  }

  @override
  Future deleteGif(int gifDataId) async {
    await _store.record(gifDataId).delete(_database);
  }

  @override
  Future<List<GifData>> getAllGif() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => GifData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<GifData>> getGifID(int id) async {
    final finder = Finder(filter: Filter.byKey(id));

    final snapshots = await _store.find(_database, finder: finder);
    //print("Snapshot: " + snapshots.toString());
    // var records = await _store.records([12, 14]).get(_database);
    //final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => GifData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<GifData>> loopSearch(List<int> listId) async {
    List<GifData> listGifs = [];
    for (var i = 0; i < listId.length; i++) {
      final gifs = await getGifID(listId[i]);
      print(gifs[0].name);
      listGifs.add(gifs[0]);
    }

    return listGifs;
  }
}
