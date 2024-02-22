import 'package:movieapp/domain/interfaces/repositories/auth_repository_interface.dart';
import 'package:movieapp/domain/interfaces/usecases/auth_use_case_interface.dart';

class AuthUseCaseImpl implements AuthUseCaseInterface {
  final AuthRepositoryInterface authRepository;

  AuthUseCaseImpl(this.authRepository);

  @override
  Future<bool> isAuthenticated() async {
    return await authRepository.isAuthenticated();
  }

  @override
  Future<void> login(String user, String password) async {
    return await authRepository.login(user, password);
  }

  @override
  Future<void> signOut() async {
    return await authRepository.signOut();
  }
}
