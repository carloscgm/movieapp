import 'dart:async';
import 'package:movieapp/domain/interfaces/usecases/movie_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/movie_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_action.dart';
import 'package:movieapp/presentation/view/movie/viewmodel/movie_error_builder.dart';

class MovieViewModelImpl implements MovieViewModelInterface {
  @override
  final MovieUseCaseInterface movieUseCase;

  @override
  StreamController<ResourceState> movieNowPlayingListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> moviePopularListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> movieTopRatedListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> movieUpcomingListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> movieDetailListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> tvAiringTodayListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> tvOnTheAirListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> tvPopularListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> tvTopRatedListState =
      StreamController<ResourceState>();
  @override
  StreamController<ResourceState> tvDetailListState =
      StreamController<ResourceState>();

  @override
  StreamController<ResourceState> tvDetailCastingListState =
      StreamController<ResourceState>();

  MovieViewModelImpl(this.movieUseCase);

  @override
  void dispose() {
    movieNowPlayingListState.close();
    moviePopularListState.close();
    movieTopRatedListState.close();
    movieUpcomingListState.close();
    movieDetailListState.close();
    tvAiringTodayListState.close();
    tvOnTheAirListState.close();
    tvPopularListState.close();
    tvTopRatedListState.close();
    tvDetailListState.close();
  }

  @override
  Future<void> fetchPopular() async {
    moviePopularListState.add(ResourceState.loading());

    movieUseCase
        .getPopular()
        .then((value) =>
            moviePopularListState.add(ResourceState.completed(value)))
        .catchError((e) {
      moviePopularListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_POPULAR).build()));
    });
  }

  @override
  Future<void> fetchTopRated() async {
    movieTopRatedListState.add(ResourceState.loading());

    movieUseCase
        .getTopRated()
        .then((value) =>
            movieTopRatedListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieTopRatedListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TOP_RATED).build()));
    });
  }

  @override
  Future<void> fetchUpcoming() async {
    movieUpcomingListState.add(ResourceState.loading());

    movieUseCase
        .getUpcoming()
        .then((value) =>
            movieUpcomingListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieUpcomingListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_UPCOMING).build()));
    });
  }

  @override
  Future<void> fetchNextUpcoming(int page) async {
    movieUpcomingListState.add(ResourceState.loading());

    movieUseCase
        .getNextUpcoming(page)
        .then((value) =>
            movieUpcomingListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieUpcomingListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_UPCOMING).build()));
    });
  }

  @override
  Future<void> fetchNextPopular(int page) async {
    moviePopularListState.add(ResourceState.loading());

    movieUseCase
        .getNextPopular(page)
        .then((value) =>
            moviePopularListState.add(ResourceState.completed(value)))
        .catchError((e) {
      moviePopularListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_POPULAR).build()));
    });
  }

  @override
  Future<void> fetchNextTopRated(int page) async {
    movieTopRatedListState.add(ResourceState.loading());

    movieUseCase
        .getNextTopRated(page)
        .then((value) =>
            movieTopRatedListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieTopRatedListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TOP_RATED).build()));
    });
  }

  @override
  Future<void> fetchNextNowPlaying(int page) async {
    movieNowPlayingListState.add(ResourceState.loading());

    movieUseCase
        .getNextNowPlaying(page)
        .then((value) =>
            movieNowPlayingListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieNowPlayingListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_NOW_PLAYING).build()));
    });
  }

  @override
  Future<void> fetchMovieDetail(int idMovie) async {
    movieDetailListState.add(ResourceState.loading());

    movieUseCase
        .getMovieDetails(idMovie)
        .then(
            (value) => movieDetailListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieDetailListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_MOVIE_DETAILS).build()));
    });
  }

  @override
  Future<void> fetchNowPlaying() async {
    movieNowPlayingListState.add(ResourceState.loading());

    movieUseCase
        .getNowPlaying()
        .then((value) =>
            movieNowPlayingListState.add(ResourceState.completed(value)))
        .catchError((e) {
      movieNowPlayingListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_NOW_PLAYING).build()));
    });
  }

  @override
  Future<void> fetchTvOnTheAir(int page) async {
    tvOnTheAirListState.add(ResourceState.loading());

    movieUseCase
        .getTVOnTheAir(page)
        .then(
            (value) => tvOnTheAirListState.add(ResourceState.completed(value)))
        .catchError((e) {
      tvOnTheAirListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TV_ONTHEAIR).build()));
    });
  }

  @override
  Future<void> fetchTvAiringToday(int page) async {
    tvAiringTodayListState.add(ResourceState.loading());

    movieUseCase
        .getTVAiringToday(page)
        .then((value) =>
            tvAiringTodayListState.add(ResourceState.completed(value)))
        .catchError((e) {
      tvAiringTodayListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TV_AIRING).build()));
    });
  }

  @override
  Future<void> fetchTvPopular(int page) async {
    tvPopularListState.add(ResourceState.loading());

    movieUseCase
        .getTVPopular(page)
        .then((value) => tvPopularListState.add(ResourceState.completed(value)))
        .catchError((e) {
      tvPopularListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TV_POPULAR).build()));
    });
  }

  @override
  Future<void> fetchTvTopRated(int page) async {
    tvTopRatedListState.add(ResourceState.loading());

    movieUseCase
        .getTVTopRated(page)
        .then(
            (value) => tvTopRatedListState.add(ResourceState.completed(value)))
        .catchError((e) {
      tvTopRatedListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TV_TOPRATED).build()));
    });
  }

  @override
  Future<void> fetchTVDetail(int idTv) async {
    tvDetailListState.add(ResourceState.loading());

    movieUseCase
        .getTvDetail(idTv)
        .then((value) => tvDetailListState.add(ResourceState.completed(value)))
        .catchError((e) {
      tvDetailListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TV_DETAILS).build()));
    });
  }

  @override
  Future<void> fetchTVDetailCasting(int idTv) async {
    tvDetailCastingListState.add(ResourceState.loading());

    movieUseCase
        .getTvDetailCasting(idTv)
        .then((value) =>
            tvDetailCastingListState.add(ResourceState.completed(value)))
        .catchError((e) {
      tvDetailCastingListState.add(ResourceState.error(
          MovieErrorBuilder.create(e, AppAction.GET_TV_DETAILS).build()));
    });
  }
}
