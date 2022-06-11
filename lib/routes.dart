import 'package:credigy/views/home/landing_page.dart';
import 'package:credigy/views/home/tabs/inventory/inventory_tab.dart';
import 'package:credigy/views/onboarding/onboarding_page.dart';
import 'package:credigy/views/onboarding/splash_screen_view.dart';
import 'package:flutter/material.dart';

Route<dynamic>? initialGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => const SplashScreenPage());
    case LandingPage.routeName:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case OnboardingPage.routeName:
      return MaterialPageRoute(builder: (context) => const OnboardingPage());
    case InventoryTab.routeName:
      return MaterialPageRoute(builder: (context) => InventoryTab());
    /* case AddAccommodationImagesPage.routeName:
      return MaterialPageRoute(builder: (context) {
        var map = setting.arguments as Map;
        return AddAccommodationImagesPage(id: map["id"]);
      }); */

    default:
      return MaterialPageRoute(builder: (context) => const Text("Not found "));
  }
}
