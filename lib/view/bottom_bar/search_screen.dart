import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/search_controller.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:movie_app/widgets/anime_card.dart';
import 'package:movie_app/widgets/anime_shimmer.dart';
import 'package:movie_app/constants/common_colors.dart';
import 'package:movie_app/constants/text_style.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchAnimeController());

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          style: regularTextStyle(color: CommonColors.whiteColor),
          decoration: InputDecoration(
            hintText: 'Search Anime',
            hintStyle: regularTextStyle(
              color: CommonColors.searchBarHintTextColor,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: CommonColors.searchBarHintTextColor,
            ),
            filled: true,
            fillColor: CommonColors.greyTextColor.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: controller.onSearchChanged,
        ),
      ),
      body: Obx(() {
        // Show loading for trending anime when screen first loads
        if (controller.isLoadingTrending.value && 
            controller.searchQuery.value.isEmpty && 
            controller.trendingAnime.isEmpty) {
          return _buildShimmerGrid();
        }

        // Show loading for search results
        if (controller.isLoading.value && controller.searchQuery.value.isNotEmpty) {
          return _buildShimmerGrid();
        }

        // Show trending anime when search is empty
        if (controller.searchQuery.value.isEmpty) {
          if (controller.trendingAnime.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: CommonColors.greyTextColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search for your favorite anime',
                    style: regularTextStyle(
                      fontsize: 16,
                      color: CommonColors.greyTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          // Display trending anime in grid
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Trending Anime',
                  style: boldTextStyle(
                    fontsize: 20,
                    color: CommonColors.whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.trendingAnime.length,
                  itemBuilder: (context, index) {
                    final anime = controller.trendingAnime[index];
                    return AnimeCard(
                      anime: anime,
                      index: index,
                      onTap: () {
                        Get.toNamed(Routes.animeDetail, arguments: anime);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }

        // Show no results message
        if (controller.searchResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: CommonColors.greyTextColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'No results found',
                  style: regularTextStyle(
                    fontsize: 16,
                    color: CommonColors.greyTextColor,
                  ),
                ),
              ],
            ),
          );
        }

        // Show search results
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final anime = controller.searchResults[index];
            return AnimeCard(
              anime: anime,
              index: index,
              onTap: () {
                Get.toNamed(Routes.animeDetail, arguments: anime);
              },
            );
          },
        );
      }),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const AnimeCardShimmer();
      },
    );
  }
}

