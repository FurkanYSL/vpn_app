import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/country.dart';
import '../models/connection_stats.dart';
import '../services/vpn_service.dart';
import '../constants/constants.dart';

/// Home Controller - MVC Pattern Controller
/// GetX Controller ile state management
/// Single Responsibility Principle: Sadece home sayfası state'inden sorumlu
class HomeController extends GetxController {
  final VpnService _vpnService;

  // Dependency Injection
  HomeController({VpnService? vpnService}) : _vpnService = vpnService ?? VpnService();

  // Reactive state variables
  final RxList<Country> _freeCountries = <Country>[].obs;
  final Rx<ConnectionStats?> _connectionStats = Rx<ConnectionStats?>(null);
  final RxBool _isLoading = false.obs;
  final RxBool _isConnecting = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxInt _currentBottomNavIndex = 0.obs;

  // Timer for real-time updates
  Timer? _statsTimer;

  // Getters
  List<Country> get freeCountries => _freeCountries;
  ConnectionStats? get connectionStats => _connectionStats.value;
  bool get isLoading => _isLoading.value;
  bool get isConnecting => _isConnecting.value;
  String get errorMessage => _errorMessage.value;
  int get currentBottomNavIndex => _currentBottomNavIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    // Timer'ı başlat ve hiç durdurma
    ensureTimerRunning();
  }

  @override
  void onClose() {
    _stopStatsTimer();
    _vpnService.dispose();
    super.onClose();
  }

  /// Sayfa yüklendiğinde çalışacak initialization
  Future<void> _initializeData() async {
    await loadFreeCountries();
    await updateConnectionStats();
  }

  /// Ücretsiz ülkeleri yükler
  Future<void> loadFreeCountries() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final countries = await _vpnService.getFreeCountries();
      _freeCountries.value = countries;
    } catch (e) {
      _errorMessage.value = e.toString();
      _showErrorSnackBar('Ülkeler yüklenirken hata oluştu');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Bağlantı istatistiklerini günceller
  Future<void> updateConnectionStats() async {
    try {
      final stats = await _vpnService.getConnectionStats();
      if (_connectionStats.value != null && stats.isConnected) {
        // Süreyi koruyarak diğer istatistikleri güncelle
        _connectionStats.value = _connectionStats.value!.copyWith(
          downloadSpeed: stats.downloadSpeed,
          uploadSpeed: stats.uploadSpeed,
          connectedCountry: stats.connectedCountry,
          isConnected: stats.isConnected,
        );
      } else {
        _connectionStats.value = stats;
      }
    } catch (e) {
      debugPrint('Connection stats update error: $e');
    }
  }

  /// Ülkeye bağlanma/bağlantı kesme toggle
  Future<void> toggleCountryConnection(Country country) async {
    try {
      _isConnecting.value = true;
      _errorMessage.value = '';

      final success = await _vpnService.toggleCountryConnection(country);

      if (success) {
        await updateConnectionStats();
        await loadFreeCountries(); // Bağlantı durumunu güncellemek için

        final isConnected = await _vpnService.isConnected();
        if (isConnected) {
          _showSuccessSnackBar('${country.name} ${AppStrings.connectedTo}');
        } else {
          _showSuccessSnackBar(AppStrings.disconnected);
        }
      } else {
        _showErrorSnackBar('Bağlantı işlemi başarısız');
      }
    } catch (e) {
      _errorMessage.value = e.toString();
      _showErrorSnackBar('Bağlantı hatası: ${e.toString()}');
    } finally {
      _isConnecting.value = false;
    }
  }

  /// VPN bağlantısını kes
  Future<void> disconnectVpn() async {
    try {
      _isConnecting.value = true;
      _errorMessage.value = '';

      final success = await _vpnService.disconnect();

      if (success) {
        await updateConnectionStats();
        await loadFreeCountries();
        _showSuccessSnackBar(AppStrings.disconnected);
      } else {
        _showErrorSnackBar('Bağlantı kesilemedi');
      }
    } catch (e) {
      _errorMessage.value = e.toString();
      _showErrorSnackBar('Bağlantı kesme hatası: ${e.toString()}');
    } finally {
      _isConnecting.value = false;
    }
  }

  /// Bottom navigation index değiştir
  void changeBottomNavIndex(int index) {
    _currentBottomNavIndex.value = index;

    // Index'e göre aksiyonlar
    switch (index) {
      case 0:
        // Countries - zaten ana sayfada
        break;
      case 1:
        // Disconnect
        disconnectVpn();
        break;
      case 2:
        // Settings
        _showInfoSnackBar(AppStrings.settingsComingSoon);
        break;
    }
  }

  /// Sayfayı yenile
  Future<void> refreshPage() async {
    await Future.wait([loadFreeCountries(), updateConnectionStats()]);
  }

  /// Timer'ın kesinlikle çalıştığından emin ol
  void ensureTimerRunning() {
    if (_statsTimer == null || !_statsTimer!.isActive) {
      _startStatsTimer();
    }
  }

  /// İstatistikleri periyodik olarak güncelle
  void startStatsTimer() {
    _stopStatsTimer();
    _statsTimer = Timer.periodic(AppDurations.statsUpdateDuration, (timer) {
      if (_connectionStats.value != null && _connectionStats.value!.isConnected) {
        // Süreyi 1 saniye artır
        final updated = _connectionStats.value!.copyWith(
          connectedTime: _connectionStats.value!.connectedTime + Duration(seconds: 1),
        );
        _connectionStats.value = updated;
      }
    });
  }

  void _startStatsTimer() => startStatsTimer();

  void _stopStatsTimer() {
    if (_statsTimer?.isActive == true) {
      _statsTimer?.cancel();
    }
    _statsTimer = null;
  }

  /// SnackBar helper methods
  void _showSuccessSnackBar(String message) {
    Get.snackbar(
      AppStrings.successTitle,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successGreen.withValues(alpha: 0.8),
      colorText: AppColors.white,
      duration: AppDurations.successSnackBarDuration,
      margin: const EdgeInsets.all(AppDimensions.defaultPadding),
    );
  }

  void _showErrorSnackBar(String message) {
    Get.snackbar(
      AppStrings.errorTitle,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorRed.withValues(alpha: 0.8),
      colorText: AppColors.white,
      duration: AppDurations.errorSnackBarDuration,
      margin: const EdgeInsets.all(AppDimensions.defaultPadding),
    );
  }

  void _showInfoSnackBar(String message) {
    Get.snackbar(
      AppStrings.infoTitle,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.infoBlue.withValues(alpha: 0.8),
      colorText: AppColors.white,
      duration: AppDurations.infoSnackBarDuration,
      margin: const EdgeInsets.all(AppDimensions.defaultPadding),
    );
  }
}
