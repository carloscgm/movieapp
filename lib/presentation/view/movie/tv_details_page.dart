import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_scaffold_hero.dart';
import 'package:movieapp/presentation/utils/widgets/movies/carrusel_title_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/rounded_image_item.dart';
import 'package:movieapp/presentation/utils/widgets/movies/title_chip_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/vote_section.dart';
import 'package:movieapp/presentation/view/movie/bloc/movie_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class TvDetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final String backdropPath;
  final String posterPath;
  const TvDetailsPage(
      {super.key,
      required this.id,
      required this.title,
      required this.backdropPath,
      required this.posterPath});

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {
  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().fetchTVDetail(widget.id);
    context.read<MovieBloc>().fetchTVDetailCasting(widget.id);

    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      if (state.tvDetails != null &&
          widget.id == state.tvDetails!.id &&
          state.detailsCasting != null &&
          state.detailsCasting!.id == widget.id) {
        return Scaffold(
          body: Column(
            children: [
              CarruselAndTitle(
                  loading: false,
                  id: state.tvDetails!.id,
                  title: state.tvDetails!.name,
                  backdropPath: state.tvDetails!.backdropPath,
                  posterPath: state.tvDetails!.posterPath,
                  releaseDate: state.tvDetails!.firstAirDate),
              const SizedBox(height: AppDimens.mediumMargin),
              VoteSection(
                voteAverage: state.tvDetails!.voteAverage,
                voteCount: state.tvDetails!.voteCount,
                text: 'Califica esta serie',
              ),
              const SizedBox(height: AppDimens.mediumMargin),
              Expanded(
                  child: TabSection(state.tvDetails!, state.detailsCasting!)),
            ],
          ),
          floatingActionButton: (state.tvDetails!.homepage.isEmpty)
              ? Container()
              : FloatingActionButton.extended(
                  onPressed: () {
                    _launchURL(state.tvDetails!.homepage);
                  },
                  label: const Row(
                    children: [
                      Icon(Icons.play_circle_outline_outlined),
                      SizedBox(width: 5),
                      Text('Ver Serie')
                    ],
                  )),
        );
      } else {
        return LoadingScaffoldHero(
            id: widget.id,
            title: widget.title,
            backdropPath: widget.backdropPath,
            posterPath: widget.posterPath);
      }
    });
  }

  _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class TabSection extends StatelessWidget {
  final TvDetailModel _myTv;
  final TvDetailCastingModel casting;
  const TabSection(this._myTv, this.casting, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                  child: Text(
                'Acerca de',
                maxLines: 1,
              )),
              Tab(
                  child: Text(
                'Temporadas',
                maxLines: 1,
              )),
              Tab(
                  child: Text(
                'Reparto',
                maxLines: 1,
              )),
            ]),
            Expanded(
              child: TabBarView(children: [
                _FirstSection(myTv: _myTv),
                _SecondSection(myTv: _myTv),
                _ThirdSection(casting: casting),
              ]),
            ),
          ],
        ));
  }
}

class _ThirdSection extends StatelessWidget {
  final TvDetailCastingModel casting;
  const _ThirdSection({
    required this.casting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.66),
        itemCount: casting.cast.length,
        itemBuilder: (context, index) {
          return CustomSeasonSelector(
            urlImage: casting.cast[index].profilePath!,
            title: casting.cast[index].name,
            subtitle: casting.cast[index].roles![0].character,
          );
        },
      ),
    );
  }
}

class _SecondSection extends StatelessWidget {
  final TvDetailModel myTv;
  const _SecondSection({
    required this.myTv,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.66),
        itemCount: myTv.seasons.length,
        itemBuilder: (context, index) {
          return CustomSeasonSelector(
            urlImage: myTv.seasons[index].posterPath!,
            title: myTv.seasons[index].name,
            subtitle: 'Episodios: ${myTv.seasons[index].episodeCount}',
          );
        },
      ),
    );
  }
}

class _FirstSection extends StatelessWidget {
  final TvDetailModel myTv;
  const _FirstSection({
    required this.myTv,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(AppDimens.mediumMargin),
            child: Text(
              myTv.overview.isNotEmpty
                  ? myTv.overview
                  : 'Sin descripción disponible',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ChipTitleSection(
            title: 'Géneros',
            chipListNames: myTv.genres.map((e) => e.name).toList(),
          ),
          const SizedBox(height: AppDimens.smallMargin),
          ChipTitleSection(
            title: 'Redes',
            chipListNames: myTv.networks.map((e) => e.name).toList(),
          ),
          const SizedBox(height: AppDimens.smallMargin),
          chapterSection(
            context,
            'Último episodio',
            myTv.lastEpisodeToAir.name,
            '${myTv.lastEpisodeToAir.seasonNumber}x${myTv.lastEpisodeToAir.episodeNumber}',
            '${myTv.lastEpisodeToAir.airDate.day}-${myTv.lastEpisodeToAir.airDate.month}-${myTv.lastEpisodeToAir.airDate.year}',
            imageBackdropStyle(myTv.lastEpisodeToAir.stillPath!, context),
          ),
          const SizedBox(height: AppDimens.mediumMargin),
        ],
      ),
    );
  }

  Widget chapterSection(BuildContext context, String texto, String title,
      String seasonEpisode, String date, Widget leadingWidget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: AppDimens.mediumMargin),
          child: Text(
            texto,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ListTile(
          leading: leadingWidget,
          title: Text(title, style: Theme.of(context).textTheme.bodySmall),
          subtitle: Text('$seasonEpisode · $date'),
        ),
      ],
    );
  }
}

Widget imageBackdropStyle(String url, BuildContext context) {
  final responsive = MediaQuery.of(context).size;
  if (url.isEmpty) {
    return const SizedBox(width: 0, height: 0);
  } else {
    return Container(
      width: responsive.width * 0.25,
      decoration: AppStyles.getDecorationPoster(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fill,
          )),
    );
  }
}

Widget imagePostertyle(String url, BuildContext context) {
  final responsive = MediaQuery.of(context).size;
  if (url.isEmpty) {
    return Container();
  } else {
    return Container(
      width: responsive.width * 0.25,
      height: responsive.width * 0.50 * 1.5,
      decoration: AppStyles.getDecorationPoster(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(imageUrl: url)),
    );
  }
}
