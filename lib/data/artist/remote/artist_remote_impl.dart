import 'package:movieapp/data/remote/error/remote_error_mapper.dart';
import 'package:movieapp/data/remote/http_client.dart';
import 'package:movieapp/data/remote/network_endpoints.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/artist_remote_interface.dart';
import 'package:movieapp/domain/models/artist_model.dart';

class ArtistRemoteImpl implements ArtistRemoteInterface {
  final HttpClient _httpClient;
  ArtistRemoteImpl(this._httpClient);

  @override
  Future<List<ArtistModel>> getArtists() async {
    try {
      dynamic response = await _httpClient.dio.get(NetworkEndpoints.artistsUrl);

      return response.data['items']
          .map<ArtistModel>((data) => ArtistModel.fromJson(data))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
