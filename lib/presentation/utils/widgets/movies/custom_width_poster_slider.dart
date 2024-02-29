import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/presentation/common/localization/app_localizations.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:movieapp/presentation/utils/constants/app_colors.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomWidthPosterSlider extends StatelessWidget {
  final List<MovieModel> movieList;

  const CustomWidthPosterSlider({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
    final responsive = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
              left: AppDimens.mediumMargin, top: AppDimens.mediumMargin),
          child: Text(
            AppLocalizations.of(context)!.upcoming,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: responsive.width / 2.1,
          width: responsive.width,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: movieList.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.push(NavigationRoutes.movieDetailRoute, extra: {
                    'id': movieList[index].id,
                    'posterPath': movieList[index].posterPath,
                    'title': movieList[index].title,
                    'backdropPath': movieList[index].backdropPath,
                    'heroMode': false,
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: AppStyles.getDecorationPoster(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: 'backdrop-${movieList[index].id}',
                          child: CachedNetworkImage(
                            imageUrl: movieList[index].backdropPath,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8, left: 12),
                          alignment: Alignment.bottomLeft,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [
                                0.001,
                                0.20
                              ],
                                  colors: [
                                Colors.black87,
                                Colors.transparent
                              ])),
                          child: Text(
                            movieList[index].title,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppDimens.extraSmallMargin),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 15,
          ),
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: pageController,
            count: movieList.length,
            effect: ScrollingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: AppColors.getDotColor(context),
                activeDotColor: AppColors.getActiveDotColor(context)),
          ),
        ),
      ],
    );
  }
}
