import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// Speed Graph Component - Bağlantı hızını gösteren animasyonlu grafik
/// Single Responsibility Principle: Sadece hız grafiği gösteriminden sorumlu
class SpeedGraph extends StatefulWidget {
  final int downloadSpeed;
  final int uploadSpeed;
  final bool isConnected;

  const SpeedGraph({super.key, required this.downloadSpeed, required this.uploadSpeed, required this.isConnected});

  @override
  State<SpeedGraph> createState() => _SpeedGraphState();
}

class _SpeedGraphState extends State<SpeedGraph> with TickerProviderStateMixin {
  late AnimationController _downloadController;
  late AnimationController _uploadController;
  late Animation<double> _downloadAnimation;
  late Animation<double> _uploadAnimation;

  @override
  void initState() {
    super.initState();

    _downloadController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _uploadController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _updateAnimations();
  }

  @override
  void didUpdateWidget(SpeedGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.downloadSpeed != widget.downloadSpeed || oldWidget.uploadSpeed != widget.uploadSpeed) {
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    // Download animasyonu
    _downloadAnimation = Tween<double>(
      begin: 0.0,
      end: widget.isConnected ? (widget.downloadSpeed / 1000).clamp(0.0, 1.0) : 0.0,
    ).animate(CurvedAnimation(parent: _downloadController, curve: Curves.easeOutCubic));

    // Upload animasyonu
    _uploadAnimation = Tween<double>(
      begin: 0.0,
      end: widget.isConnected ? (widget.uploadSpeed / 1000).clamp(0.0, 1.0) : 0.0,
    ).animate(CurvedAnimation(parent: _uploadController, curve: Curves.easeOutCubic));

    _downloadController.forward();
    _uploadController.forward();
  }

  @override
  void dispose() {
    _downloadController.dispose();
    _uploadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        border: Border.all(color: AppColors.cardBorderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed_rounded, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 8),
              Text('Connection Speed', style: AppTextStyles.countryNameTextStyle),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildSpeedBar(
                    label: 'Download',
                    speed: widget.downloadSpeed,
                    animation: _downloadAnimation,
                    color: AppColors.primaryBlue,
                    icon: Icons.download_rounded,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSpeedBar(
                    label: 'Upload',
                    speed: widget.uploadSpeed,
                    animation: _uploadAnimation,
                    color: AppColors.successGreen,
                    icon: Icons.upload_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedBar({
    required String label,
    required int speed,
    required Animation<double> animation,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label, style: AppTextStyles.cityNameTextStyle.copyWith(color: AppColors.darkText, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.lightGray, borderRadius: BorderRadius.circular(8)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: animation.value,
                  child: Container(
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
