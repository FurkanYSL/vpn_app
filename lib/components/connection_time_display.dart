import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// Connection Time Display Component
class ConnectionTimeDisplay extends StatelessWidget {
  final String? connectionTime;

  const ConnectionTimeDisplay({super.key, this.connectionTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: AppDimensions.connectionTimeWidth,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
              child: Text(
                AppStrings.connectingTimeLabel,
                textAlign: TextAlign.center,
                style: AppTextStyles.connectionTimeLabelStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                connectionTime ?? '00 : 00 : 00',
                textAlign: TextAlign.center,
                style: AppTextStyles.timeTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
