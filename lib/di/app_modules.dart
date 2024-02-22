import 'package:movieapp/data/artist/artist_repository_impl.dart';
import 'package:movieapp/data/artist/remote/artist_remote_impl.dart';
import 'package:movieapp/data/auth/auth_repository_impl.dart';
import 'package:movieapp/data/auth/remote/auth_remote_impl.dart';
import 'package:movieapp/data/cache/cache_memory.dart';
import 'package:movieapp/data/movie/movie_repository_impl.dart';
import 'package:movieapp/data/movie/remote/movie_remote_impl.dart';
import 'package:movieapp/data/remote/http_client.dart';
import 'package:movieapp/domain/interfaces/repositories/artist_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/auth_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/movie_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/artist_remote_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/auth_remote_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/movie_remote_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/artist_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/auth_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/movie_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/artist_view_model_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/auth_view_model_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/movie_view_model_interface.dart';
import 'package:movieapp/domain/usecases/artist_use_case_impl.dart';
import 'package:movieapp/domain/usecases/auth_use_case_impl.dart';
import 'package:movieapp/domain/usecases/movie_use_case_impl.dart';
import 'package:movieapp/presentation/view/artist/viewmodel/artist_view_model.dart';
import 'package:movieapp/presentation/view/auth/viewmodel/auth_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/presentation/view/movie/viewmodel/movie_view_model.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupAuthModule();
    _setupArtistModule();
    _setupMoviesModule();
  }

  _setupMainModule() {
    inject.registerSingleton(HttpClient());
    inject.registerSingleton(MemoryCache());
  }

  _setupAuthModule() {
    inject.registerFactory<AuthRemoteInterface>(
        () => AuthRemoteImpl(inject.get()));
    inject.registerFactory<AuthRepositoryInterface>(
        () => AuthRepositoryImpl(inject.get()));
    inject.registerFactory<AuthUseCaseInterface>(
        (() => AuthUseCaseImpl(inject.get())));
    inject.registerFactory<AuthViewModelInterface>(
        () => AuthViewModelImpl(inject.get()));
  }

  _setupArtistModule() {
    inject.registerFactory<ArtistRemoteInterface>(
        () => ArtistRemoteImpl(inject.get()));
    inject.registerFactory<ArtistRepositoryInterface>(
        () => ArtistRepositoryImpl(inject.get()));
    inject.registerFactory<ArtistUseCaseInterface>(
        (() => ArtistUseCaseImpl(inject.get())));
    inject.registerFactory<ArtistViewModelInterface>(
        () => ArtistViewModelImpl(inject.get()));
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
}
