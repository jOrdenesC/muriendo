import 'package:movitronia/Database/Models/OfflineData.dart';

abstract class OfflineRepository{
  Future<int> insert(OfflineData offlineData);

  Future update(OfflineData offlineData);

  Future delete(int uuid);

  Future<List<OfflineData>> getAll();

  Future<List<OfflineData>> getAllFalse();

  Future<List<OfflineData>> getForId(String uuid);
}
