/// Uygulama asset sabitleri
/// Single Responsibility Principle: Sadece asset yollarından sorumlu
class AppAssets {
  AppAssets._();

  // Asset Paths
  static const String pngAssetsPath = 'assets/images/png/';
  static const String svgAssetsPath = 'assets/images/svg/';
  static const String flagsPath = 'assets/images/svg/flags/';

  // PNG Icon Assets
  static const String categoryIcon = '${pngAssetsPath}category_icon.png';
  static const String countriesIcon = '${pngAssetsPath}countries_icon.png';
  static const String crownIcon = '${pngAssetsPath}crown_icon.png';
  static const String disconnectIcon = '${pngAssetsPath}disconnect_icon.png';
  static const String downloadIcon = '${pngAssetsPath}download_icon.png';
  static const String uploadIcon = '${pngAssetsPath}upload_icon.png';
  static const String powerIcon = '${pngAssetsPath}power_icon.png';
  static const String powerIconBlack = '${pngAssetsPath}power_icon_black.png';
  static const String settingIcon = '${pngAssetsPath}setting_icon.png';
  static const String chevronRightIcon = '${pngAssetsPath}chevron_right_icon.png';
  static const String infoCircleIcon = '${pngAssetsPath}info-circle.png';

  // SVG Flag Assets
  static const String italyFlag = '${flagsPath}it.svg';
  static const String netherlandsFlag = '${flagsPath}nl.svg';
  static const String germanyFlag = '${flagsPath}de.svg';
}
