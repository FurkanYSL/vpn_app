import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/country.dart';
import '../services/vpn_service.dart';
import '../constants/constants.dart';
import '../controllers/home_controller.dart'; // Added import for HomeController

/// Country Controller - Ülke seçimi ve arama işlemleri
/// Single Responsibility Principle: Sadece ülke işlemlerinden sorumlu
class CountryController extends GetxController {
  final VpnService _vpnService;

  // Dependency Injection
  CountryController({VpnService? vpnService}) : _vpnService = vpnService ?? VpnService();

  // Reactive state variables
  final RxList<Country> _allCountries = <Country>[].obs;
  final RxList<Country> _filteredCountries = <Country>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isSearching = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<bool> _isVpnConnected = false.obs;
  final Rx<Country?> _currentConnectedCountry = Rx<Country?>(null);

  // Search debounce timer
  Timer? _debounceTimer;

  // Text editing controller for search
  final TextEditingController searchTextController = TextEditingController();

  // Getters
  List<Country> get allCountries => _allCountries;
  List<Country> get filteredCountries => _filteredCountries;
  bool get isLoading => _isLoading.value;
  bool get isSearching => _isSearching.value;
  String get searchQuery => _searchQuery.value;
  String get errorMessage => _errorMessage.value;
  bool get hasSearchQuery => _searchQuery.value.isNotEmpty;

  // Reactive bağlantı durumu
  bool get isVpnConnected => _isVpnConnected.value;
  Country? get currentConnectedCountry => _currentConnectedCountry.value;

  @override
  void onInit() {
    super.onInit();
    loadAllCountries();
    _updateConnectionStatus();

    // Search text controller listener
    searchTextController.addListener(_onSearchTextChanged);
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchTextController.dispose();
    _vpnService.dispose();
    super.onClose();
  }

  /// Tüm ülkeleri yükle
  Future<void> loadAllCountries() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final countries = await _vpnService.getAllCountries();
      _allCountries.value = countries;
      _filteredCountries.value = countries; // Başlangıçta tüm ülkeler gösterilir
    } catch (e) {
      _errorMessage.value = e.toString();
      _showErrorSnackBar('Ülkeler yüklenirken hata oluştu');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Ülke arama
  Future<void> searchCountries(String query) async {
    try {
      _isSearching.value = true;
      _searchQuery.value = query.trim();
      _errorMessage.value = '';

      if (query.trim().isEmpty) {
        // Boş arama - tüm ülkeleri göster
        _filteredCountries.value = _allCountries;
      } else {
        // API'den ara
        final searchResults = await _vpnService.searchCountries(query);
        _filteredCountries.value = searchResults;
      }
    } catch (e) {
      _errorMessage.value = e.toString();
      _showErrorSnackBar('Arama sırasında hata oluştu');
    } finally {
      _isSearching.value = false;
    }
  }

  /// Ülkeye bağlan/bağlantıyı kes
  Future<void> toggleCountryConnection(Country country) async {
    try {
      _isLoading.value = true;

      final success = await _vpnService.toggleCountryConnection(country);

      if (success) {
        // Bağlantı durumunu güncelle
        await _updateConnectionStatus();
        // Ülke listesini güncelle
        await _refreshCountryList();

        // HomeController'ı da güncelle
        if (Get.isRegistered<HomeController>()) {
          final homeController = Get.find<HomeController>();
          await homeController.updateConnectionStats();
        }

        // Bağlantı durumunu tekrar kontrol et
        final isConnected = await _vpnService.isConnected();

        if (isConnected) {
          _showSuccessSnackBar('${country.name} ${AppStrings.connectedTo}');
          await Future.delayed(AppDurations.successSnackBarDuration); // Snackbar süresi kadar bekle
          Get.back(); // Bağlantı kurulduktan sonra ana sayfaya dön
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
      _isLoading.value = false;
    }
  }

  /// Arama kutusunu temizle
  void clearSearch() {
    searchTextController.clear();
    _searchQuery.value = '';
    _filteredCountries.value = _allCountries;
  }

  /// Sayfayı yenile
  Future<void> refreshPage() async {
    await loadAllCountries();
    if (hasSearchQuery) {
      await searchCountries(_searchQuery.value);
    }
  }

  /// Private methods
  void _onSearchTextChanged() {
    final query = searchTextController.text;

    // Debounce search - 300ms bekle
    _debounceTimer?.cancel();
    _debounceTimer = Timer(AppDurations.searchDebounceDuration, () {
      searchCountries(query);
    });
  }

  /// Bağlantı durumunu güncelle
  Future<void> _updateConnectionStatus() async {
    try {
      final isConnected = await _vpnService.isConnected();
      final connectedCountry = await _vpnService.getCurrentConnectedCountry();

      _isVpnConnected.value = isConnected;
      _currentConnectedCountry.value = connectedCountry;
    } catch (e) {
      debugPrint('Connection status update error: $e');
    }
  }

  Future<void> _refreshCountryList() async {
    // Mevcut arama sorgusu varsa aramayı tekrar yap
    if (hasSearchQuery) {
      await searchCountries(_searchQuery.value);
    } else {
      await loadAllCountries();
    }
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
}
