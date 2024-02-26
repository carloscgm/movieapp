import 'dart:async';

import 'package:movieapp/domain/interfaces/usecases/movie_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/base_view_model_interface.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';

abstract interface class MovieViewModelInterface implements BaseViewModel {
  final MovieUseCaseInterface movieUseCase;
  final StreamController<ResourceState> movieNowPlayingListState;
  final StreamController<ResourceState> moviePopularListState;
  final StreamController<ResourceState> movieTopRatedListState;
  final StreamController<ResourceState> movieUpcomingListState;
  final StreamController<ResourceState> movieDetailListState;
  final StreamController<ResourceState> tvAiringTodayListState;
  final StreamController<ResourceState> tvOnTheAirListState;
  final StreamController<ResourceState> tvPopularListState;
  final StreamController<ResourceState> tvTopRatedListState;
  final StreamController<ResourceState> tvDetailListState;
  final StreamController<ResourceState> tvDetailCastingListState;

  MovieViewModelInterface({
    required this.movieUseCase,
    required this.movieNowPlayingListState,
    required this.moviePopularListState,
    required this.movieTopRatedListState,
    required this.movieUpcomingListState,
    required this.movieDetailListState,
    required this.tvAiringTodayListState,
    required this.tvOnTheAirListState,
    required this.tvPopularListState,
    required this.tvTopRatedListState,
    required this.tvDetailListState,
    required this.tvDetailCastingListState,
  });

  Future<void> fetchNowPlaying();
  Future<void> fetchUpcoming();
  Future<void> fetchTopRated();
  Future<void> fetchPopular();
  Future<void> fetchNextNowPlaying(int page);
  Future<void> fetchNextUpcoming(int page);
  Future<void> fetchNextTopRated(int page);
  Future<void> fetchNextPopular(int page);
  Future<void> fetchMovieDetail(int idMovie);
  Future<void> fetchTvOnTheAir(int page);
  Future<void> fetchTvAiringToday(int page);
  Future<void> fetchTvPopular(int page);
  Future<void> fetchTvTopRated(int page);
  Future<void> fetchTVDetail(int idTv);
  Future<void> fetchTVDetailCasting(int idTv);
  Future<void> fetchNext(int page, MovieListType type);
}
