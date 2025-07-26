/// Uygulama metin sabitleri
/// Single Responsibility Principle: Sadece metinlerden sorumlu
class AppStrings {
  AppStrings._();

  // App Info
  static const String appTitle = 'VPN App';

  // Navigation Labels
  static const String countriesTitle = 'Countries';
  static const String disconnectTitle = 'Disconnect';
  static const String settingTitle = 'Setting';

  // UI Labels
  static const String searchHint = 'Search For Country Or City';
  static const String connectingTimeLabel = 'Connecting Time';
  static const String downloadLabel = 'Download :';
  static const String uploadLabel = 'Upload :';
  static const String freeLocationsLabel = 'Free Locations (3)';
  static const String stealthLabel = 'Strength';
  static const String locationsLabel = 'Locations';

  // Page Titles
  static const String countrySelectionTitle = 'Country Selection';

  // Messages
  static const String noActiveConnection = 'No active connection to disconnect';
  static const String loadingCountries = 'Loading countries...';
  static const String noCountriesFound = 'No countries found matching your search criteria';
  static const String noCountriesAvailable = 'No countries available yet';
  static const String retryButton = 'Retry';
  static const String settingsComingSoon = 'Settings page will be added soon';

  // Status Messages
  static const String successTitle = 'Success';
  static const String errorTitle = 'Error';
  static const String infoTitle = 'Info';
  static const String connectedTo = 'connected to';
  static const String disconnected = 'Disconnected';
}
