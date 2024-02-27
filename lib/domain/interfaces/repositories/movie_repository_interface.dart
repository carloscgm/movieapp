import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/domain/models/movie_detail_casting_model.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';

abstract interface class MovieRepositoryInterface {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getUpcoming();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getNextNowPlaying(int page);
  Future<List<MovieModel>> getNextUpcoming(int page);
  Future<List<MovieModel>> getNextTopRated(int page);
  Future<List<MovieModel>> getNextPopular(int page);
  Future<MovieDetailModel> getMovieDetails(int idMovie);
  Future<List<TvModel>> getTVAiringToday(int page);
  Future<List<TvModel>> getTVOTA(int page);
  Future<List<TvModel>> getTVPopular(int page);
  Future<List<TvModel>> getTVTopRated(int page);
  Future<TvDetailModel> getTVDetail(int idMovie);
  Future<TvDetailCastingModel> getTvDetailCasting(int idMovie);
  Future<MovieDetailCastingModel> getMovieDetailCasting(int idMovie);
  Future<List<PostableItem>> getNext(int page, MovieListType type);
}
