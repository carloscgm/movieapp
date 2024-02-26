part of 'search_bloc.dart';

abstract class SearchBlocEvent {}

class SearchByQuery extends SearchBlocEvent {
  final String queryName;
  final int page;

  SearchByQuery({required this.queryName, this.page = 1});
}

class CleanSearch extends SearchBlocEvent {
  CleanSearch();
}
