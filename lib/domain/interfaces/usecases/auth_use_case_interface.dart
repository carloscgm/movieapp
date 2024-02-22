abstract interface class AuthUseCaseInterface {
  Future<void> login(String user, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}
