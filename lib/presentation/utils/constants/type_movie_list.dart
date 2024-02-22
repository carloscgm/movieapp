enum TypeListMovie {
  MOVIE_NOWPLAYING,
  MOVIE_POPULAR,
  MOVIE_TOPRATED,
  MOVIE_UPCOMING,
  TV_POPULAR,
  TV_TOPRATED
}

class MovieListType {
  final TypeListMovie status;

  MovieListType({required this.status});
}
