part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<MovieModel> upcomingList;
  final List<MovieModel> popularMovieList;
  final List<MovieModel> topRatedMovieList;
  final List<TvModel> topRatedTVList;
  final List<TvModel> popularTVList;
  final TvDetailModel? tvDetails;
  final MovieDetailModel? movieDetails;
  final TvDetailCastingModel? detailsCasting;
  final MovieDetailCastingModel? movieDetailCasting;
  final List<PostableItem> nextList;
  const MovieState({
    this.upcomingList = const [],
    this.popularMovieList = const [],
    this.topRatedMovieList = const [],
    this.topRatedTVList = const [],
    this.popularTVList = const [],
    this.nextList = const [],
    this.tvDetails,
    this.movieDetails,
    this.detailsCasting,
    this.movieDetailCasting,
  });

  @override
  List<Object?> get props => [
        upcomingList,
        popularMovieList,
        topRatedMovieList,
        topRatedTVList,
        popularTVList,
        tvDetails,
        movieDetails,
        detailsCasting,
        nextList,
        movieDetailCasting,
      ];

  MovieState copyWith({
    List<MovieModel>? upcomingList,
    List<MovieModel>? popularMovieList,
    List<MovieModel>? topRatedMovieList,
    List<TvModel>? topRatedTVList,
    List<TvModel>? popularTVList,
    List<PostableItem>? nextList,
    TvDetailModel? tvDetails,
    MovieDetailModel? movieDetails,
    TvDetailCastingModel? detailsCasting,
    MovieDetailCastingModel? movieDetailCasting,
  }) =>
      MovieState(
        upcomingList: upcomingList ?? this.upcomingList,
        popularMovieList: popularMovieList ?? this.popularMovieList,
        topRatedMovieList: topRatedMovieList ?? this.topRatedMovieList,
        topRatedTVList: topRatedTVList ?? this.topRatedTVList,
        popularTVList: popularTVList ?? this.popularTVList,
        tvDetails: tvDetails ?? this.tvDetails,
        movieDetails: movieDetails ?? this.movieDetails,
        detailsCasting: detailsCasting ?? this.detailsCasting,
        nextList: nextList ?? this.nextList,
        movieDetailCasting: movieDetailCasting ?? this.movieDetailCasting,
      );
}
