# VPN App - Flutter

Modern ve kullanıcı dostu bir VPN uygulaması. Flutter ve GetX kullanılarak geliştirilmiştir.

## 📱 Özellikler

- **Ülke Seçimi**: Farklı ülkelerdeki VPN sunucularına bağlanma
- **Gerçek Zamanlı İstatistikler**: Bağlantı süresi, indirme/yükleme hızları
- **Animasyonlu Geçişler**: Yumuşak kullanıcı deneyimi
- **Arama Fonksiyonu**: Ülke ve şehir bazında arama
- **Responsive Tasarım**: Tüm ekran boyutlarında uyumlu
- **Modern UI/UX**: Material Design 3 prensipleri

## 🚀 Kurulum

### Gereksinimler

- Flutter SDK (^3.8.1)
- Dart SDK
- Android Studio / VS Code
- Git

### Adımlar

1. **Projeyi klonlayın**
   ```bash
   git clone https://github.com/FurkanYSL/vpn_app.git
   ```

2. **Bağımlılıkları yükleyin**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı çalıştırın**
   ```bash
   flutter run
   ```

### Platform Desteği

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🏗️ Proje Yapısı

```
lib/
├── components/          # Yeniden kullanılabilir UI bileşenleri
│   ├── app_header.dart
│   ├── connection_time_display.dart
│   ├── custom_bottom_navigation_bar.dart
│   ├── free_locations_header.dart
│   ├── search_box.dart
│   └── stats_section.dart
├── constants/           # Uygulama sabitleri
│   ├── app_assets.dart
│   ├── app_colors.dart
│   ├── app_dimensions.dart
│   ├── app_durations.dart
│   ├── app_fonts.dart
│   ├── app_strings.dart
│   ├── app_text_styles.dart
│   └── constants.dart
├── controllers/         # GetX Controller'ları
│   ├── country_controller.dart
│   └── home_controller.dart
├── models/             # Veri modelleri
│   ├── connection_stats.dart
│   └── country.dart
├── repositories/       # Veri erişim katmanı
│   ├── mock_vpn_repository.dart
│   └── vpn_repository.dart
├── services/           # İş mantığı katmanı
│   └── vpn_service.dart
├── utils/              # Yardımcı fonksiyonlar
│   └── widget_helpers.dart
├── views/              # Sayfa görünümleri
│   ├── country_selection_page.dart
│   └── home_page.dart
└── main.dart           # Uygulama giriş noktası
```

## 🏛️ Mimari Kararlar

### 1. MVC Pattern (Model-View-Controller)
- **Model**: Veri yapıları ve iş mantığı
- **View**: UI bileşenleri ve sayfa görünümleri
- **Controller**: GetX Controller'ları ile state management

### 2. Clean Architecture Prensipleri
- **Separation of Concerns**: Her katmanın belirli sorumlulukları
- **Dependency Injection**: GetX ile bağımlılık enjeksiyonu
- **Repository Pattern**: Veri erişimi için soyutlama

### 3. State Management
- **GetX**: Reaktif state management
- **Rx Variables**: Observable state değişkenleri
- **Controller Lifecycle**: Otomatik memory management

### 4. Code Organization
- **Single Responsibility Principle**: Her sınıf tek sorumluluk
- **DRY (Don't Repeat Yourself)**: Yeniden kullanılabilir bileşenler
- **Consistent Naming**: Tutarlı isimlendirme kuralları

## 📦 Kullanılan Üçüncü Parti Paketler

### 1. **get: ^4.6.6**
- **Neden**: State management, navigation, dependency injection
- **Avantajları**: 
  - Minimal boilerplate code
  - Reaktif programlama
  - Route management
  - Snackbar, dialog yönetimi

### 2. **flutter_svg: ^2.2.0**
- **Neden**: SVG dosyalarını (bayraklar) render etmek için
- **Avantajları**:
  - Vektörel grafik desteği
  - Küçük dosya boyutu
  - Ölçeklenebilir görüntüler

### 3. **cupertino_icons: ^1.0.8**
- **Neden**: iOS tarzı ikonlar
- **Avantajları**:
  - Platform tutarlılığı
  - Zengin ikon seti

### 4. **flutter_lints: ^5.0.0** (Dev Dependency)
- **Neden**: Kod kalitesi ve standartları
- **Avantajları**:
  - Otomatik kod analizi
  - Best practices uygulaması
  - Tutarlı kod stili

## 🎨 Tasarım Sistemi

### Renkler
- **Primary Blue**: Ana marka rengi
- **Light Gray**: Arka plan rengi
- **Card Background**: Kart arka planları
- **Success/Error/Info**: Durum renkleri

### Tipografi
- **Gilroy Font Family**: Modern ve okunabilir
- **Responsive Text Sizes**: Ekran boyutuna uyumlu
- **Consistent Spacing**: Tutarlı boşluklar

### Animasyonlar
- **Duration**: 200-400ms arası geçişler
- **Curves**: easeInOut, easeOut
- **AnimatedContainer**: Yumuşak geçişler
- **AnimatedSwitcher**: İçerik değişimleri

## 🔧 Geliştirme

### Kod Standartları
- **Dart Style Guide** uyumlu
- **flutter_lints** kuralları
- **Consistent indentation** (2 spaces)
- **Meaningful variable names**

### Test Stratejisi
- **Unit Tests**: Model ve service katmanları
- **Widget Tests**: UI bileşenleri
- **Integration Tests**: End-to-end senaryolar

### Performance Optimizations
- **Lazy Loading**: Gerektiğinde yükleme
- **Image Caching**: SVG ve PNG optimizasyonu
- **Memory Management**: GetX otomatik temizlik
- **Efficient Rebuilds**: Obx ile minimal rebuild

## 📱 Kullanım

### Ana Sayfa
- Bağlantı durumu görüntüleme
- Gerçek zamanlı istatistikler
- Ülke listesi

### Ülke Seçimi
- Arama fonksiyonu
- Bağlantı kurma/kesme
- Detaylı ülke bilgileri

### Navigasyon
- Bottom navigation bar
- Smooth transitions
- State persistence

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun 
3. Commit yapın 
4. Push yapın 
5. Pull Request açın

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 📞 İletişim

- **Geliştirici**: [Adınız]
- **Email**: [email@example.com]
- **GitHub**: [github.com/FurkanYSL]

---

**Not**: Bu proje eğitim amaçlı geliştirilmiştir ve gerçek VPN hizmeti sağlamaz.
