import 'package:movieapp/data/remote/error/remote_error_mapper.dart';
import 'package:movieapp/data/remote/http_client.dart';
import 'package:movieapp/data/remote/network_endpoints.dart';
import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/movie_remote_interface.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';

class MovieRemoteImpl implements MovieRemoteInterface {
  final HttpClient _httpClient;
  MovieRemoteImpl(this._httpClient);

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.nowPlayingMovies,
        queryParameters: {'page': 1},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming() async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.upcomingMovies,
        queryParameters: {'page': 1},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.topRatedMovies,
        queryParameters: {'page': 1},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.popularMovies,
        queryParameters: {'page': 1},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getNextNowPlaying(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.nowPlayingMovies,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getNextUpcoming(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.upcomingMovies,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getNextTopRated(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.topRatedMovies,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<MovieModel>> getNextPopular(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.popularMovies,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(int idMovie) async {
    try {
      dynamic response =
          await _httpClient.dio.get('${NetworkEndpoints.detailsMovie}$idMovie');

      return MovieDetailModel.fromJson(response.data);
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<TvModel>> getTVAiringToday(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.airingTv,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<TvModel>((data) => TvModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<TvModel>> getTVOTA(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.onTheAirTv,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<TvModel>((data) => TvModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<TvModel>> getTVPopular(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.popularTv,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<TvModel>((data) => TvModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<TvModel>> getTVTopRated(int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.topRatedTv,
        queryParameters: {'page': page},
      );

      return response.data['results']
          .map<TvModel>((data) => TvModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<TvDetailModel> getTvDetails(int idTv) async {
    try {
      dynamic response =
          await _httpClient.dio.get('${NetworkEndpoints.detailsTv}$idTv');

      return TvDetailModel.fromJson(response.data);
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<TvDetailCastingModel> getTvDetailsCasting(int idTv) async {
    try {
      dynamic response = await _httpClient.dio
          .get('${NetworkEndpoints.castingTv}$idTv/aggregate_credits');

      return TvDetailCastingModel.fromJson(response.data);
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<List<PostableItem>> getNext(int page, MovieListType type) async {
    try {
      dynamic response = await _httpClient.dio.get(
        endpointFiltered(type),
        queryParameters: {'page': page},
      );

      if (type.status == TypeListMovie.MOVIE_POPULAR ||
          type.status == TypeListMovie.MOVIE_TOPRATED) {
        return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
      } else {
        return response.data['results']
          .map<TvModel>((data) => TvModel.fromJson(data))
          .toList();
      }
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  String endpointFiltered(MovieListType type) {
    switch (type.status) {
      case TypeListMovie.MOVIE_POPULAR:
        return NetworkEndpoints.popularMovies;
      case TypeListMovie.MOVIE_TOPRATED:
        return NetworkEndpoints.topRatedMovies;
      case TypeListMovie.TV_TOPRATED:
        return NetworkEndpoints.topRatedTv;
      case TypeListMovie.TV_POPULAR:
        return NetworkEndpoints.popularTv;
      default:
        return '';
    }
  }
}
