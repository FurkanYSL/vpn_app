import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// Search Box Component
class SearchBox extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;

  const SearchBox({super.key, this.onTap, this.hintText = AppStrings.searchHint});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.searchBoxHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 0, 18),
              child: Text(hintText, style: AppTextStyles.searchHintTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.search_rounded, color: AppColors.iconGray),
            ),
          ],
        ),
      ),
    );
  }
}
