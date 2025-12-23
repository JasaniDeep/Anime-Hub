import 'pagination.dart';
import 'anime.dart';

class AnimeResponse {
  final Pagination? pagination;
  final List<Anime>? data;

  AnimeResponse({
    this.pagination,
    this.data,
  });

  factory AnimeResponse.fromJson(Map<String, dynamic> json) {
    return AnimeResponse(
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((e) => Anime.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagination': pagination?.toJson(),
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

