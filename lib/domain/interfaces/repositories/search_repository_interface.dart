import 'package:movieapp/domain/models/movie_model.dart';

abstract interface class SearchRepositoryInterface {
  Future<List<MovieModel>> searchByQuery(String query, int page);
}
