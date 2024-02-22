import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/domain/interfaces/view_models/auth_view_model_interface.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authViewModel = inject<AuthViewModelInterface>();

  @override
  void initState() {
    super.initState();

    _authViewModel.authenticatedState.stream.listen((state) {
      switch (state) {
        case true:
          context.go(NavigationRoutes.movieRoute);
          break;
        case false:
          context.go(NavigationRoutes.loginRoute);
          break;
      }
    });

    //_authViewModel.isAuthenticated();
    //context.go(NavigationRoutes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              context.go(NavigationRoutes.movieRoute);
            },
            child: const Text('ir')),
      ), // Empty page
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authViewModel.dispose(); // Avoid memory leaks
  }
}
