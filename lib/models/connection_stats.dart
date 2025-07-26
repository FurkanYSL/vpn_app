import 'country.dart';

/// ConnectionStats model sınıfı - Bağlantı istatistiklerini temsil eder
/// Single Responsibility Principle: Sadece bağlantı istatistiklerinden sorumlu
class ConnectionStats {
  final int downloadSpeed;
  final int uploadSpeed;
  final Duration connectedTime;
  final Country? connectedCountry;
  final bool isConnected;

  const ConnectionStats({
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.connectedTime,
    this.connectedCountry,
    this.isConnected = false,
  });

  /// Factory constructor for creating ConnectionStats from JSON
  factory ConnectionStats.fromJson(Map<String, dynamic> json) {
    return ConnectionStats(
      downloadSpeed: json['downloadSpeed'] as int,
      uploadSpeed: json['uploadSpeed'] as int,
      connectedTime: Duration(seconds: json['connectedTimeSeconds'] as int),
      connectedCountry: json['connectedCountry'] != null
          ? Country.fromJson(json['connectedCountry'] as Map<String, dynamic>)
          : null,
      isConnected: json['isConnected'] as bool? ?? false,
    );
  }

  /// JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'downloadSpeed': downloadSpeed,
      'uploadSpeed': uploadSpeed,
      'connectedTimeSeconds': connectedTime.inSeconds,
      'connectedCountry': connectedCountry?.toJson(),
      'isConnected': isConnected,
    };
  }

  /// Immutable nesneler için copyWith metodu
  ConnectionStats copyWith({
    int? downloadSpeed,
    int? uploadSpeed,
    Duration? connectedTime,
    Country? connectedCountry,
    bool? isConnected,
    bool? clearConnectedCountry,
  }) {
    return ConnectionStats(
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      connectedTime: connectedTime ?? this.connectedTime,
      connectedCountry: clearConnectedCountry == true ? null : connectedCountry ?? this.connectedCountry,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  /// Bağlantı süresini formatlanmış string olarak döner (HH:MM:SS)
  String get formattedConnectionTime {
    final hours = connectedTime.inHours.toString().padLeft(2, '0');
    final minutes = (connectedTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (connectedTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours : $minutes : $seconds';
  }

  /// İndirme hızını formatlanmış string olarak döner
  String get formattedDownloadSpeed => '$downloadSpeed MB';

  /// Yükleme hızını formatlanmış string olarak döner
  String get formattedUploadSpeed => '$uploadSpeed MB';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConnectionStats &&
        other.downloadSpeed == downloadSpeed &&
        other.uploadSpeed == uploadSpeed &&
        other.connectedTime == connectedTime &&
        other.connectedCountry == connectedCountry &&
        other.isConnected == isConnected;
  }

  @override
  int get hashCode {
    return downloadSpeed.hashCode ^
        uploadSpeed.hashCode ^
        connectedTime.hashCode ^
        connectedCountry.hashCode ^
        isConnected.hashCode;
  }

  @override
  String toString() {
    return 'ConnectionStats{downloadSpeed: ${downloadSpeed}MB, uploadSpeed: ${uploadSpeed}MB, connectedTime: $formattedConnectionTime, connectedCountry: ${connectedCountry?.name}, isConnected: $isConnected}';
  }
}
