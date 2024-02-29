import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';

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
            urlImage.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: urlImage,
                    fit: BoxFit.fill,
                  )
                : Container(
                    color: Colors.grey[200],
                  ),
            Container(
              width: double.infinity,
              height: double.infinity,
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
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
