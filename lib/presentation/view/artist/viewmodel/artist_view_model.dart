import 'dart:async';
import 'package:movieapp/domain/interfaces/usecases/artist_use_case_interface.dart';
import 'package:movieapp/domain/interfaces/view_models/artist_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_action.dart';
import 'package:movieapp/presentation/view/artist/viewmodel/artist_error_builder.dart';

class ArtistViewModelImpl implements ArtistViewModelInterface {
  @override
  final ArtistUseCaseInterface artistUseCase;

  @override
  StreamController<ResourceState> artistListState =
      StreamController<ResourceState>();

  ArtistViewModelImpl(this.artistUseCase);

  @override
  Future<void> fetchArtists() async {
    artistListState.add(ResourceState.loading());

    artistUseCase
        .getArtists()
        .then((value) => artistListState.add(ResourceState.completed(value)))
        .catchError((e) {
      artistListState.add(ResourceState.error(
          ArtistErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }

  @override
  void dispose() {
    artistListState.close();
  }
}
