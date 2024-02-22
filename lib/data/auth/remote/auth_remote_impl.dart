import 'package:movieapp/data/remote/credentials_wallet.dart';
import 'package:movieapp/data/remote/error/remote_error_mapper.dart';
import 'package:movieapp/data/remote/http_client.dart';
import 'package:movieapp/data/remote/network_endpoints.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/auth_remote_interface.dart';

class AuthRemoteImpl implements AuthRemoteInterface {
  final HttpClient _httpClient;
  AuthRemoteImpl(this._httpClient);

  @override
  Future<void> login(String user, String password) async {
    try {
      dynamic response = await _httpClient.dio.post(
        NetworkEndpoints.loginUrl,
        data: {'user': user, 'password': password},
      );

      await CredentialsWallet.saveAll(response.data);
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final refreshToken = await CredentialsWallet.getRefreshToken();
    return !refreshToken.isEmpty;
  }

  @override
  Future<void> signOut() async {
    CredentialsWallet.clearAll();
  }
}
