import 'package:movieapp/domain/interfaces/repositories/search_repository_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/search_use_case_interface.dart';
import 'package:movieapp/domain/models/movie_model.dart';

class SearchUseCaseImpl implements SearchUseCaseInterface {
  final SearchRepositoryInterface searchRepository;

  SearchUseCaseImpl(this.searchRepository);

  @override
  Future<List<MovieModel>> searchByQuery(String query, int page) async {
    return await searchRepository.searchByQuery(query, page);
  }
}
