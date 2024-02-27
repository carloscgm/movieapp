import 'package:movieapp/domain/interfaces/repositories/remote/search_remote_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/search_repository_interface.dart';
import 'package:movieapp/domain/models/movie_model.dart';

class SearchRepositoryImpl implements SearchRepositoryInterface {
  final SearchRemoteInterface _remote;
  SearchRepositoryImpl(this._remote);

  @override
  Future<List<MovieModel>> searchByQuery(String query, int page) async {
    return await _remote.searchByQuery(query, page);
  }
}
