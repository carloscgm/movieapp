import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';

class CustomPosterMovie extends StatelessWidget {
  final int id;
  final String posterPath;
  final String backdropPath;
  final String title;
  final double margen;
  final String vote;
  final MovieListType typeItem;
  const CustomPosterMovie(
      {super.key,
      required this.posterPath,
      this.margen = 0,
      this.vote = '',
      required this.id,
      required this.typeItem,
      required this.backdropPath,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (typeItem.status == TypeListMovie.TV_POPULAR ||
            typeItem.status == TypeListMovie.TV_TOPRATED) {
          context.push(NavigationRoutes.tvDetailRoute, extra: {
            'id': id,
            'posterPath': posterPath,
            'title': title,
            'backdropPath': backdropPath,
          });
        } else {
          context.push(NavigationRoutes.movieDetailRoute, extra: {
            'id': id,
            'posterPath': posterPath,
            'title': title,
            'backdropPath': backdropPath,
          });
        }
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(margen),
            decoration: AppStyles.getDecorationPoster(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  height: responsive.width * 0.3 * 1.5,
                  width: responsive.width * 0.27,
                  fit: BoxFit.fill,
                  imageUrl: posterPath),
            ),
          ),
          Positioned(
            top: 5,
            right: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  rightSintax(vote),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String rightSintax(String noSyntax) {
    if (noSyntax.contains('.')) {
      return noSyntax.substring(0, noSyntax.indexOf('.') + 2);
    } else {
      return '$noSyntax.0';
    }
  }
}
