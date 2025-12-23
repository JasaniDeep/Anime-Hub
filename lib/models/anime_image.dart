class AnimeImage {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  AnimeImage({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  factory AnimeImage.fromJson(Map<String, dynamic> json) {
    return AnimeImage(
      imageUrl: json['image_url'] as String?,
      smallImageUrl: json['small_image_url'] as String?,
      largeImageUrl: json['large_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'small_image_url': smallImageUrl,
      'large_image_url': largeImageUrl,
    };
  }
}

