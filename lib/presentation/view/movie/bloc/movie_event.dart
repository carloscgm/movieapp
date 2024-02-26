part of 'movie_bloc.dart';

class MovieEvent {}

class FetchPopular extends MovieEvent {
  final int page;

  FetchPopular({required this.page});
}

class FetchTopRated extends MovieEvent {
  final int page;

  FetchTopRated({required this.page});
}

class FetchUpcoming extends MovieEvent {}

class FetchMovieDetail extends MovieEvent {
  final int id;

  FetchMovieDetail({required this.id});
}

class FetchTvPopular extends MovieEvent {
  final int page;

  FetchTvPopular({required this.page});
}

class FetchTvTopRated extends MovieEvent {
  final int page;

  FetchTvTopRated({required this.page});
}

class FetchTVDetail extends MovieEvent {
  final int id;

  FetchTVDetail({required this.id});
}

class FetchTVDetailCasting extends MovieEvent {
  final int id;

  FetchTVDetailCasting({required this.id});
}

class FetchNext extends MovieEvent {
  final int id;
  final MovieListType type;

  FetchNext({required this.type, required this.id});
}

class MoveMoviesToNext extends MovieEvent {
  final MovieListType type;

  MoveMoviesToNext({required this.type});
}
