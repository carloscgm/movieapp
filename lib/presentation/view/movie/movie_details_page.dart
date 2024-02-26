import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/models/movie_detail_model.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_scaffold_hero.dart';
import 'package:movieapp/presentation/utils/widgets/movies/carrusel_title_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/title_chip_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/vote_section.dart';
import 'package:movieapp/presentation/view/movie/bloc/movie_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().fetchMovieDetail(widget.idMovie);
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.movieDetails != null && widget.idMovie == state.movieDetails!.id) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CarruselAndTitle(
                      id: state.movieDetails!.id,
                      title: state.movieDetails!.title,
                      backdropPath: state.movieDetails!.backdropPath,
                      posterPath: state.movieDetails!.posterPath,
                      releaseDate: state.movieDetails!.releaseDate),
                  const SizedBox(height: AppDimens.mediumMargin),
                  VoteSection(
                    voteAverage: state.movieDetails!.voteAverage,
                    voteCount: state.movieDetails!.voteCount,
                    text: 'Califica esta película',
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                  Description(myMovie: state.movieDetails!),
                  const SizedBox(height: AppDimens.mediumMargin),
                  ChipTitleSection(
                    title: 'Géneros',
                    chipListNames:
                        state.movieDetails!.genres.map((e) => e.name).toList(),
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                  ChipTitleSection(
                    title: 'Productoras',
                    chipListNames: state.movieDetails!.productionCompanies
                        .map((e) => e.name)
                        .toList(),
                  ),
                  const SizedBox(height: AppDimens.mediumMargin),
                ],
              ),
            ),
            floatingActionButton: (state.movieDetails!.homepage.isEmpty)
                ? Container()
                : FloatingActionButton.extended(
                    onPressed: () {
                      _launchURL(state.movieDetails!.homepage);
                    },
                    label: const Row(
                      children: [
                        Icon(Icons.play_circle_outline_outlined),
                        SizedBox(width: 5),
                        Text('Ver película')
                      ],
                    )),
          );
        } else {
          return LoadingScaffoldHero(
              id: widget.idMovie,
              title: widget.title,
              backdropPath: widget.backdropPath,
              posterPath: widget.posterPath);
        }
      },
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
      width: double.infinity,
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
            _myMovie.overview.isEmpty
                ? 'Sin descripción disponible'
                : _myMovie.overview,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
