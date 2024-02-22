import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/domain/interfaces/view_models/movie_view_model_interface.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/utils/widgets/error/error_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_scaffold_hero.dart';
import 'package:movieapp/presentation/utils/widgets/movies/carrusel_title_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/title_chip_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/vote_section.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsPage extends StatefulWidget {
  final int idMovie;
  final String title;
  final String backdropPath;
  final String posterPath;
  final bool heroMode;
  const MovieDetailsPage(
      {super.key,
      required this.idMovie,
      required this.title,
      required this.backdropPath,
      required this.posterPath,
      this.heroMode = true});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final _movieViewModel = inject<MovieViewModelInterface>();
  late MovieDetailModel _myMovie;
  bool initLoading = true;

  @override
  void initState() {
    super.initState();

    _movieViewModel.movieDetailListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          //LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          //LoadingOverlay.hide();
          setState(() {
            _myMovie = state.data;
            initLoading = false;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchMovieDetail(widget.idMovie);
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
    _movieViewModel.fetchMovieDetail(widget.idMovie);
  }

  @override
  Widget build(BuildContext context) {
    return initLoading
        ? LoadingScaffoldHero(
            id: widget.idMovie,
            title: widget.title,
            backdropPath: widget.backdropPath,
            posterPath: widget.posterPath,
            heroMode: widget.heroMode,
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CarruselAndTitle(
                    id: _myMovie.id,
                    title: _myMovie.title,
                    backdropPath: _myMovie.backdropPath,
                    posterPath: _myMovie.posterPath,
                    releaseDate: _myMovie.releaseDate,
                    heroMode: true,
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                  VoteSection(
                    voteAverage: _myMovie.voteAverage,
                    voteCount: _myMovie.voteCount,
                    text: 'Califica esta película',
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                  Description(myMovie: _myMovie),
                  const SizedBox(height: AppDimens.mediumMargin),
                  ChipTitleSection(
                    title: 'Géneros',
                    chipListNames: _myMovie.genres.map((e) => e.name).toList(),
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                  ChipTitleSection(
                    title: 'Productoras',
                    chipListNames: _myMovie.productionCompanies
                        .map((e) => e.name)
                        .toList(),
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                ],
              ),
            ),
            floatingActionButton: (_myMovie.homepage.isEmpty)
                ? Container()
                : FloatingActionButton.extended(
                    onPressed: () {
                      _launchURL(_myMovie.homepage);
                    },
                    label: const Row(
                      children: [
                        Icon(Icons.play_circle_outline_outlined),
                        SizedBox(width: 5),
                        Text('Ver película')
                      ],
                    )),
          );
  }

  _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required MovieDetailModel myMovie,
  }) : _myMovie = myMovie;

  final MovieDetailModel _myMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descripción',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Text(
            _myMovie.overview,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
