import 'package:movieapp/domain/models/movie_model.dart';

abstract interface class SearchUseCaseInterface {
  Future<List<MovieModel>> searchByQuery(String query, int page);
}
