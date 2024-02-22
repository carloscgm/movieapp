import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/domain/interfaces/view_models/movie_view_model_interface.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/domain/models/tv_model.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/utils/widgets/error/error_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/movies/custom_width_poster_slider.dart';
import 'package:movieapp/presentation/utils/widgets/movies/horizontal_listview_movies.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin {
  final _movieViewModel = inject<MovieViewModelInterface>();
  List<MovieModel> _upcomingMovieList = List.empty();
  List<MovieModel> _topRatedMovieList = List.empty();
  List<MovieModel> _popularMovieList = List.empty();
  List<TvModel> _popularTvList = List.empty();
  List<TvModel> _topratedTvList = List.empty();
  int dataRequest = 5;

  @override
  void initState() {
    super.initState();

    setUpStreamTopRated();
    setUpStreamUpcoming();
    setUpStreamPopular();
    setUpStreamTVPopular();
    setUpStreamTVTopRated();

    _movieViewModel.fetchUpcoming();
    _movieViewModel.fetchPopular();
    _movieViewModel.fetchTopRated();
    _movieViewModel.fetchTvPopular(1);
    _movieViewModel.fetchTvTopRated(1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomWidthPosterSlider(movieList: _upcomingMovieList),
              const SizedBox(height: AppDimens.mediumMargin),
              HorizontalListViewMovies(
                list: _popularMovieList,
                title: 'Películas populares',
                listType: MovieListType(status: TypeListMovie.MOVIE_POPULAR),
              ),
              HorizontalListViewMovies(
                list: _topRatedMovieList,
                title: 'Películas Mejor valoradas',
                listType: MovieListType(status: TypeListMovie.MOVIE_TOPRATED),
              ),
              HorizontalListViewMovies(
                list: _topratedTvList,
                title: 'Series Mejor valoradas',
                listType: MovieListType(status: TypeListMovie.TV_TOPRATED),
              ),
              HorizontalListViewMovies(
                list: _popularTvList,
                title: 'Popular',
                listType: MovieListType(status: TypeListMovie.TV_POPULAR),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _movieViewModel.dispose(); // Avoid memory leaks
  }

  @override
  bool get wantKeepAlive => true;

  void setUpStreamTopRated() {
    _movieViewModel.movieTopRatedListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          _topRatedMovieList = state.data;
          dataRequest--;
          if (dataRequest == 0) {
            LoadingOverlay.hide();
            setState(() {});
          }
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTopRated();
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
  }

  void setUpStreamUpcoming() {
    _movieViewModel.movieUpcomingListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          _upcomingMovieList = state.data;
          dataRequest--;
          if (dataRequest == 0) {
            LoadingOverlay.hide();
            setState(() {});
          }
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTopRated();
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
  }

  void setUpStreamPopular() {
    _movieViewModel.moviePopularListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          _popularMovieList = state.data;
          dataRequest--;
          if (dataRequest == 0) {
            LoadingOverlay.hide();
            setState(() {});
          }
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTopRated();
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
  }

  void setUpStreamTVPopular() {
    _movieViewModel.tvPopularListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          _popularTvList = state.data;
          dataRequest--;
          if (dataRequest == 0) {
            LoadingOverlay.hide();
            setState(() {});
          }
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTvPopular(1);
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
  }

  void setUpStreamTVTopRated() {
    _movieViewModel.tvTopRatedListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          _topratedTvList = state.data;
          dataRequest--;
          if (dataRequest == 0) {
            LoadingOverlay.hide();
            setState(() {});
          }
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTvTopRated(1);
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
  }
}
