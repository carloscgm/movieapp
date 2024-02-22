import 'package:movieapp/domain/interfaces/repositories/artist_repository_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/artist_use_case_interface.dart';
import 'package:movieapp/domain/models/artist_model.dart';

class ArtistUseCaseImpl implements ArtistUseCaseInterface {
  final ArtistRepositoryInterface artistRepository;

  ArtistUseCaseImpl(this.artistRepository);

  @override
  Future<List<ArtistModel>> getArtists() async {
    return await artistRepository.getArtists();
  }
}
