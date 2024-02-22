import 'dart:async';

import 'package:movieapp/domain/interfaces/usecases/auth_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/base_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';

abstract interface class AuthViewModelInterface implements BaseViewModel {
  final AuthUseCaseInterface authUseCase;
  StreamController<ResourceState> loginState;
  StreamController<bool> signOutState;
  StreamController<bool> authenticatedState;

  AuthViewModelInterface({
    required this.authUseCase,
    required this.loginState,
    required this.signOutState,
    required this.authenticatedState,
  });

  Future<void> login(String user, String password);
  Future<void> isAuthenticated();
  Future<void> signOut();
}
