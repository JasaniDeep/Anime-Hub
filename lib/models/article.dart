class Article {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? url;
  final String? author;
  final DateTime? publishedAt;

  Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.author,
    this.publishedAt,
  });

  factory Article.fromMap(Map<String, dynamic> m) => Article(
    title: m['title'] ?? 'No title',
    description: m['description'],
    urlToImage: m['urlToImage'],
    url: m['url'],
    author: m['author'],
    publishedAt: m['publishedAt'] != null
        ? DateTime.tryParse(m['publishedAt'])
        : null,
  );
}
