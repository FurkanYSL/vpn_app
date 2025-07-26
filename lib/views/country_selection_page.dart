import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/country_controller.dart';
import '../constants/constants.dart';
import '../utils/widget_helpers.dart';

/// Country Selection Page View - MVC Pattern View
/// Single Responsibility Principle: Sadece ülke seçimi UI'ından sorumlu
class CountrySelectionPage extends StatelessWidget {
  const CountrySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller'ı dependency injection ile al
    final CountryController controller = Get.put(CountryController());

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.lightGray,
      body: Column(children: [_buildSearchSection(controller), _buildCountriesList(controller)]),
    );
  }

  /// App bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(AppStrings.countrySelectionTitle, style: AppTextStyles.headerTextStyle),
      centerTitle: true,
    );
  }

  /// Arama bölümü
  Widget _buildSearchSection(CountryController controller) {
    return Container(
      color: AppColors.primaryBlue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.defaultPadding,
          0,
          AppDimensions.defaultPadding,
          AppDimensions.defaultPadding,
        ),
        child: WidgetHelpers.buildSearchBox(
          controller: controller.searchTextController,
          hintText: AppStrings.searchHint,
        ),
      ),
    );
  }

  /// Ülkeler listesi
  Widget _buildCountriesList(CountryController controller) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading && controller.filteredCountries.isEmpty) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: WidgetHelpers.buildLoadingWidget(message: AppStrings.loadingCountries),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
          return WidgetHelpers.buildErrorWidget(message: controller.errorMessage, onRetry: controller.loadAllCountries);
        }

        if (controller.filteredCountries.isEmpty) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: WidgetHelpers.buildEmptyWidget(
              message: controller.hasSearchQuery ? AppStrings.noCountriesFound : AppStrings.noCountriesAvailable,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPage,
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.defaultPadding),
            itemCount: controller.filteredCountries.length,
            itemBuilder: (context, index) {
              final country = controller.filteredCountries[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.smallPadding),
                child: WidgetHelpers.buildCountryCard(
                  country: country,
                  isConnected:
                      controller.isVpnConnected &&
                      (controller.currentConnectedCountry?.countryCode == country.countryCode),
                  showChevron: false, // Bu sayfada chevron göstermiyoruz
                  onPowerButtonPressed: controller.isLoading
                      ? () {}
                      : () => controller.toggleCountryConnection(country),
                  onChevronPressed: () {}, // Boş callback
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
