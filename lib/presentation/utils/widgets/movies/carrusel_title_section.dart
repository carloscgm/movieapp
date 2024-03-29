import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/presentation/common/localization/app_localizations.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class CarruselAndTitle extends StatelessWidget {
  final int id;
  final String title;
  final String backdropPath;
  final String posterPath;
  final bool loading;
  final DateTime? releaseDate;

  const CarruselAndTitle({
    super.key,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    this.releaseDate,
    required this.id,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            HeroMode(
              enabled: backdropPath.isNotEmpty,
              child: Hero(
                tag: 'backdrop-$id',
                child: backdropPath.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: backdropPath,
                        fit: BoxFit.fill,
                        width: responsive.width,
                        height: responsive.width * 0.56,
                      )
                    : Container(
                        width: responsive.width,
                        height: responsive.width * 0.56,
                        color: Colors.grey[200],
                      ),
              ),
            ),
            loading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    period: const Duration(milliseconds: 500),
                    highlightColor: Colors.grey.shade600,
                    child: Container(
                      color: Colors.black,
                      width: responsive.width,
                      height: 5,
                    ))
                : Container(),
            Container(
              margin: EdgeInsets.only(left: responsive.width * 0.24 + 20),
              child: ListTile(
                title: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(releaseDate != null
                    ? '${AppLocalizations.of(context)!.release_date} ${releaseDate?.day}-${releaseDate?.month}-${releaseDate?.year}'
                    : ''),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        Positioned(
          left: 20,
          bottom: 0,
          child: Container(
            decoration: AppStyles.getDecorationPoster(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: 'poster-$id',
                child: CachedNetworkImage(
                    height: responsive.width * 0.24 * 1.5,
                    width: responsive.width * 0.24,
                    fit: BoxFit.fill,
                    imageUrl: posterPath),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
