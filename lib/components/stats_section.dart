import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../utils/widget_helpers.dart';

/// Stats Section Component (Download/Upload)
/// Single Responsibility Principle: Sadece istatistik gösteriminden sorumlu
class StatsSection extends StatelessWidget {
  final String? downloadSpeed;
  final String? uploadSpeed;

  const StatsSection({super.key, this.downloadSpeed, this.uploadSpeed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(56, 8, 56, 0),
      child: SizedBox(
        width: AppDimensions.connectionStatusWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: WidgetHelpers.buildStatCard(
                iconPath: AppAssets.downloadIcon,
                label: AppStrings.downloadLabel,
                value: downloadSpeed ?? '0 MB',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: WidgetHelpers.buildStatCard(
                iconPath: AppAssets.uploadIcon,
                label: AppStrings.uploadLabel,
                value: uploadSpeed ?? '0 MB',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
