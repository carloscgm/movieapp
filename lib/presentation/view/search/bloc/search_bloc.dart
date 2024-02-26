import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/interfaces/usecases/search_use_case_interface.dart';
import 'package:movieapp/domain/models/movie_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final SearchUseCaseInterface searchUseCase;

  SearchBloc(this.searchUseCase) : super(const SearchBlocState()) {
    on<SearchByQuery>((event, emit) async {
      if (state.query != event.queryName) {
        List<MovieModel> listResult =
            await searchUseCase.searchByQuery(event.queryName, 1);
        emit(state.copyWith(
          searchResult: listResult,
            lastPageSearched: 1,
            query: event.queryName
        ));
      } else {
        if (state.lastPageSearched < event.page) {
          List<MovieModel> listResult =
              await searchUseCase.searchByQuery(event.queryName, event.page);
          if (event.page >= 2) {
            List<MovieModel> newList = state.searchResult + listResult;
            emit(state.copyWith(
                searchResult: newList,
                lastPageSearched: event.page,
                query: event.queryName));
          } else {
            emit(state.copyWith(
                searchResult: listResult,
                lastPageSearched: 1,
                query: event.queryName));
          }
        }
      }
    });
    on<CleanSearch>((event, emit) async {
      emit(state.copyWith(
          searchResult: [], lastPageSearched: 0, query: ''));
    });
    on<AddSearched>((event, emit) async {
      List<String> currentSearches = state.lastSearches;
      currentSearches.add(event.searched);
      emit(state.copyWith(lastSearches: currentSearches));
    });
  }

  void searchNextPage(String query, int newPage) {
    add(SearchByQuery(queryName: query, page: newPage));
  }

  void clean() {
    add(CleanSearch());
  }

  void addNewSearched(String search) {
    add(AddSearched(searched: search));
  }
}
