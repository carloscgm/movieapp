import 'package:movieapp/domain/models/movie_detail_casting_model.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';

class MemoryCache {
  // Singleton class
  static final MemoryCache _memoryCache = MemoryCache._internal();

  factory MemoryCache() {
    return _memoryCache;
  }

  MemoryCache._internal() {
    // Empty constructor
  }

  // Cache data

  // movies
  Map<int, List<MovieModel>> movieNowPlaying = {};
  Map<int, List<MovieModel>> movieUpcoming = {};
  Map<int, List<MovieModel>> movieTopRated = {};
  Map<int, List<MovieModel>> moviePopular = {};
  Map<int, MovieDetailModel> movieDetails = {};

  //tv series
  Map<int, List<TvModel>> tvOnTheAir = {};
  Map<int, List<TvModel>> tvAiring = {};
  Map<int, List<TvModel>> tvTopRated = {};
  Map<int, List<TvModel>> tvPopular = {};
  Map<int, TvDetailModel> tvDetails = {};
  Map<int, TvDetailCastingModel> tvDetailsCasting = {};
  Map<int, MovieDetailCastingModel> movieDetailsCasting = {};

  clearAll() {
    // Clear all data
    movieNowPlaying = {};
    movieUpcoming = {};
    movieTopRated = {};
    moviePopular = {};
    movieDetails = {};
    tvOnTheAir = {};
    tvAiring = {};
    tvTopRated = {};
    tvPopular = {};
    tvDetails = {};
  }
}
