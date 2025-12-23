import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/common_colors.dart';
import 'package:movie_app/constants/text_style.dart';
import 'package:movie_app/controllers/anime_controller.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:shimmer/shimmer.dart';

class NewReleasesScreen extends StatelessWidget {
  const NewReleasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'New Releases',
          style: boldTextStyle(fontsize: 24, color: CommonColors.whiteColor),
        ),
      ),
      body: Obx(() {
        if (controller.isLoadingUpcoming.value &&
            controller.upcomingAnimeList.isEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildNewReleaseItemShimmer();
            },
          );
        }

        if (controller.upcomingAnimeList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 64,
                  color: CommonColors.greyTextColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'No upcoming releases',
                  style: regularTextStyle(
                    fontsize: 16,
                    color: CommonColors.greyTextColor,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshUpcoming,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CommonColors.redColor,
                    foregroundColor: CommonColors.whiteColor,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshUpcoming,
          color: CommonColors.redColor,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount:
                controller.upcomingAnimeList.length +
                (controller.hasNextUpcomingPage.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.upcomingAnimeList.length) {
                return Obx(() {
                  if (controller.isLoadingUpcoming.value) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CommonColors.redColor,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: controller.loadMoreUpcoming,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonColors.redColor,
                        foregroundColor: CommonColors.whiteColor,
                      ),
                      child: const Text('Load More'),
                    ),
                  );
                });
              }
              final anime = controller.upcomingAnimeList[index];
              return _buildNewReleaseItem(anime, controller);
            },
          ),
        );
      }),
    );
  }

  Widget _buildNewReleaseItem(dynamic anime, AnimeController controller) {
    final imageUrl =
        anime.images?.jpg?.imageUrl ??
        anime.images?.jpg?.smallImageUrl ??
        anime.images?.webp?.smallImageUrl ??
        anime.images?.webp?.imageUrl;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.animeDetail, arguments: anime);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: CommonColors.greyTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 100,
                        height: 150,
                        color: CommonColors.greyTextColor.withOpacity(0.2),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 100,
                        height: 150,
                        color: CommonColors.greyTextColor.withOpacity(0.2),
                        child: const Icon(Icons.error_outline),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 150,
                      color: CommonColors.greyTextColor.withOpacity(0.2),
                      child: const Icon(Icons.image_not_supported),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (anime.title != null)
                      Text(
                        anime.title!,
                        style: boldTextStyle(
                          fontsize: 16,
                          color: CommonColors.whiteColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    if (anime.aired?.string != null) ...[
                      Text(
                        'Releases Date: ${anime.aired!.string}',
                        style: regularTextStyle(
                          fontsize: 12,
                          color: CommonColors.greyTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (anime.synopsis != null &&
                        anime.synopsis!.isNotEmpty) ...[
                      Text(
                        'Description: ${anime.synopsis}',
                        style: regularTextStyle(
                          fontsize: 12,
                          color: CommonColors.greyTextColor,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ] else if (anime.title != null) ...[
                      Text(
                        'Description: Information about ${anime.title}',
                        style: regularTextStyle(
                          fontsize: 12,
                          color: CommonColors.greyTextColor,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewReleaseItemShimmer() {
    return Shimmer.fromColors(
      baseColor: CommonColors.greyTextColor.withOpacity(0.2),
      highlightColor: CommonColors.greyTextColor.withOpacity(0.4),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 150,
        decoration: BoxDecoration(
          color: CommonColors.greyTextColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
