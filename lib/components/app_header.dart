import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import 'search_box.dart';
import '../views/country_selection_page.dart';

/// App Header Component
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppDimensions.largeRadius)),
      child: Container(
        height: AppDimensions.appBarHeight,
        color: AppColors.primaryBlue,
        child: Column(children: [_buildTopBar(), _buildSearchSection()]),
      ),
    );
  }

  /// Üst bar
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.largePadding),
            child: Container(
              height: AppDimensions.topBarIconSize,
              width: AppDimensions.topBarIconSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.mediumRadius),
                color: AppColors.lightBlue,
              ),
              child: Image.asset(AppAssets.categoryIcon),
            ),
          ),
          SizedBox(
            height: AppDimensions.topBarIconSize,
            width: AppDimensions.topBarContentWidth,
            child: Center(child: Text(AppStrings.countriesTitle, style: AppTextStyles.headerTextStyle)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.largePadding),
            child: Container(
              height: AppDimensions.topBarIconSize,
              width: AppDimensions.topBarIconSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.mediumRadius),
                color: AppColors.lightBlue,
              ),
              child: Image.asset(AppAssets.crownIcon),
            ),
          ),
        ],
      ),
    );
  }

  /// Arama bölümü
  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.largePadding,
        24,
        AppDimensions.largePadding,
        AppDimensions.largePadding,
      ),
      child: SearchBox(
        onTap: () => Get.to(
          () => const CountrySelectionPage(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
