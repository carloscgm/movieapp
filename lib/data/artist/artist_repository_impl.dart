import 'package:movieapp/domain/interfaces/repositories/artist_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/artist_remote_interface.dart';
import 'package:movieapp/domain/models/artist_model.dart';

class ArtistRepositoryImpl implements ArtistRepositoryInterface {
  final ArtistRemoteInterface _remote;
  ArtistRepositoryImpl(this._remote);

  @override
  Future<List<ArtistModel>> getArtists() {
    return _remote.getArtists();
  }
}
