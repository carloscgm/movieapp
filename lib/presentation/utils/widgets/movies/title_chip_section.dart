import 'package:flutter/material.dart';
import 'package:movieapp/presentation/utils/constants/app_colors.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';

class ChipTitleSection extends StatelessWidget {
  final String title;
  final List<String> chipListNames;
  const ChipTitleSection({
    super.key,
    required this.title,
    required this.chipListNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Wrap(
            children: List.generate(
                chipListNames.length,
                (index) => Container(
                      margin: const EdgeInsets.all(3),
                      child: Chip(
                          backgroundColor:
                              AppColors.getChipBackgroundColor(context),
                          label: Text(
                            chipListNames[index],
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    )).toList(),
          ),
        ],
      ),
    );
  }
}
