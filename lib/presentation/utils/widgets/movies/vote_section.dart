import 'package:flutter/material.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';

class VoteSection extends StatelessWidget {
  final double voteAverage;
  final int voteCount;
  final String text;

  const VoteSection({
    super.key,
    required this.voteAverage,
    required this.voteCount,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: AppDimens.mediumMargin),
          height: 40,
          width: 40,
          decoration: AppStyles.getDecorationPoster()
              .copyWith(color: const Color(0xffefefef)),
          child: Icon(
            Icons.star_rate_rounded,
            size: 30,
            color: Colors.yellow[700],
          ),
        ),
        const SizedBox(width: AppDimens.smallMargin),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rightSintax(voteAverage.toString()),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              children: [
                Text(
                  voteCount.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.people_alt,
                  size: 15,
                )
              ],
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: AppDimens.bigMargin),
          height: 40,
          width: 40,
          decoration: AppStyles.getDecorationPoster()
              .copyWith(color: const Color(0xffefefef)),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.grey,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: AppDimens.mediumMargin),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
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
