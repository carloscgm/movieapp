import 'package:get_it/get_it.dart';
import 'package:movieapp/data/cache/cache_memory.dart';
import 'package:movieapp/data/movie/movie_repository_impl.dart';
import 'package:movieapp/data/movie/remote/movie_remote_impl.dart';
import 'package:movieapp/data/remote/http_client.dart';
import 'package:movieapp/data/search/remote/search_remote_impl.dart';
import 'package:movieapp/data/search/search_repository_impl.dart';
import 'package:movieapp/domain/interfaces/repositories/movie_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/movie_remote_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/search_remote_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/search_repository_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/movie_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/search_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/movie_view_model_interface.dart';
import 'package:movieapp/domain/usecases/movie_use_case_impl.dart';
import 'package:movieapp/domain/usecases/search_use_case_impl.dart';
import 'package:movieapp/presentation/view/movie/viewmodel/movie_view_model.dart';
import 'package:movieapp/presentation/view/search/bloc/search_bloc_bloc.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupMoviesModule();
    _setupSearchModule();
  }

  _setupMainModule() {
    inject.registerSingleton(HttpClient());
    inject.registerSingleton(MemoryCache());
  }

  _setupMoviesModule() {
    inject.registerFactory<MovieRemoteInterface>(
        () => MovieRemoteImpl(inject.get()));
    inject.registerFactory<MovieRepositoryInterface>(
        () => MovieRepositoryImpl(inject.get(), inject.get()));
    inject.registerFactory<MovieUseCaseInterface>(
        (() => MovieUseCaseImpl(inject.get())));
    inject.registerFactory<MovieViewModelInterface>(
        () => MovieViewModelImpl(inject.get()));
  }

  _setupSearchModule() {
    inject.registerFactory<SearchRemoteInterface>(
        () => SearchRemoteImpl(inject.get()));
    inject.registerFactory<SearchRepositoryInterface>(
        () => SearchRepositoryImpl(inject.get()));
    inject.registerFactory<SearchUseCaseInterface>(
        (() => SearchUseCaseImpl(inject.get())));
    inject.registerFactory(() => SearchBloc(inject.get()));
  }
}
