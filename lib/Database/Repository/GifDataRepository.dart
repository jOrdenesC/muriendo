

import 'package:movitronia/Database/Models/GifData.dart';

abstract class GifDataRepository {
  Future<int> insertGif(GifData gifdata);

  Future updateGif(GifData gifdata);

  Future deleteGif(int gifDataId);

  Future<List<GifData>> getAllGif();

  Future<List<GifData>> getGifID(int id);

  Future<List<GifData>> loopSearch(List<int> listId);
}
