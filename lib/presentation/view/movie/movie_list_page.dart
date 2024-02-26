import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';
import 'package:movieapp/presentation/utils/widgets/movies/custom_width_poster_slider.dart';
import 'package:movieapp/presentation/utils/widgets/movies/horizontal_listview_movies.dart';
import 'package:movieapp/presentation/view/movie/bloc/movie_bloc.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    MovieBloc movieBLoc = context.read<MovieBloc>();

    movieBLoc.fetchUpcoming();
    movieBLoc.fetchPopular(1);
    movieBLoc.fetchTopRated(1);
    movieBLoc.fetchTvPopular(1);
    movieBLoc.fetchTvTopRated(1);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state.popularMovieList.isNotEmpty &&
                  state.topRatedMovieList.isNotEmpty &&
                  state.popularTVList.isNotEmpty &&
                  state.topRatedTVList.isNotEmpty &&
                  state.upcomingList.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomWidthPosterSlider(movieList: state.upcomingList),
                      const SizedBox(height: AppDimens.mediumMargin),
                      HorizontalListViewMovies(
                          list: state.popularMovieList,
                          title: 'Películas populares',
                          listType:
                              MovieListType(status: TypeListMovie.MOVIE_POPULAR)),
                      HorizontalListViewMovies(
                        list: state.topRatedMovieList,
                        title: 'Películas Mejor valoradas',
                        listType:
                            MovieListType(status: TypeListMovie.MOVIE_TOPRATED),
                      ),
                      HorizontalListViewMovies(
                        list: state.topRatedTVList,
                        title: 'Series Mejor valoradas',
                        listType:
                            MovieListType(status: TypeListMovie.TV_TOPRATED),
                      ),
                      HorizontalListViewMovies(
                        list: state.popularTVList,
                        title: 'Popular',
                        listType: MovieListType(status: TypeListMovie.TV_POPULAR),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
