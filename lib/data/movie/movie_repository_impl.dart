import 'package:movieapp/data/cache/cache_memory.dart';
import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/domain/interfaces/repositories/movie_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/movie_remote_interface.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';

class MovieRepositoryImpl implements MovieRepositoryInterface {
  final MovieRemoteInterface _remote;
  final MemoryCache _cache;
  MovieRepositoryImpl(this._remote, this._cache);

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    if (_cache.movieNowPlaying.containsKey(0)) {
      return _cache.movieNowPlaying[0]!;
    } else {
      final result = await _remote.getNowPlaying();
      _cache.movieNowPlaying[0] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming() async {
    if (_cache.movieUpcoming.containsKey(0)) {
      return _cache.movieUpcoming[0]!;
    } else {
      final result = await _remote.getUpcoming();
      _cache.movieUpcoming[0] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    if (_cache.movieTopRated.containsKey(0)) {
      return _cache.movieTopRated[0]!;
    } else {
      final result = await _remote.getTopRated();
      _cache.movieTopRated[0] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    if (_cache.moviePopular.containsKey(0)) {
      return _cache.moviePopular[0]!;
    } else {
      final result = await _remote.getPopular();
      _cache.moviePopular[0] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getNextNowPlaying(int page) async {
    if (_cache.moviePopular.containsKey(page)) {
      return _cache.moviePopular[page]!;
    } else {
      final result = await _remote.getNextNowPlaying(page);
      _cache.moviePopular[page] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getNextUpcoming(int page) async {
    if (_cache.movieUpcoming.containsKey(page)) {
      return _cache.movieUpcoming[page]!;
    } else {
      final result = await _remote.getNextUpcoming(page);
      _cache.movieUpcoming[page] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getNextTopRated(int page) async {
    if (_cache.movieTopRated.containsKey(page)) {
      return _cache.movieTopRated[page]!;
    } else {
      final result = await _remote.getNextTopRated(page);
      _cache.movieTopRated[page] = result;
      return result;
    }
  }

  @override
  Future<List<MovieModel>> getNextPopular(int page) async {
    if (_cache.moviePopular.containsKey(page)) {
      return _cache.moviePopular[page]!;
    } else {
      final result = await _remote.getNextPopular(page);
      _cache.moviePopular[page] = result;
      return result;
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(int idMovie) async {
    if (_cache.movieDetails.containsKey(idMovie)) {
      return _cache.movieDetails[idMovie]!;
    } else {
      final result = await _remote.getMovieDetails(idMovie);
      _cache.movieDetails[idMovie] = result;
      return result;
    }
  }

  @override
  Future<List<TvModel>> getTVAiringToday(int page) async {
    if (_cache.tvAiring.containsKey(page)) {
      return _cache.tvAiring[page]!;
    } else {
      final result = await _remote.getTVAiringToday(page);
      _cache.tvAiring[page] = result;
      return result;
    }
  }

  @override
  Future<TvDetailModel> getTVDetail(int idTv) async {
    if (_cache.tvDetails.containsKey(idTv)) {
      return _cache.tvDetails[idTv]!;
    } else {
      final result = await _remote.getTvDetails(idTv);
      _cache.tvDetails[idTv] = result;
      return result;
    }
  }

  @override
  Future<List<TvModel>> getTVOTA(int page) async {
    if (_cache.tvOnTheAir.containsKey(page)) {
      return _cache.tvOnTheAir[page]!;
    } else {
      final result = await _remote.getTVOTA(page);
      _cache.tvOnTheAir[page] = result;
      return result;
    }
  }

  @override
  Future<List<TvModel>> getTVPopular(int page) async {
    if (_cache.tvPopular.containsKey(page)) {
      return _cache.tvPopular[page]!;
    } else {
      final result = await _remote.getTVPopular(page);
      _cache.tvPopular[page] = result;
      return result;
    }
  }

  @override
  Future<List<TvModel>> getTVTopRated(int page) async {
    if (_cache.tvTopRated.containsKey(page)) {
      return _cache.tvTopRated[page]!;
    } else {
      final result = await _remote.getTVTopRated(page);
      _cache.tvTopRated[page] = result;
      return result;
    }
  }

  @override
  Future<TvDetailCastingModel> getTvDetailCasting(int idTv) async {
    if (_cache.tvDetailsCasting.containsKey(idTv)) {
      return _cache.tvDetailsCasting[idTv]!;
    } else {
      final result = await _remote.getTvDetailsCasting(idTv);
      _cache.tvDetailsCasting[idTv] = result;
      return result;
    }
  }

  @override
  Future<List<PostableItem>> getNext(int page, MovieListType type) async {
    return await _remote.getNext(page, type);
  }
}
