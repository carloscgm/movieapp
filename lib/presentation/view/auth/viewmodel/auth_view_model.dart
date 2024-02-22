import 'dart:async';

import 'package:movieapp/domain/interfaces/usecases/auth_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/auth_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_action.dart';
import 'package:movieapp/presentation/view/auth/viewmodel/auth_error_builder.dart';

class AuthViewModelImpl implements AuthViewModelInterface {
  @override
  final AuthUseCaseInterface authUseCase;

  @override
  StreamController<ResourceState> loginState =
      StreamController<ResourceState>();

  @override
  StreamController<bool> signOutState = StreamController<bool>();

  @override
  StreamController<bool> authenticatedState = StreamController<bool>();

  AuthViewModelImpl(this.authUseCase);

  @override
  Future<void> login(String user, String password) async {
    loginState.add(ResourceState.loading());

    authUseCase
        .login(user, password)
        .then((value) => loginState.add(ResourceState.completed(null)))
        .catchError((e) {
      loginState.add(ResourceState.error(
          AuthErrorBuilder.create(e, AppAction.SIGN_IN).build()));
    });
  }

  @override
  Future<void> isAuthenticated() async {
    authUseCase
        .isAuthenticated()
        .then((value) => authenticatedState.add(value))
        .onError((error, stackTrace) => authenticatedState.add(false));
  }

  @override
  Future<void> signOut() async {
    authUseCase
        .signOut()
        .then((value) => signOutState.add(true))
        .onError((error, stackTrace) => signOutState.add(false));
  }

  @override
  void dispose() {
    loginState.close();
    authenticatedState.close();
  }
}
