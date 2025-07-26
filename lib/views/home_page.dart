import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../constants/constants.dart';
import '../utils/widget_helpers.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../components/app_header.dart';
import '../components/connection_time_display.dart';
import '../components/stats_section.dart';
import '../components/free_locations_header.dart';
import '../components/speed_graph.dart';
import 'country_selection_page.dart';

/// Home Page View - MVC Pattern View
/// Single Responsibility Principle: Sadece UI gösteriminden sorumlu

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouteObserver ile sayfa tekrar görünür olduğunda tetiklenecek
    final routeObserver = Get.find<RouteObserver<ModalRoute>>();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    final routeObserver = Get.find<RouteObserver<ModalRoute>>();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.updateConnectionStats();
    controller.ensureTimerRunning();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.primaryBlue),
      bottomNavigationBar: CustomBottomNavigationBar(controller: controller),
      backgroundColor: AppColors.lightGray,
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const AppHeader(),
              Obx(() => ConnectionTimeDisplay(connectionTime: controller.connectionStats?.formattedConnectionTime)),
              _buildConnectionStatusSection(controller),
              Obx(
                () => StatsSection(
                  downloadSpeed: controller.connectionStats?.formattedDownloadSpeed,
                  uploadSpeed: controller.connectionStats?.formattedUploadSpeed,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => SpeedGraph(
                  downloadSpeed: controller.connectionStats?.downloadSpeed ?? 0,
                  uploadSpeed: controller.connectionStats?.uploadSpeed ?? 0,
                  isConnected: controller.connectionStats?.isConnected ?? false,
                ),
              ),
              const SizedBox(height: 8),
              _buildFreeLocationsSection(controller),
            ],
          ),
        ),
      ),
    );
  }

  /// Bağlantı durumu bölümü
  Widget _buildConnectionStatusSection(HomeController controller) {
    return Obx(() {
      final stats = controller.connectionStats;
      return Padding(
        padding: const EdgeInsets.fromLTRB(56, 0, 56, 0),
        child: SizedBox(
          width: AppDimensions.connectionStatusWidth,
          child: WidgetHelpers.buildConnectionStatusCard(
            connectedCountry: stats?.connectedCountry,
            strength: stats?.isConnected == true ? stats?.connectedCountry?.strength : 0,
            isConnected: stats?.isConnected == true,
          ),
        ),
      );
    });
  }

  /// Ücretsiz lokasyonlar bölümü
  Widget _buildFreeLocationsSection(HomeController controller) {
    return Obx(() {
      if (controller.isLoading) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(AppDimensions.largePadding),
          child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue)),
        );
      }

      if (controller.errorMessage.isNotEmpty) {
        return WidgetHelpers.buildErrorWidget(message: controller.errorMessage, onRetry: controller.loadFreeCountries);
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(AppDimensions.largePadding, 24, AppDimensions.largePadding, 0),
        child: Column(
          children: [const FreeLocationsHeader(), const SizedBox(height: 4), _buildCountriesList(controller)],
        ),
      );
    });
  }

  /// Ülkeler listesi
  Widget _buildCountriesList(HomeController controller) {
    return Column(
      children: controller.freeCountries.asMap().entries.map((entry) {
        final country = entry.value;
        final isConnected =
            (controller.connectionStats?.isConnected == true) &&
            (controller.connectionStats?.connectedCountry?.countryCode == country.countryCode);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: WidgetHelpers.buildCountryCard(
            country: country,
            isConnected: isConnected,
            onPowerButtonPressed: controller.isConnecting ? () {} : () => controller.toggleCountryConnection(country),
            onChevronPressed: () => Get.to(
              () => const CountrySelectionPage(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        );
      }).toList(),
    );
  }
}
