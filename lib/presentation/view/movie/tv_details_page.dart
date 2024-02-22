import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/domain/interfaces/view_models/movie_view_model_interface.dart';
import 'package:movieapp/domain/models/tv_detail_casting_model.dart';
import 'package:movieapp/domain/models/tv_detail_model.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/utils/widgets/error/error_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_scaffold_hero.dart';
import 'package:movieapp/presentation/utils/widgets/movies/carrusel_title_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/title_chip_section.dart';
import 'package:movieapp/presentation/utils/widgets/movies/vote_section.dart';
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
  final _movieViewModel = inject<MovieViewModelInterface>();
  late TvDetailModel _myTv;
  late TvDetailCastingModel _castingActors;
  bool initLoading = true;
  int requestCount = 2;

  @override
  void initState() {
    super.initState();

    _movieViewModel.tvDetailListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          //LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          requestCount--;
          //LoadingOverlay.hide();
          setState(() {
            _myTv = state.data;
            if (requestCount == 0) {
              initLoading = false;
            }
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTVDetail(widget.id);
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
    _movieViewModel.tvDetailCastingListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          //LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          requestCount--;
          //LoadingOverlay.hide();
          setState(() {
            _castingActors = state.data;
            if (requestCount == 0) {
              initLoading = false;
            }
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _movieViewModel.fetchTVDetailCasting(widget.id);
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
    _movieViewModel.fetchTVDetail(widget.id);
    _movieViewModel.fetchTVDetailCasting(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return initLoading
        ? LoadingScaffoldHero(
            id: widget.id,
            title: widget.title,
            backdropPath: widget.backdropPath,
            posterPath: widget.posterPath,
            heroMode: true,
          )
        : Scaffold(
            body: Column(
              children: [
                CarruselAndTitle(
                  id: _myTv.id,
                  title: _myTv.name,
                  backdropPath: _myTv.backdropPath,
                  posterPath: _myTv.posterPath,
                  releaseDate: _myTv.firstAirDate,
                  heroMode: true,
                ),
                const SizedBox(height: AppDimens.mediumMargin),
                VoteSection(
                  voteAverage: _myTv.voteAverage,
                  voteCount: _myTv.voteCount,
                  text: 'Califica esta serie',
                ),
                const SizedBox(height: AppDimens.mediumMargin),
                Expanded(child: TabSection(_myTv, _castingActors)),
                Container(),
                Container(),
              ],
            ),
            floatingActionButton: (_myTv.homepage.isEmpty)
                ? Container()
                : FloatingActionButton.extended(
                    onPressed: () {
                      _launchURL(_myTv.homepage);
                    },
                    label: const Row(
                      children: [
                        Icon(Icons.play_circle_outline_outlined),
                        SizedBox(width: 5),
                        Text('Ver Serie')
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

class CustomSeasonSelector extends StatelessWidget {
  final String urlImage;
  final String title;
  final String subtitle;
  const CustomSeasonSelector({
    super.key,
    required this.urlImage,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.getDecorationPoster(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: urlImage,
              fit: BoxFit.fill,
            ),
            Container(
              color: Colors.black38.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            )
          ],
        ),
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
              myTv.overview,
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
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 15,
          ),
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
    return Container();
  } else {
    return Container(
      width: responsive.width * 0.25,
      decoration: AppStyles.getDecorationPoster(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(imageUrl: url)),
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
