import 'package:get/get.dart';
import 'package:movie_app/models/anime_response.dart';
import 'package:movie_app/models/anime.dart';
import 'package:movie_app/utils/network_http.dart';
import 'package:movie_app/constants/api_string.dart';

class AnimeController extends GetxController {
  final RxList<Anime> animeList = <Anime>[].obs;
  final RxList<Anime> upcomingAnimeList = <Anime>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingUpcoming = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt upcomingCurrentPage = 1.obs;
  final RxBool hasNextPage = false.obs;
  final RxBool hasNextUpcomingPage = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxBool isFetching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnimeList();
    fetchUpcomingAnimeList();
  }

  Future<void> fetchAnimeList({bool isRefresh = false}) async {
    if (isFetching.value) return;

    try {
      isFetching.value = true;
      
      if (isRefresh) {
        isRefreshing.value = true;
        currentPage.value = 1;
        animeList.clear();
      } else {
        isLoading.value = true;
      }

      errorMessage.value = '';

      final response = await ApiHandler.get(
        '${APIString.topAnimeApi}${APIString.topAnimeApi.contains('?') ? '&' : '?'}page=${currentPage.value}',
        isMockUrl: false,
      );

      if (response.isSuccess && response.body != null) {
        final animeResponse = AnimeResponse.fromJson(response.body as Map<String, dynamic>);
        
        if (animeResponse.data != null && animeResponse.data!.isNotEmpty) {
          if (isRefresh) {
            animeList.value = animeResponse.data!;
          } else {
            animeList.addAll(animeResponse.data!);
          }

          if (animeResponse.pagination != null) {
            hasNextPage.value = animeResponse.pagination!.hasNextPage ?? false;
            currentPage.value = animeResponse.pagination!.currentPage ?? 1;
          }
        }
      } else {
        errorMessage.value = response.error ?? 'Failed to load anime list';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
      isFetching.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!hasNextPage.value || isLoadingMore.value || isFetching.value) return;

    try {
      isLoadingMore.value = true;
      currentPage.value = currentPage.value + 1;

      final response = await ApiHandler.get(
        '${APIString.topAnimeApi}${APIString.topAnimeApi.contains('?') ? '&' : '?'}page=${currentPage.value}',
        isMockUrl: false,
      );

      if (response.isSuccess && response.body != null) {
        final animeResponse = AnimeResponse.fromJson(response.body as Map<String, dynamic>);
        
        if (animeResponse.data != null && animeResponse.data!.isNotEmpty) {
          animeList.addAll(animeResponse.data!);

          if (animeResponse.pagination != null) {
            hasNextPage.value = animeResponse.pagination!.hasNextPage ?? false;
          }
        }
      }
    } catch (e) {
      currentPage.value = currentPage.value - 1;
      errorMessage.value = 'Failed to load more: ${e.toString()}';
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refresh() async {
    await fetchAnimeList(isRefresh: true);
  }

  Anime? getRandomAnime() {
    if (animeList.isEmpty) return null;
    return animeList[(animeList.length * 0.5).floor()];
  }

  List<Anime> getTrendingAnime({int limit = 10}) {
    if (animeList.isEmpty) return [];
    return animeList.take(limit).toList();
  }

  Future<void> fetchUpcomingAnimeList({bool isRefresh = false}) async {
    try {
      isLoadingUpcoming.value = true;

      if (isRefresh) {
        upcomingCurrentPage.value = 1;
        upcomingAnimeList.clear();
      }

      final response = await ApiHandler.get(
        '${APIString.upcomingAnimeApi}${APIString.upcomingAnimeApi.contains('?') ? '&' : '?'}page=${upcomingCurrentPage.value}',
        isMockUrl: false,
      );

      if (response.isSuccess && response.body != null) {
        final animeResponse = AnimeResponse.fromJson(response.body as Map<String, dynamic>);
        
        if (animeResponse.data != null && animeResponse.data!.isNotEmpty) {
          if (isRefresh) {
            upcomingAnimeList.value = animeResponse.data!;
          } else {
            upcomingAnimeList.addAll(animeResponse.data!);
          }

          if (animeResponse.pagination != null) {
            hasNextUpcomingPage.value = animeResponse.pagination!.hasNextPage ?? false;
            upcomingCurrentPage.value = animeResponse.pagination!.currentPage ?? 1;
          }
        }
      }
    } catch (e) {
      errorMessage.value = 'Failed to load upcoming anime: ${e.toString()}';
    } finally {
      isLoadingUpcoming.value = false;
    }
  }

  Future<void> loadMoreUpcoming() async {
    if (!hasNextUpcomingPage.value || isLoadingUpcoming.value) return;

    try {
      isLoadingUpcoming.value = true;
      upcomingCurrentPage.value = upcomingCurrentPage.value + 1;

      final response = await ApiHandler.get(
        '${APIString.upcomingAnimeApi}${APIString.upcomingAnimeApi.contains('?') ? '&' : '?'}page=${upcomingCurrentPage.value}',
        isMockUrl: false,
      );

      if (response.isSuccess && response.body != null) {
        final animeResponse = AnimeResponse.fromJson(response.body as Map<String, dynamic>);
        
        if (animeResponse.data != null && animeResponse.data!.isNotEmpty) {
          upcomingAnimeList.addAll(animeResponse.data!);

          if (animeResponse.pagination != null) {
            hasNextUpcomingPage.value = animeResponse.pagination!.hasNextPage ?? false;
          }
        }
      }
    } catch (e) {
      upcomingCurrentPage.value = upcomingCurrentPage.value - 1;
      errorMessage.value = 'Failed to load more upcoming anime: ${e.toString()}';
    } finally {
      isLoadingUpcoming.value = false;
    }
  }

  Future<void> refreshUpcoming() async {
    await fetchUpcomingAnimeList(isRefresh: true);
  }

  List<Anime> getUpcomingAnime({int limit = 10}) {
    if (upcomingAnimeList.isEmpty) return [];
    return upcomingAnimeList.take(limit).toList();
  }
}

