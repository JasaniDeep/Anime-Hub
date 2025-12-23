import 'trailer_image.dart';

class Trailer {
  final String? youtubeId;
  final String? url;
  final String? embedUrl;
  final TrailerImage? images;

  Trailer({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      youtubeId: json['youtube_id'] as String?,
      url: json['url'] as String?,
      embedUrl: json['embed_url'] as String?,
      images: json['images'] != null
          ? TrailerImage.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'youtube_id': youtubeId,
      'url': url,
      'embed_url': embedUrl,
      'images': images?.toJson(),
    };
  }
}

