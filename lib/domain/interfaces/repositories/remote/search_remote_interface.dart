import 'package:movieapp/domain/models/movie_model.dart';

abstract interface class SearchRemoteInterface {
  Future<List<MovieModel>> searchByQuery(String query, int page);
}
