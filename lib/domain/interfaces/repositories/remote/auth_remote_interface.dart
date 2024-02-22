abstract interface class AuthRemoteInterface {
  Future<void> login(String user, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}
