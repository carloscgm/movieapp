import 'dart:async';

import 'package:movieapp/domain/interfaces/usecases/artist_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/base_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';

abstract interface class ArtistViewModelInterface implements BaseViewModel {
  final ArtistUseCaseInterface artistUseCase;
  final StreamController<ResourceState> artistListState;

  ArtistViewModelInterface({
    required this.artistUseCase,
    required this.artistListState,
  });

  Future<void> fetchArtists();
}
