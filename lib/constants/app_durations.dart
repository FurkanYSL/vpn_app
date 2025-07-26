/// Uygulama süre sabitleri
/// Single Responsibility Principle: Sadece sürelerden sorumlu
class AppDurations {
  AppDurations._();

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Timer Durations
  static const Duration connectionTimerDuration = Duration(seconds: 1);
  static const Duration statsUpdateDuration = Duration(seconds: 1);
  static const Duration searchDebounceDuration = Duration(milliseconds: 300);

  // Mock API Delays
  static const Duration getAllCountriesDelay = Duration(milliseconds: 500);
  static const Duration getFreeCountriesDelay = Duration(milliseconds: 300);
  static const Duration searchCountriesDelay = Duration(milliseconds: 200);
  static const Duration getConnectionStatsDelay = Duration(milliseconds: 100);
  static const Duration connectToCountryDelay = Duration(milliseconds: 1000);
  static const Duration disconnectDelay = Duration(milliseconds: 500);

  // SnackBar Durations
  static const Duration successSnackBarDuration = Duration(seconds: 2);
  static const Duration infoSnackBarDuration = Duration(seconds: 2);
  static const Duration errorSnackBarDuration = Duration(seconds: 3);
}
