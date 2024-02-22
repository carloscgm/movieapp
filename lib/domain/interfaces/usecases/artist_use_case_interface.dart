import 'package:movieapp/domain/models/artist_model.dart';

abstract interface class ArtistUseCaseInterface {
  Future<List<ArtistModel>> getArtists();
}
