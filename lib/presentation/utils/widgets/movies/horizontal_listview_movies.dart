import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';
import 'package:movieapp/presentation/utils/widgets/movies/custom_poster_movie.dart';

class HorizontalListViewMovies extends StatelessWidget {
  final List<PostableItem> list;
  final MovieListType listType;
  final String title;

  const HorizontalListViewMovies({
    super.key,
    required this.list,
    required this.title,
    required this.listType,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimens.mediumMargin,
            ),
            child: Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      context.push(NavigationRoutes.movieFullScreenRoute,
                          extra: {'listType': listType, 'list': list});
                    },
                    icon: const Icon(Icons.list_outlined))
              ],
            ),
          ),
          SizedBox(
            height: responsive.height * 0.28,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: (index == 0)
                      ? const EdgeInsets.only(
                          left: AppDimens.mediumMargin, right: 5)
                      : const EdgeInsets.symmetric(horizontal: 5),
                  width: responsive.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeroMode(
                        enabled: list[index].backdropPath.isNotEmpty,
                        child: Hero(
                          tag: 'poster-${list[index].id}',
                          child: CustomPosterMovie(
                            title: list[index].title,
                            backdropPath: list[index].backdropPath,
                            id: list[index].id,
                            vote: list[index].voteAverage.toString(),
                            posterPath: list[index].posterPath,
                            typeItem: listType,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(list[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
