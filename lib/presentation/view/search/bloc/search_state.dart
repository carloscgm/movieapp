part of 'search_bloc.dart';

class SearchBlocState extends Equatable {
  final List<String> lastSearches;
  final int lastPageSearched;
  final List<MovieModel> searchResult;
  final String query;
  const SearchBlocState(
      {this.searchResult = const [],
      this.lastSearches = const [],
      this.lastPageSearched = 0,
      this.query = ''});

  SearchBlocState copyWith(
          {int? lastPageSearched,
          List<MovieModel>? searchResult,
          List<String>? lastSearches,
          String? query}) =>
      SearchBlocState(
        lastPageSearched: lastPageSearched ?? this.lastPageSearched,
        searchResult: searchResult ?? this.searchResult,
        query: query ?? this.query,
        lastSearches: lastSearches ?? this.lastSearches,
      );

  @override
  List<Object> get props => [lastPageSearched, query, searchResult, lastSearches];
}
