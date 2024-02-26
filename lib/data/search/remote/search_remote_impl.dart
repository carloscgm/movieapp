import 'package:movieapp/data/remote/error/remote_error_mapper.dart';
import 'package:movieapp/data/remote/http_client.dart';
import 'package:movieapp/data/remote/network_endpoints.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/search_remote_interface.dart';
import 'package:movieapp/domain/models/movie_model.dart';

class SearchRemoteImpl implements SearchRemoteInterface {
  final HttpClient _httpClient;
  SearchRemoteImpl(this._httpClient);

  @override
  Future<List<MovieModel>> searchByQuery(String query, int page) async {
    try {
      dynamic response = await _httpClient.dio.get(
        NetworkEndpoints.search,
        queryParameters: {'query': query, 'page': page},
      );

      return response.data['results']
          .map<MovieModel>((data) => MovieModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
