import 'anime_image.dart';

class AnimeImages {
  final AnimeImage? jpg;
  final AnimeImage? webp;

  AnimeImages({
    this.jpg,
    this.webp,
  });

  factory AnimeImages.fromJson(Map<String, dynamic> json) {
    return AnimeImages(
      jpg: json['jpg'] != null ? AnimeImage.fromJson(json['jpg'] as Map<String, dynamic>) : null,
      webp: json['webp'] != null ? AnimeImage.fromJson(json['webp'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jpg': jpg?.toJson(),
      'webp': webp?.toJson(),
    };
  }
}

