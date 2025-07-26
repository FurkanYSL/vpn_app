import 'dart:async';
import '../models/country.dart';
import '../models/connection_stats.dart';
import '../constants/constants.dart';
import 'vpn_repository.dart';

/// Mock VPN Repository Implementation
/// Gerçek API yerine test verileri sağlar
class MockVpnRepository implements VpnRepository {
  // Singleton pattern
  static final MockVpnRepository _instance = MockVpnRepository._internal();
  factory MockVpnRepository() => _instance;
  MockVpnRepository._internal() {
    _lastConnectedCountry = _mockCountries[1].copyWith(); // Netherlands, Amsterdam
    _currentConnectedCountry = _mockCountries[1].copyWith(); // İlk açılışta Netherlands aktif
    _isConnected = true; // İlk açılışta bağlı
    _connectionDuration = const Duration(hours: 2, minutes: 41, seconds: 52);

    // Timer'ı başlat ki süre artmaya devam etsin
    _startConnectionTimer();
  }

  // Mock state
  Country? _currentConnectedCountry;
  Country? _lastConnectedCountry; // Son bağlantı bilgisini sakla
  bool _isConnected = false;
  Timer? _connectionTimer;
  Duration _connectionDuration = Duration.zero;

  // Mock countries data
  final List<Country> _mockCountries = [
    Country(
      name: 'Italy',
      flagAssetPath: AppAssets.italyFlag,
      city: '',
      locationCount: 4,
      strength: 70,
      countryCode: 'IT',
    ),
    Country(
      name: 'Netherlands',
      flagAssetPath: AppAssets.netherlandsFlag,
      city: 'Amsterdam',
      locationCount: 12,
      strength: 85,
      countryCode: 'NL',
    ),
    Country(
      name: 'Germany',
      flagAssetPath: AppAssets.germanyFlag,
      city: '',
      locationCount: 10,
      strength: 90,
      countryCode: 'DE',
    ),
  ];

  @override
  Future<List<Country>> getAllCountries() async {
    // API çağrısını simüle etmek için gecikme
    await Future.delayed(AppDurations.getAllCountriesDelay);
    return List.from(_mockCountries);
  }

  @override
  Future<List<Country>> getFreeCountries() async {
    await Future.delayed(AppDurations.getFreeCountriesDelay);
    return _mockCountries.take(3).toList();
  }

  @override
  Future<List<Country>> searchCountries(String query) async {
    await Future.delayed(AppDurations.searchCountriesDelay);

    if (query.isEmpty) {
      return getAllCountries();
    }

    final lowercaseQuery = query.toLowerCase();
    return _mockCountries.where((country) {
      return country.name.toLowerCase().contains(lowercaseQuery) ||
          country.city.toLowerCase().contains(lowercaseQuery) ||
          country.countryCode.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<ConnectionStats> getConnectionStats() async {
    await Future.delayed(AppDurations.getConnectionStatsDelay);
    return ConnectionStats(
      downloadSpeed: _isConnected ? 527 : 0,
      uploadSpeed: _isConnected ? 49 : 0,
      connectedTime: _connectionDuration,
      connectedCountry: _isConnected ? _currentConnectedCountry : _lastConnectedCountry,
      isConnected: _isConnected,
    );
  }

  @override
  Future<bool> connectToCountry(Country country) async {
    await Future.delayed(AppDurations.connectToCountryDelay);

    try {
      // Önceki bağlantıyı kes
      if (_isConnected) {
        await disconnect();
      }

      // Yeni bağlantı kur
      _currentConnectedCountry = country.copyWith(isConnected: true);
      _lastConnectedCountry = country.copyWith(isConnected: true); // Son bağlantıyı güncelle
      _isConnected = true;
      _connectionDuration = Duration.zero;

      // Bağlantı süresini sayacı başlat
      _startConnectionTimer();

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> disconnect() async {
    await Future.delayed(AppDurations.disconnectDelay);

    try {
      // Son bağlantı bilgisini sakla
      if (_currentConnectedCountry != null) {
        _lastConnectedCountry = _currentConnectedCountry;
      }

      _isConnected = false;
      _currentConnectedCountry = null;
      _connectionDuration = Duration.zero;

      // Timer'ı durdur
      _stopConnectionTimer();

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isConnected() async {
    return _isConnected;
  }

  @override
  Future<Country?> getCurrentConnectedCountry() async {
    return _currentConnectedCountry;
  }

  // Private methods
  void _startConnectionTimer() {
    _stopConnectionTimer(); // Önceki timer'ı durdur

    _connectionTimer = Timer.periodic(AppDurations.connectionTimerDuration, (timer) {
      _connectionDuration = Duration(seconds: _connectionDuration.inSeconds + 1);
    });
  }

  void _stopConnectionTimer() {
    if (_connectionTimer?.isActive == true) {
      _connectionTimer?.cancel();
    }
  }

  // Memory cleanup
  void dispose() {
    _stopConnectionTimer();
  }
}
