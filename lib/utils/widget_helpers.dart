import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constants.dart';
import '../models/country.dart';

/// Widget Helper Functions ve Reusable Components
/// Single Responsibility Principle: Her widget tek bir görevi yapar
class WidgetHelpers {
  WidgetHelpers._(); // Private constructor

  /// Ülke kartı widget'ı
  static Widget buildCountryCard({
    required Country country,
    required VoidCallback onPowerButtonPressed,
    required VoidCallback onChevronPressed,
    bool isConnected = false,
    bool showChevron = true,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isConnected ? AppColors.primaryBlue.withValues(alpha: 0.08) : AppColors.cardBackground,
        border: Border.all(color: AppColors.cardBorderColor, width: 1),
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Ülke bayrağı
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.smallRadius),
              child: SizedBox(
                height: AppDimensions.flagHeight,
                width: AppDimensions.flagWidth,
                child: SvgPicture.asset(country.flagAssetPath, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: AppDimensions.mediumSpacing),

            // Ülke bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(country.name, style: AppTextStyles.countryNameTextStyle),
                  if (country.city.isNotEmpty)
                    Text(country.city, style: AppTextStyles.cityNameTextStyle)
                  else
                    Text(
                      '${country.locationCount} ${AppStrings.locationsLabel}',
                      style: AppTextStyles.cityNameTextStyle,
                    ),
                ],
              ),
            ),

            // Sağ taraf - Güç ve ok butonları
            Row(
              children: [
                // Power button
                GestureDetector(
                  onTap: onPowerButtonPressed,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: AppDimensions.powerButtonSize,
                    width: AppDimensions.powerButtonSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.mediumRadius),
                      color: isConnected ? AppColors.primaryBlue : AppColors.cardBorderColor,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                      child: Image.asset(
                        isConnected ? AppAssets.powerIcon : AppAssets.powerIconBlack,
                        key: ValueKey(isConnected),
                      ),
                    ),
                  ),
                ),

                if (showChevron) ...[
                  const SizedBox(width: AppDimensions.mediumSpacing),
                  // Chevron button
                  GestureDetector(
                    onTap: onChevronPressed,
                    child: Container(
                      height: AppDimensions.chevronButtonSize,
                      width: AppDimensions.chevronButtonSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimensions.mediumRadius),
                        color: AppColors.cardBorderColor,
                      ),
                      child: Image.asset(AppAssets.chevronRightIcon),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Bağlantı durumu kartı
  static Widget buildConnectionStatusCard({
    required Country? connectedCountry,
    int? strength,
    bool isConnected = false,
  }) {
    if (connectedCountry == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(color: AppColors.cardBorderColor, width: 1),
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.smallRadius),
              child: SizedBox(
                height: AppDimensions.flagHeight,
                width: AppDimensions.flagWidth,
                child: SvgPicture.asset(connectedCountry.flagAssetPath),
              ),
            ),
            const SizedBox(width: AppDimensions.mediumSpacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(connectedCountry.name, style: AppTextStyles.countryNameTextStyle),
                Text(
                  isConnected
                      ? (connectedCountry.city.isNotEmpty ? '${connectedCountry.city} Connected' : 'Connected')
                      : 'Not Connected',
                  style: AppTextStyles.cityNameTextStyle,
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(AppStrings.stealthLabel, style: AppTextStyles.cityNameTextStyle),
                Text('${strength ?? connectedCountry.strength}%', style: AppTextStyles.strengthPercentageStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// İstatistik kartı (Download/Upload)
  static Widget buildStatCard({required String iconPath, required String label, required String value}) {
    return Container(
      height: AppDimensions.statCardHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(color: AppColors.cardBorderColor, width: 1),
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppDimensions.mediumIconSize,
            height: AppDimensions.mediumIconSize,
            child: Image.asset(iconPath),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.cityNameTextStyle, overflow: TextOverflow.ellipsis, maxLines: 1),
                Text(value, style: AppTextStyles.countryNameTextStyle, overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Arama kutusu widget'ı
  static Widget buildSearchBox({
    required TextEditingController controller,
    String hintText = AppStrings.searchHint,
    VoidCallback? onSearchTap,
  }) {
    return Container(
      height: AppDimensions.searchBoxHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
              child: TextField(
                controller: controller,
                style: AppTextStyles.countryNameTextStyle,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTextStyles.searchHintTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onSearchTap,
            child: Padding(
              padding: const EdgeInsets.only(right: AppDimensions.defaultPadding),
              child: Icon(Icons.search_rounded, color: AppColors.iconGray),
            ),
          ),
        ],
      ),
    );
  }

  /// Yükleniyor widget'ı
  static Widget buildLoadingWidget({String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue)),
          if (message != null) ...[
            const SizedBox(height: AppDimensions.defaultPadding),
            Text(message, style: AppTextStyles.countryNameTextStyle, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }

  /// Hata widget'ı
  static Widget buildErrorWidget({required String message, VoidCallback? onRetry}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.errorRed),
            const SizedBox(height: AppDimensions.defaultPadding),
            Text(message, style: AppTextStyles.countryNameTextStyle, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.defaultPadding),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.white,
                ),
                child: Text(AppStrings.retryButton),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Boş liste widget'ı
  static Widget buildEmptyWidget({required String message, IconData icon = Icons.search_off}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppColors.lightText),
            const SizedBox(height: AppDimensions.defaultPadding),
            Text(
              message,
              style: AppTextStyles.countryNameTextStyle.copyWith(color: AppColors.lightText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
