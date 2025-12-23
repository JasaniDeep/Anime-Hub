import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/models/anime.dart';
import 'package:movie_app/constants/common_colors.dart';
import 'package:movie_app/constants/text_style.dart';
import 'package:movie_app/widgets/animated_card.dart';
import 'package:movie_app/utils/animation_utils.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final int? index;

  const AnimeCard({
    super.key,
    required this.anime,
    this.onTap,
    this.width,
    this.height,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = anime.images?.jpg?.largeImageUrl ?? 
                    anime.images?.jpg?.imageUrl ??
                    anime.images?.webp?.largeImageUrl ??
                    anime.images?.webp?.imageUrl;

    return AnimatedCard(
      onTap: onTap,
      index: index,
      enableScale: true,
      child: _buildCard(context, imageUrl),
    );
  }

  Widget _buildCard(BuildContext context, String? imageUrl) {
    return Hero(
      tag: 'anime_${anime.malId}_${imageUrl ?? 'default'}',
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CommonColors.greyTextColor.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
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
                        strokeWidth: 2,
                        color: CommonColors.redColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: CommonColors.greyTextColor.withOpacity(0.2),
                    child: const Icon(
                      Icons.error_outline,
                      color: CommonColors.greyTextColor,
                    ),
                  ),
                )
              else
                Container(
                  color: CommonColors.greyTextColor.withOpacity(0.2),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: CommonColors.greyTextColor,
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (anime.title != null)
                        Text(
                          anime.title!,
                          style: semiBoldTextStyle(
                            fontsize: 13,
                            color: CommonColors.whiteColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (anime.score != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              anime.score!.toStringAsFixed(2),
                              style: semiBoldTextStyle(
                                fontsize: 13,
                                color: CommonColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
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
}

class AnimeHorizontalCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final int? index;

  const AnimeHorizontalCard({
    super.key,
    required this.anime,
    this.onTap,
    this.width,
    this.height,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = anime.images?.jpg?.largeImageUrl ?? 
                    anime.images?.jpg?.imageUrl ??
                    anime.images?.webp?.largeImageUrl ??
                    anime.images?.webp?.imageUrl;

    return AnimatedCard(
      onTap: onTap,
      index: index,
      enableScale: true,
      child: Container(
        width: width ?? 140,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'anime_horizontal_${anime.malId}_${imageUrl ?? 'default'}',
              child: Container(
                height: height ?? 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: CommonColors.greyTextColor.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          fadeInDuration: AnimationUtils.normalDuration,
                          fadeOutDuration: AnimationUtils.fastDuration,
                          placeholder: (context, url) => Container(
                            color: CommonColors.greyTextColor.withOpacity(0.2),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: CommonColors.redColor,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: CommonColors.greyTextColor.withOpacity(0.2),
                            child: const Icon(
                              Icons.error_outline,
                              color: CommonColors.greyTextColor,
                            ),
                          ),
                        )
                      : Container(
                          color: CommonColors.greyTextColor.withOpacity(0.2),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: CommonColors.greyTextColor,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (anime.title != null)
              Text(
                anime.title!,
                style: mediumTextStyle(
                  fontsize: 14,
                  color: CommonColors.whiteColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (anime.score != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    anime.score!.toStringAsFixed(2),
                    style: semiBoldTextStyle(
                      fontsize: 12,
                      color: CommonColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

