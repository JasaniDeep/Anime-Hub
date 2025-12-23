import 'package:get/get.dart';
import 'package:movie_app/controllers/anime_controller.dart';
import 'package:movie_app/controllers/search_controller.dart';

class AnimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeController>(() => AnimeController());
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchAnimeController>(() => SearchAnimeController());
  }
}

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeController>(() => AnimeController());
  }
}
