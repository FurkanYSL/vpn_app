import '../models/country.dart';
import '../models/connection_stats.dart';

/// VPN Repository Interface - Dependency Inversion Principle
/// Abstract sınıf ile interface segregation
abstract class VpnRepository {
  Future<List<Country>> getAllCountries();
  Future<List<Country>> getFreeCountries();
  Future<List<Country>> searchCountries(String query);
  Future<ConnectionStats> getConnectionStats();
  Future<bool> connectToCountry(Country country);
  Future<bool> disconnect();
  Future<bool> isConnected();
  Future<Country?> getCurrentConnectedCountry();
}
