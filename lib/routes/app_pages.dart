import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/routes/binding.dart';
import 'package:movie_app/view/splash_screen.dart';
import 'package:movie_app/view/bottom_bar/main_navigation_screen.dart';
import 'package:movie_app/view/bottom_bar/home_screen.dart';
import 'package:movie_app/view/bottom_bar/search_screen.dart';
import 'package:movie_app/view/bottom_bar/new_releases_screen.dart';
import 'package:movie_app/view/bottom_bar/anime_detail_screen.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splashScreen;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.mainNavigation,
      page: () => const MainNavigationScreen(),
      binding: MainNavigationBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: AnimeBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    ),
    GetPage(
      name: Routes.newReleases,
      page: () => const NewReleasesScreen(),
      binding: AnimeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    ),
    GetPage(
      name: Routes.animeDetail,
      page: () => const AnimeDetailScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    ),
  ];
}
