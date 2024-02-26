import 'dart:async';

import 'package:movieapp/domain/interfaces/usecases/search_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/base_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';

abstract interface class SearchViewModelInterface implements BaseViewModel {
  final SearchUseCaseInterface searchUseCase;
  final StreamController<ResourceState> searchByQueryListState;

  SearchViewModelInterface({
    required this.searchUseCase,
    required this.searchByQueryListState,
  });

  Future<void> searchByQuery(String query);
}
