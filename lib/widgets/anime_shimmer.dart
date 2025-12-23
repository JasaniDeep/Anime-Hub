import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_app/constants/common_colors.dart';

class AnimeCardShimmer extends StatelessWidget {
  final double? width;
  final double? height;

  const AnimeCardShimmer({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CommonColors.greyTextColor.withOpacity(0.2),
      highlightColor: CommonColors.greyTextColor.withOpacity(0.4),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CommonColors.greyTextColor,
        ),
      ),
    );
  }
}

class AnimeHorizontalCardShimmer extends StatelessWidget {
  final double? width;
  final double? height;

  const AnimeHorizontalCardShimmer({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CommonColors.greyTextColor.withOpacity(0.2),
      highlightColor: CommonColors.greyTextColor.withOpacity(0.4),
      child: Container(
        width: width ?? 140,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height ?? 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CommonColors.greyTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: CommonColors.greyTextColor,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 12,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: CommonColors.greyTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

