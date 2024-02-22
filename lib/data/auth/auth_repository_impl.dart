import 'package:movieapp/domain/interfaces/repositories/auth_repository_interface.dart';
import 'package:movieapp/domain/interfaces/repositories/remote/auth_remote_interface.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthRemoteInterface _remote;
  AuthRepositoryImpl(this._remote);

  @override
  Future<void> login(String user, String password) {
    return _remote.login(user, password);
  }

  @override
  Future<bool> isAuthenticated() {
    return _remote.isAuthenticated();
  }

  @override
  Future<void> signOut() {
    return _remote.signOut();
  }
}
