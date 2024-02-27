import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/domain/interfaces/repositories/movie_repository_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/movie_use_case_interface.dart';
import 'package:movieapp/domain/models/movie_detail_casting_model.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';

class MovieUseCaseImpl implements MovieUseCaseInterface {
  final MovieRepositoryInterface movieRepository;

  MovieUseCaseImpl(this.movieRepository);

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    return await movieRepository.getNowPlaying();
  }

  @override
  Future<List<MovieModel>> getUpcoming() async {
    return await movieRepository.getUpcoming();
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    return await movieRepository.getTopRated();
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    return await movieRepository.getPopular();
  }

  @override
  Future<List<MovieModel>> getNextNowPlaying(int page) async {
    return await movieRepository.getNextNowPlaying(page);
  }

  @override
  Future<List<MovieModel>> getNextUpcoming(int page) async {
    return await movieRepository.getNextUpcoming(page);
  }

  @override
  Future<List<MovieModel>> getNextTopRated(int page) async {
    return await movieRepository.getNextTopRated(page);
  }

  @override
  Future<List<MovieModel>> getNextPopular(int page) async {
    return await movieRepository.getNextPopular(page);
  }

  @override
  Future<MovieDetailModel> getMovieDetails(int idMovie) async {
    return await movieRepository.getMovieDetails(idMovie);
  }

  @override
  Future<List<TvModel>> getTVAiringToday(int page) async {
    return await movieRepository.getTVAiringToday(page);
  }

  @override
  Future<List<TvModel>> getTVOnTheAir(int page) async {
    return await movieRepository.getTVOTA(page);
  }

  @override
  Future<List<TvModel>> getTVPopular(int page) async {
    return await movieRepository.getTVPopular(page);
  }

  @override
  Future<List<TvModel>> getTVTopRated(int page) async {
    return await movieRepository.getTVTopRated(page);
  }

  @override
  Future<TvDetailModel> getTvDetail(int idTv) async {
    return await movieRepository.getTVDetail(idTv);
  }

  @override
  Future<TvDetailCastingModel> getTvDetailCasting(int idTv) async {
    return await movieRepository.getTvDetailCasting(idTv);
  }

  @override
  Future<List<PostableItem>> getNext(int page, MovieListType type) async {
    return await movieRepository.getNext(page, type);
  }

  @override
  Future<MovieDetailCastingModel> getMovieDetailCasting(int idTv) async {
    return await movieRepository.getMovieDetailCasting(idTv);
  }
}
