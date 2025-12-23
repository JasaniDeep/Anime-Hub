import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/common_colors.dart';
import 'package:movie_app/constants/text_style.dart';
import 'package:movie_app/controllers/anime_controller.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:movie_app/utils/animation_utils.dart';
import 'package:movie_app/utils/youtube_utils.dart';
import 'package:movie_app/widgets/anime_card.dart';
import 'package:movie_app/widgets/anime_shimmer.dart';
import 'package:movie_app/widgets/youtube_player_dialog.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        color: CommonColors.redColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu, color: CommonColors.whiteColor),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings, color: CommonColors.whiteColor),
                  onPressed: () {},
                ),
              ],
            ),
            Obx(() {
              if (controller.isLoading.value && controller.animeList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildRandomAnimeShimmer(),
                      const SizedBox(height: 24),
                      _buildSectionShimmer('Trending Anime'),
                      const SizedBox(height: 24),
                      _buildSectionShimmer('Upcoming Anime'),
                    ],
                  ),
                );
              }

              if (controller.animeList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        controller.errorMessage.value.isNotEmpty
                            ? controller.errorMessage.value
                            : 'No anime found',
                        style: regularTextStyle(
                          fontsize: 16,
                          color: CommonColors.greyTextColor,
                        ),
                      ),
                    ),
                  ),
                );
              }

              final randomAnime = controller.getRandomAnime();
              final trendingAnime = controller.getTrendingAnime();
              final upcomingAnime = controller.getUpcomingAnime(limit: 10);

              return SliverToBoxAdapter(
                child: AnimationUtils.fadeIn(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (randomAnime != null)
                        AnimationUtils.scaleIn(
                          child: _buildRandomAnimeSection(
                            context,
                            randomAnime,
                            controller,
                          ),
                        ),
                      const SizedBox(height: 32),
                      AnimationUtils.slideIn(
                        offset: const Offset(0, 0.2),
                        child: _buildSectionHeader('Trending Anime', () {}),
                      ),
                      const SizedBox(height: 16),
                      _buildHorizontalAnimeList(trendingAnime, controller),
                      const SizedBox(height: 32),
                      AnimationUtils.slideIn(
                        offset: const Offset(0, 0.2),
                        child: _buildSectionHeader('Upcoming Anime', () {}),
                      ),
                      const SizedBox(height: 16),
                      _buildHorizontalAnimeList(upcomingAnime, controller),
                      const SizedBox(height: 32),
                      if (controller.hasNextPage.value)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Obx(() {
                            if (controller.isLoadingMore.value) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: CommonColors.redColor,
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: controller.loadMore,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CommonColors.redColor,
                                foregroundColor: CommonColors.whiteColor,
                              ),
                              child: const Text('Load More'),
                            );
                          }),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRandomAnimeSection(
    BuildContext context,
    dynamic anime,
    AnimeController controller,
  ) {
    final imageUrl =
        anime.images?.jpg?.largeImageUrl ??
        anime.images?.jpg?.imageUrl ??
        anime.images?.webp?.largeImageUrl ??
        anime.images?.webp?.imageUrl;

    return Hero(
      tag: 'hero_anime_${anime.malId}',
      child: Container(
        height: 450,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CommonColors.greyTextColor.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageUrl != null)
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: AnimationUtils.normalDuration,
                  fadeOutDuration: AnimationUtils.fastDuration,
                  placeholder: (context, url) => Container(
                    color: CommonColors.greyTextColor.withOpacity(0.2),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: CommonColors.redColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: CommonColors.greyTextColor.withOpacity(0.2),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 32,
                left: 24,
                right: 24,
                child: AnimationUtils.fadeIn(
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (anime.title != null)
                        Text(
                          anime.title!,
                          style: boldTextStyle(
                            fontsize: 28,
                            color: CommonColors.whiteColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildAnimatedButton(
                            context: context,
                            onPressed: () => _handlePlayButton(context, anime),
                            icon: Icons.play_arrow,
                            label: 'Play',
                            isPrimary: true,
                          ),
                          const SizedBox(width: 12),
                          _buildAnimatedButton(
                            context: context,
                            onPressed: () {},
                            icon: Icons.add,
                            label: 'My List',
                            isPrimary: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: isPrimary ? CommonColors.redColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isPrimary
                ? null
                : Border.all(color: CommonColors.whiteColor, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: CommonColors.whiteColor, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: semiBoldTextStyle(
                  fontsize: 15,
                  color: CommonColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRandomAnimeShimmer() {
    return Shimmer.fromColors(
      baseColor: CommonColors.greyTextColor.withOpacity(0.2),
      highlightColor: CommonColors.greyTextColor.withOpacity(0.4),
      child: Container(
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CommonColors.greyTextColor,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: boldTextStyle(fontsize: 20, color: CommonColors.whiteColor),
          ),
          TextButton(
            onPressed: onViewAll,
            child: Text(
              'View All',
              style: mediumTextStyle(
                fontsize: 14,
                color: CommonColors.redColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalAnimeList(
    List<dynamic> animeList,
    AnimeController controller,
  ) {
    if (animeList.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime = animeList[index];
          return AnimeHorizontalCard(
            anime: anime,
            index: index,
            onTap: () {
              Get.toNamed(Routes.animeDetail, arguments: anime);
            },
          );
        },
      ),
    );
  }

  Widget _buildSectionShimmer(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: boldTextStyle(fontsize: 20, color: CommonColors.whiteColor),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) {
              return AnimeHorizontalCardShimmer();
            },
          ),
        ),
      ],
    );
  }

  void _handlePlayButton(BuildContext context, dynamic anime) {
    // Try to extract YouTube video ID from trailer
    String? videoId;

    if (anime.trailer?.youtubeId != null) {
      videoId = anime.trailer!.youtubeId;
    } else if (anime.trailer?.embedUrl != null) {
      videoId = YouTubeUtils.extractVideoId(anime.trailer!.embedUrl);
    } else if (anime.trailer?.url != null) {
      videoId = YouTubeUtils.extractVideoId(anime.trailer!.url);
    }

    // If we have a video ID, show in-app player
    if (videoId != null) {
      showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (BuildContext context) {
          return YouTubePlayerDialog(
            videoId: videoId!,
            videoTitle: anime.title ?? 'Trailer',
          );
        },
      );
    } else {
      // No trailer available, navigate to detail page
      Get.toNamed(Routes.animeDetail, arguments: anime);
    }
  }
}
