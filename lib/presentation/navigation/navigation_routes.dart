import 'package:flutter/widgets.dart';
import 'package:movieapp/presentation/view/about/about_page.dart';
import 'package:movieapp/presentation/view/auth/login_page.dart';
import 'package:movieapp/presentation/view/home/home_page.dart';
import 'package:movieapp/presentation/view/movie/fullscreen_movie_list_page.dart';
import 'package:movieapp/presentation/view/movie/movie_details_page.dart';
import 'package:movieapp/presentation/view/movie/movie_list_page.dart';
import 'package:movieapp/presentation/view/movie/tv_details_page.dart';
import 'package:movieapp/presentation/view/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

typedef GKey = GlobalKey<NavigatorState>;

abstract interface class NavigationRoutes {
  // Route paths (for subroutes) - private access
  static const String detailPath = 'details';
  static const String detailTvPath = 'tvDetails';
  static const String fullscreenPath = 'fullscreen';

  // Route names
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String movieRoute = '/movies';
  static const String movieFullScreenRoute = '$movieRoute/$fullscreenPath';
  static const String DetailmovieFullScreenRoute =
      '$movieFullScreenRoute/$detailPath';
  static const String DetailTvFullScreenRoute =
      '$movieFullScreenRoute/$detailTvPath';
  static const String movieDetailRoute = '$movieRoute/$detailPath';
  static const String tvDetailRoute = '$movieRoute/$detailTvPath';
  static const String aboutRoute = '/about';
}

// Nav keys
final GKey _rootNavigatorKey = GKey();
final GKey _movieNavigatorKey = GKey();
final GKey _aboutNavigatorKey = GKey();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoutes.initialRoute,
    routes: [
      // Routes
      initialRoute(),
      homePageRoute(),
      loginPageRoute(),
    ]);

GoRoute loginPageRoute() => GoRoute(
      path: NavigationRoutes.loginRoute,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginPage(),
    );

StatefulShellRoute homePageRoute() => StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => HomePage(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _movieNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationRoutes.movieRoute,
              parentNavigatorKey: _movieNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MovieListPage(),
              ),
              routes: [
                GoRoute(
                    path: NavigationRoutes.fullscreenPath,
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>;
                      return FullScreenMovieListPage(
                        listType: extra['listType'],
                        list: extra['list'],
                      );
                    },
                    routes: [
                      GoRoute(
                        path: NavigationRoutes.detailPath,
                        builder: (context, state) {
                          final extra = state.extra as Map<String, dynamic>;
                          return MovieDetailsPage(
                            idMovie: extra['idMovie'],
                            title: extra['title'],
                            backdropPath: extra['backdropPath'],
                            posterPath: extra['posterPath'],
                          );
                        },
                      ),
                      GoRoute(
                        path: NavigationRoutes.detailTvPath,
                        builder: (context, state) {
                          final extra = state.extra as Map<String, dynamic>;
                          return TvDetailsPage(
                            id: extra['id'],
                            title: extra['title'],
                            backdropPath: extra['backdropPath'],
                            posterPath: extra['posterPath'],
                          );
                        },
                      ),
                    ]),
                GoRoute(
                  path: NavigationRoutes.detailPath,
                  builder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>;
                    return MovieDetailsPage(
                      idMovie: extra['id'],
                      title: extra['title'],
                      backdropPath: extra['backdropPath'],
                      posterPath: extra['posterPath'],
                    );
                  },
                ),
                GoRoute(
                  path: NavigationRoutes.detailTvPath,
                  builder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>;
                    return TvDetailsPage(
                      id: extra['id'],
                      title: extra['title'],
                      backdropPath: extra['backdropPath'],
                      posterPath: extra['posterPath'],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _aboutNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationRoutes.aboutRoute,
              parentNavigatorKey: _aboutNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AboutPage(),
              ),
            ),
          ],
        )
      ],
    );

GoRoute initialRoute() => GoRoute(
      path: NavigationRoutes.initialRoute,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SplashPage(),
    );
