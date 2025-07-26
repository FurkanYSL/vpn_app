/// Country model sınıfı - Ülke verilerini temsil eder
/// Single Responsibility Principle: Sadece ülke verilerinden sorumlu
class Country {
  final String name;
  final String flagAssetPath;
  final String city;
  final int locationCount;
  final int strength;
  final bool isConnected;
  final String countryCode;

  const Country({
    required this.name,
    required this.flagAssetPath,
    required this.city,
    required this.locationCount,
    required this.strength,
    required this.countryCode,
    this.isConnected = false,
  });

  /// Factory constructor for creating Country from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      flagAssetPath: json['flagAssetPath'] as String,
      city: json['city'] as String? ?? '',
      locationCount: json['locationCount'] as int,
      strength: json['strength'] as int,
      countryCode: json['countryCode'] as String,
      isConnected: json['isConnected'] as bool? ?? false,
    );
  }

  /// JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flagAssetPath': flagAssetPath,
      'city': city,
      'locationCount': locationCount,
      'strength': strength,
      'countryCode': countryCode,
      'isConnected': isConnected,
    };
  }

  /// Immutable nesneler için copyWith metodu
  Country copyWith({
    String? name,
    String? flagAssetPath,
    String? city,
    int? locationCount,
    int? strength,
    String? countryCode,
    bool? isConnected,
  }) {
    return Country(
      name: name ?? this.name,
      flagAssetPath: flagAssetPath ?? this.flagAssetPath,
      city: city ?? this.city,
      locationCount: locationCount ?? this.locationCount,
      strength: strength ?? this.strength,
      countryCode: countryCode ?? this.countryCode,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  /// Equality ve hashCode override
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country && other.name == name && other.countryCode == countryCode;
  }

  @override
  int get hashCode => name.hashCode ^ countryCode.hashCode;

  @override
  String toString() {
    return 'Country{name: $name, city: $city, locationCount: $locationCount, strength: $strength%, isConnected: $isConnected}';
  }
}
