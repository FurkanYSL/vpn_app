import '../models/country.dart';
import '../models/connection_stats.dart';
import '../repositories/vpn_repository.dart';
import '../repositories/mock_vpn_repository.dart';

/// VPN Service - Business Logic Layer
/// Single Responsibility Principle: Sadece VPN işlemlerinden sorumlu
/// Dependency Injection için repository interface kullanır
class VpnService {
  final VpnRepository _repository;

  // Dependency Injection - Dependency Inversion Principle
  VpnService({VpnRepository? repository}) : _repository = repository ?? MockVpnRepository();

  /// Tüm ülkeleri getirir
  Future<List<Country>> getAllCountries() async {
    try {
      return await _repository.getAllCountries();
    } catch (e) {
      throw VpnServiceException('Ülkeler yüklenirken hata oluştu: $e');
    }
  }

  /// Ücretsiz ülkeleri getirir
  Future<List<Country>> getFreeCountries() async {
    try {
      return await _repository.getFreeCountries();
    } catch (e) {
      throw VpnServiceException('Ücretsiz ülkeler yüklenirken hata oluştu: $e');
    }
  }

  /// Ülke arama yapar
  Future<List<Country>> searchCountries(String query) async {
    try {
      // Validation
      if (query.length > 50) {
        throw VpnServiceException('Arama terimi çok uzun');
      }

      return await _repository.searchCountries(query.trim());
    } catch (e) {
      if (e is VpnServiceException) rethrow;
      throw VpnServiceException('Arama sırasında hata oluştu: $e');
    }
  }

  /// Bağlantı istatistiklerini getirir
  Future<ConnectionStats> getConnectionStats() async {
    try {
      return await _repository.getConnectionStats();
    } catch (e) {
      throw VpnServiceException('Bağlantı istatistikleri alınırken hata oluştu: $e');
    }
  }

  /// Belirtilen ülkeye bağlanır
  Future<bool> connectToCountry(Country country) async {
    try {
      // Validation
      if (country.name.isEmpty) {
        throw VpnServiceException('Geçersiz ülke bilgisi');
      }

      final isConnected = await _repository.isConnected();
      if (isConnected) {
        final currentCountry = await _repository.getCurrentConnectedCountry();
        if (currentCountry?.countryCode == country.countryCode) {
          throw VpnServiceException('Bu ülkeye zaten bağlısınız');
        }
      }

      return await _repository.connectToCountry(country);
    } catch (e) {
      if (e is VpnServiceException) rethrow;
      throw VpnServiceException('Bağlantı kurulurken hata oluştu: $e');
    }
  }

  /// VPN bağlantısını keser
  Future<bool> disconnect() async {
    try {
      final isConnected = await _repository.isConnected();
      if (!isConnected) {
        throw VpnServiceException('Zaten bağlantı kesilmiş durumda');
      }

      return await _repository.disconnect();
    } catch (e) {
      if (e is VpnServiceException) rethrow;
      throw VpnServiceException('Bağlantı kesilirken hata oluştu: $e');
    }
  }

  /// Bağlantı durumunu kontrol eder
  Future<bool> isConnected() async {
    try {
      return await _repository.isConnected();
    } catch (e) {
      throw VpnServiceException('Bağlantı durumu kontrol edilirken hata oluştu: $e');
    }
  }

  /// Mevcut bağlı olunan ülkeyi getirir
  Future<Country?> getCurrentConnectedCountry() async {
    try {
      return await _repository.getCurrentConnectedCountry();
    } catch (e) {
      throw VpnServiceException('Mevcut ülke bilgisi alınırken hata oluştu: $e');
    }
  }

  /// Ülkenin bağlantı durumunu değiştirir (connect/disconnect toggle)
  Future<bool> toggleCountryConnection(Country country) async {
    try {
      final isConnected = await _repository.isConnected();
      final currentCountry = await _repository.getCurrentConnectedCountry();

      if (isConnected && currentCountry?.countryCode == country.countryCode) {
        // Aynı ülkeye zaten bağlıysa bağlantıyı kes
        return await disconnect();
      } else {
        // Farklı ülkeye bağlan veya ilk bağlantıyı kur
        return await connectToCountry(country);
      }
    } catch (e) {
      if (e is VpnServiceException) rethrow;
      throw VpnServiceException('Bağlantı durumu değiştirilirken hata oluştu: $e');
    }
  }

  /// Service'i temizle
  void dispose() {
    if (_repository is MockVpnRepository) {
      (_repository).dispose();
    }
  }
}

/// Custom Exception class for VPN Service
class VpnServiceException implements Exception {
  final String message;
  const VpnServiceException(this.message);

  @override
  String toString() => 'VpnServiceException: $message';
}
