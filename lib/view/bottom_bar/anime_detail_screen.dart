import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movie_app/models/anime.dart';
import 'package:movie_app/controllers/anime_controller.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:movie_app/widgets/anime_card.dart';
import 'package:movie_app/widgets/youtube_player_dialog.dart';
import 'package:movie_app/utils/youtube_utils.dart';
import 'package:movie_app/utils/animation_utils.dart';
import 'package:movie_app/constants/common_colors.dart';
import 'package:movie_app/constants/text_style.dart';

class AnimeDetailScreen extends StatelessWidget {
  const AnimeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final anime = Get.arguments as Anime?;
    if (anime == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Anime not found'),
        ),
      );
    }

    final controller = Get.find<AnimeController>();
    final backgroundImageUrl = anime.trailer?.images?.maximumImageUrl ??
                              anime.trailer?.images?.largeImageUrl ??
                              anime.trailer?.images?.mediumImageUrl ??
                              anime.images?.jpg?.largeImageUrl ??
                              anime.images?.jpg?.imageUrl ??
                              anime.images?.webp?.largeImageUrl ??
                              anime.images?.webp?.imageUrl;

    final posterImageUrl = anime.images?.jpg?.largeImageUrl ?? 
                          anime.images?.jpg?.imageUrl ??
                          anime.images?.webp?.largeImageUrl ??
                          anime.images?.webp?.imageUrl;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: CommonColors.whiteColor),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildBackgroundImage(backgroundImageUrl),
            ),
            expandedHeight: 300,
          ),
          SliverToBoxAdapter(
            child: AnimationUtils.fadeIn(
              duration: const Duration(milliseconds: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimationUtils.slideIn(
                    offset: const Offset(0, 0.3),
                    child: _buildOverviewSection(anime, posterImageUrl),
                  ),
                  const SizedBox(height: 24),
                  AnimationUtils.scaleIn(
                    child: _buildTrailerButton(anime, context),
                  ),
                  const SizedBox(height: 32),
                  AnimationUtils.slideIn(
                    offset: const Offset(0, 0.2),
                    child: _buildSynopsisSection(anime),
                  ),
                  const SizedBox(height: 32),
                  AnimationUtils.slideIn(
                    offset: const Offset(0, 0.2),
                    child: _buildTrendingAnimeSection(controller, anime),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String? imageUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl != null)
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: CommonColors.greyTextColor.withOpacity(0.2),
            ),
            errorWidget: (context, url, error) => Container(
              color: CommonColors.greyTextColor.withOpacity(0.2),
            ),
          )
        else
          Container(
            color: CommonColors.greyTextColor.withOpacity(0.2),
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF0F0F0F),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewSection(Anime anime, String? posterImageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (posterImageUrl != null)
            Hero(
              tag: 'anime_${anime.malId}_${posterImageUrl}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: posterImageUrl,
                    width: 110,
                    height: 160,
                    fit: BoxFit.cover,
                    fadeInDuration: AnimationUtils.normalDuration,
                    placeholder: (context, url) => Container(
                      width: 110,
                      height: 160,
                      color: CommonColors.greyTextColor.withOpacity(0.2),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: CommonColors.redColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 110,
                      height: 160,
                      color: CommonColors.greyTextColor.withOpacity(0.2),
                      child: const Icon(
                        Icons.error_outline,
                        color: CommonColors.greyTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (anime.title != null)
                  Text(
                    anime.title!,
                    style: boldTextStyle(
                      fontsize: 22,
                      color: CommonColors.whiteColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 12),
                if (anime.aired?.propFrom?.year != null)
                  Text(
                    'Year ${anime.aired!.propFrom!.year}',
                    style: regularTextStyle(
                      fontsize: 15,
                      color: CommonColors.greyTextColor,
                    ),
                  ),
                const SizedBox(height: 12),
                if (anime.score != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.amber.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Anime Rating ${anime.score!.toStringAsFixed(2)}',
                          style: semiBoldTextStyle(
                            fontsize: 15,
                            color: CommonColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (anime.genres != null && anime.genres!.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: anime.genres!.take(3).map((genre) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: CommonColors.redColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: CommonColors.redColor.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          genre.name ?? '',
                          style: regularTextStyle(
                            fontsize: 12,
                            color: CommonColors.whiteColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                if (anime.studios != null && anime.studios!.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.movie_filter,
                        size: 16,
                        color: CommonColors.greyTextColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        anime.studios!.first.name ?? '',
                        style: regularTextStyle(
                          fontsize: 14,
                          color: CommonColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailerButton(Anime anime, BuildContext context) {
    // Try to get YouTube video ID from various sources
    String? videoId;
    
    // First try direct youtubeId
    if (anime.trailer?.youtubeId != null) {
      videoId = anime.trailer!.youtubeId;
    }
    
    // Then try extracting from embed_url
    if (videoId == null && anime.trailer?.embedUrl != null) {
      videoId = YouTubeUtils.extractVideoId(anime.trailer!.embedUrl);
    }
    
    // Finally try extracting from url
    if (videoId == null && anime.trailer?.url != null) {
      videoId = YouTubeUtils.extractVideoId(anime.trailer!.url);
    }

    // If we have a video ID, show in-app player option
    if (videoId != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              _showTrailerPlayer(context, videoId!, anime.title ?? 'Trailer');
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play Trailer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.redColor,
              foregroundColor: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      );
    }

    // Fallback: try to open external URL if available
    final trailerUrl = anime.trailer?.url;
    if (trailerUrl != null && YouTubeUtils.isYouTubeUrl(trailerUrl)) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              final uri = Uri.parse(trailerUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play Trailer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.redColor,
              foregroundColor: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _showTrailerPlayer(BuildContext context, String videoId, String title) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return YouTubePlayerDialog(
          videoId: videoId,
          videoTitle: title,
        );
      },
    );
  }

  Widget _buildSynopsisSection(Anime anime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Anime Synopsis',
            style: boldTextStyle(
              fontsize: 20,
              color: CommonColors.whiteColor,
            ),
          ),
          const SizedBox(height: 12),
          if (anime.synopsis != null && anime.synopsis!.isNotEmpty)
            Text(
              anime.synopsis!,
              style: regularTextStyle(
                fontsize: 14,
                color: CommonColors.greyTextColor,
              ),
            )
          else
            Text(
              'No synopsis available.',
              style: regularTextStyle(
                fontsize: 14,
                color: CommonColors.greyTextColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrendingAnimeSection(AnimeController controller, Anime currentAnime) {
    final trendingAnime = controller.getTrendingAnime(limit: 10)
        .where((anime) => anime.malId != currentAnime.malId)
        .take(5)
        .toList();

    if (trendingAnime.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Anime',
                style: boldTextStyle(
                  fontsize: 20,
                  color: CommonColors.whiteColor,
                ),
              ),
              TextButton(
                onPressed: () {},
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
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: trendingAnime.length,
            itemBuilder: (context, index) {
              final anime = trendingAnime[index];
              return AnimeHorizontalCard(
                anime: anime,
                index: index,
                onTap: () {
                  Get.offNamed(Routes.animeDetail, arguments: anime);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

