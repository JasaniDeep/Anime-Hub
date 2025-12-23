class AnimeTitle {
  final String? type;
  final String? title;

  AnimeTitle({
    this.type,
    this.title,
  });

  factory AnimeTitle.fromJson(Map<String, dynamic> json) {
    return AnimeTitle(
      type: json['type'] as String?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
    };
  }
}

