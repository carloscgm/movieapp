import 'package:movieapp/domain/models/artist_model.dart';

abstract interface class ArtistRemoteInterface {
  Future<List<ArtistModel>> getArtists();
}
