part of 'search_bloc_bloc.dart';

class SearchBlocState extends Equatable {
  final int lastPageSearched;
  final List<MovieModel> searchResult;
  final String query;
  const SearchBlocState(
      {this.searchResult = const [],
      this.lastPageSearched = 0,
      this.query = ''});

  SearchBlocState copyWith(
          {int? lastPageSearched,
          List<MovieModel>? searchResult,
          String? query}) =>
      SearchBlocState(
        lastPageSearched: lastPageSearched ?? this.lastPageSearched,
        searchResult: searchResult ?? this.searchResult,
        query: query ?? this.query,
      );

  @override
  List<Object> get props => [lastPageSearched, query, searchResult];
}
