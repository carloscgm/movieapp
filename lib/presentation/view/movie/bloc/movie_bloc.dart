import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/domain/interfaces/usecases/movie_use_case_interface.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieUseCaseInterface movieUseCase;

  MovieBloc(this.movieUseCase) : super(const MovieState()) {
    on<MovieEvent>((event, emit) {});

    on<FetchPopular>(blocFetchPopular);
    on<FetchTopRated>(blocFetchTopRated);
    on<FetchUpcoming>(blocFetchUpcoming);
    on<FetchMovieDetail>(blocFetchMovieDetails);
    on<FetchTvTopRated>(blocFetchTVTopRated);
    on<FetchTvPopular>(blocFetchTVPopular);
    on<FetchTVDetail>(blocFetchTVDetails);
    on<FetchTVDetailCasting>(blocFetchTVDetailsCasting);
    on<FetchNext>(blocFetchNext);
    on<MoveMoviesToNext>(blocMoveMoviestoNext);
  }

  void blocMoveMoviestoNext(MoveMoviesToNext event, Emitter<MovieState> emit) {
    switch (event.type.status) {
      case TypeListMovie.MOVIE_POPULAR:
        emit(state.copyWith(nextList: state.popularMovieList));
        break;
      case TypeListMovie.MOVIE_TOPRATED:
        emit(state.copyWith(nextList: state.topRatedMovieList));
        break;
      case TypeListMovie.TV_POPULAR:
        emit(state.copyWith(nextList: state.popularTVList));
        break;
      case TypeListMovie.TV_TOPRATED:
        emit(state.copyWith(nextList: state.topRatedTVList));
        break;
      default:
        break;
    }
  }

  void blocFetchNext(FetchNext event, Emitter<MovieState> emit) async {
    List<PostableItem> result =
        await movieUseCase.getNext(event.id, event.type);
    if (state.nextList.isNotEmpty) {
      result = state.nextList + result;
    }
    emit(state.copyWith(nextList: result));
  }

  void blocFetchTVDetailsCasting(
      FetchTVDetailCasting event, Emitter<MovieState> emit) async {
    TvDetailCastingModel result =
        await movieUseCase.getTvDetailCasting(event.id);
    emit(state.copyWith(tvDetailsCasting: result));
  }

  void blocFetchTVDetails(FetchTVDetail event, Emitter<MovieState> emit) async {
    TvDetailModel result = await movieUseCase.getTvDetail(event.id);
    emit(state.copyWith(tvDetails: result));
  }

  void blocFetchTVPopular(
      FetchTvPopular event, Emitter<MovieState> emit) async {
    List<TvModel> result = await movieUseCase.getTVPopular(event.page);
    if (state.popularTVList.isNotEmpty) {
      result = state.popularTVList + result;
    }
    emit(state.copyWith(popularTVList: result));
  }

  void blocFetchTVTopRated(
      FetchTvTopRated event, Emitter<MovieState> emit) async {
    List<TvModel> result = await movieUseCase.getTVTopRated(event.page);
    if (state.topRatedTVList.isNotEmpty) {
      result = state.topRatedTVList + result;
    }
    emit(state.copyWith(topRatedTVList: result));
  }

  void blocFetchMovieDetails(
      FetchMovieDetail event, Emitter<MovieState> emit) async {
    MovieDetailModel result = await movieUseCase.getMovieDetails(event.id);
    emit(state.copyWith(movieDetails: result));
  }

  void blocFetchUpcoming(FetchUpcoming event, Emitter<MovieState> emit) async {
    List<MovieModel> result = await movieUseCase.getUpcoming();
    emit(state.copyWith(upcomingList: result));
  }

  void blocFetchTopRated(FetchTopRated event, Emitter<MovieState> emit) async {
    List<MovieModel> result = await movieUseCase.getNextTopRated(event.page);
    if (state.topRatedMovieList.isNotEmpty) {
      result = state.topRatedMovieList + result;
    }
    emit(state.copyWith(topRatedMovieList: result));
  }

  void blocFetchPopular(FetchPopular event, Emitter<MovieState> emit) async {
    List<MovieModel> result = await movieUseCase.getNextPopular(event.page);
    if (state.popularMovieList.isNotEmpty) {
      result = state.popularMovieList + result;
    }
    emit(state.copyWith(popularMovieList: result));
  }

  void fetchPopular(int page) {
    add(FetchPopular(page: page));
  }

  void fetchTopRated(int page) {
    add(FetchTopRated(page: page));
  }

  void fetchUpcoming() {
    add(FetchUpcoming());
  }

  void fetchMovieDetail(int id) {
    add(FetchMovieDetail(id: id));
  }

  void fetchTvPopular(int page) {
    add(FetchTvPopular(page: page));
  }

  void fetchTvTopRated(int page) {
    add(FetchTvTopRated(page: page));
  }

  void fetchTVDetail(int id) {
    add(FetchTVDetail(id: id));
  }

  void fetchTVDetailCasting(int id) {
    add(FetchTVDetailCasting(id: id));
  }

  void fetchNext(int id, MovieListType type) {
    add(FetchNext(id: id, type: type));
  }

  void moveMoviesToNext(MovieListType type) {
    add(MoveMoviesToNext(type: type));
  }
}
