import 'package:movieapp/domain/models/artist_model.dart';

abstract interface class ArtistRepositoryInterface {
  Future<List<ArtistModel>> getArtists();
}
