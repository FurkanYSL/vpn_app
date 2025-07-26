import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_page.dart';
import 'constants/constants.dart';

void main() {
  Get.put<RouteObserver<ModalRoute>>(RouteObserver<ModalRoute>());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue), useMaterial3: true),
      home: const HomePage(),
      // GetX yapılandırması
      defaultTransition: Transition.cupertino,
      transitionDuration: AppDurations.mediumAnimationDuration,
      navigatorObservers: [Get.put(RouteObserver<ModalRoute>())],
    );
  }
}
