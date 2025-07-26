import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// Free Locations Header Component
class FreeLocationsHeader extends StatelessWidget {
  const FreeLocationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.freeLocationsLabel, style: AppTextStyles.freeLocationsLabelStyle),
        SizedBox(
          height: AppDimensions.smallIconSize,
          width: AppDimensions.smallIconSize,
          child: Image.asset(AppAssets.infoCircleIcon),
        ),
      ],
    );
  }
}
