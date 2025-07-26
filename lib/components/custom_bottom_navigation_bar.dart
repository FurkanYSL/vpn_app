import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import '../controllers/home_controller.dart';

/// Custom Bottom Navigation Bar Component
class CustomBottomNavigationBar extends StatelessWidget {
  final HomeController controller;

  const CustomBottomNavigationBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isConnected = controller.connectionStats?.isConnected ?? false;

      return Container(
        height: 100,
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          border: Border(top: BorderSide(color: AppColors.cardBorderColor, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Countries
            GestureDetector(
              onTap: () => controller.changeBottomNavIndex(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppDimensions.bottomNavIconHeight,
                    width: AppDimensions.bottomNavIconWidth,
                    child: Image.asset(AppAssets.countriesIcon),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.countriesTitle,
                    style: AppTextStyles.bottomNavTextStyle.copyWith(color: AppColors.primaryBlue),
                  ),
                ],
              ),
            ),
            // Disconnect
            GestureDetector(
              onTap: () {
                if (!isConnected) {
                  Get.snackbar(
                    AppStrings.infoTitle,
                    AppStrings.noActiveConnection,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.infoBlue.withValues(alpha: 0.8),
                    colorText: AppColors.white,
                    duration: AppDurations.infoSnackBarDuration,
                    margin: const EdgeInsets.all(AppDimensions.defaultPadding),
                  );
                  return;
                }
                controller.changeBottomNavIndex(1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: isConnected ? 1.0 : 0.5,
                    child: SizedBox(
                      height: AppDimensions.bottomNavIconHeight,
                      width: AppDimensions.bottomNavIconWidth,
                      child: Image.asset(AppAssets.disconnectIcon),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.disconnectTitle,
                    style: AppTextStyles.bottomNavTextStyle.copyWith(color: AppColors.darkText),
                  ),
                ],
              ),
            ),
            // Setting
            GestureDetector(
              onTap: () => controller.changeBottomNavIndex(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppDimensions.bottomNavIconHeight,
                    width: AppDimensions.bottomNavIconWidth,
                    child: Image.asset(AppAssets.settingIcon),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.settingTitle,
                    style: AppTextStyles.bottomNavTextStyle.copyWith(color: AppColors.darkText),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
