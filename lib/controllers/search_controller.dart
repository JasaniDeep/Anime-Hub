import 'dart:async';

import 'package:get/get.dart';
import 'package:movie_app/constants/api_string.dart';
import 'package:movie_app/models/anime.dart';
import 'package:movie_app/models/anime_response.dart';
import 'package:movie_app/utils/network_http.dart';

class SearchAnimeController extends GetxController {
  final RxList<Anime> searchResults = <Anime>[].obs;
  final RxList<Anime> trendingAnime = <Anime>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingTrending = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    fetchTrendingAnime();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  Future<void> fetchTrendingAnime() async {
    try {
      isLoadingTrending.value = true;
      errorMessage.value = '';

      final response = await ApiHandler.get(
        '${APIString.topAnimeApi}${APIString.topAnimeApi.contains('?') ? '&' : '?'}limit=20',
        isMockUrl: false,
      );

      if (response.isSuccess && response.body != null) {
        final animeResponse = AnimeResponse.fromJson(
          response.body as Map<String, dynamic>,
        );

        if (animeResponse.data != null && animeResponse.data!.isNotEmpty) {
          trendingAnime.value = animeResponse.data!;
        }
      }
    } catch (e) {
      errorMessage.value = 'Failed to load trending anime: ${e.toString()}';
    } finally {
      isLoadingTrending.value = false;
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      // When search is cleared, show trending anime again
      searchResults.clear();
      return;
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      searchAnime(query);
    });
  }

  Future<void> searchAnime(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await ApiHandler.get(
        '${APIString.searchAnimeApi}?q=${Uri.encodeComponent(query)}&limit=500',
        isMockUrl: false,
      );

      if (response.isSuccess && response.body != null) {
        final animeResponse = AnimeResponse.fromJson(
          response.body as Map<String, dynamic>,
        );

        if (animeResponse.data != null) {
          searchResults.value = animeResponse.data!;
        } else {
          searchResults.clear();
        }
      } else {
        errorMessage.value = response.error ?? 'Failed to search anime';
        searchResults.clear();
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    errorMessage.value = '';
  }
}
