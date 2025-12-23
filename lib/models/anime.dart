import 'anime_images.dart';
import 'trailer.dart';
import 'anime_title.dart';
import 'aired.dart';
import 'broadcast.dart';
import 'studio.dart';
import 'genre.dart';

class Anime {
  final int? malId;
  final String? url;
  final AnimeImages? images;
  final Trailer? trailer;
  final bool? approved;
  final List<AnimeTitle>? titles;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final List<String>? titleSynonyms;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool? airing;
  final Aired? aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final String? background;
  final String? season;
  final int? year;
  final Broadcast? broadcast;
  final List<Studio>? producers;
  final List<Studio>? licensors;
  final List<Studio>? studios;
  final List<Genre>? genres;
  final List<Genre>? explicitGenres;
  final List<Genre>? themes;
  final List<Genre>? demographics;

  Anime({
    this.malId,
    this.url,
    this.images,
    this.trailer,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.broadcast,
    this.producers,
    this.licensors,
    this.studios,
    this.genres,
    this.explicitGenres,
    this.themes,
    this.demographics,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'] as int?,
      url: json['url'] as String?,
      images: json['images'] != null
          ? AnimeImages.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      trailer: json['trailer'] != null
          ? Trailer.fromJson(json['trailer'] as Map<String, dynamic>)
          : null,
      approved: json['approved'] as bool?,
      titles: json['titles'] != null
          ? (json['titles'] as List<dynamic>)
              .map((e) => AnimeTitle.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      title: json['title'] as String?,
      titleEnglish: json['title_english'] as String?,
      titleJapanese: json['title_japanese'] as String?,
      titleSynonyms: json['title_synonyms'] != null
          ? (json['title_synonyms'] as List<dynamic>).cast<String>()
          : null,
      type: json['type'] as String?,
      source: json['source'] as String?,
      episodes: json['episodes'] as int?,
      status: json['status'] as String?,
      airing: json['airing'] as bool?,
      aired: json['aired'] != null
          ? Aired.fromJson(json['aired'] as Map<String, dynamic>)
          : null,
      duration: json['duration'] as String?,
      rating: json['rating'] as String?,
      score: json['score'] != null ? (json['score'] as num).toDouble() : null,
      scoredBy: json['scored_by'] as int?,
      rank: json['rank'] as int?,
      popularity: json['popularity'] as int?,
      members: json['members'] as int?,
      favorites: json['favorites'] as int?,
      synopsis: json['synopsis'] as String?,
      background: json['background'] as String?,
      season: json['season'] as String?,
      year: json['year'] as int?,
      broadcast: json['broadcast'] != null
          ? Broadcast.fromJson(json['broadcast'] as Map<String, dynamic>)
          : null,
      producers: json['producers'] != null
          ? (json['producers'] as List<dynamic>)
              .map((e) => Studio.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      licensors: json['licensors'] != null
          ? (json['licensors'] as List<dynamic>)
              .map((e) => Studio.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      studios: json['studios'] != null
          ? (json['studios'] as List<dynamic>)
              .map((e) => Studio.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      genres: json['genres'] != null
          ? (json['genres'] as List<dynamic>)
              .map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      explicitGenres: json['explicit_genres'] != null
          ? (json['explicit_genres'] as List<dynamic>)
              .map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      themes: json['themes'] != null
          ? (json['themes'] as List<dynamic>)
              .map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      demographics: json['demographics'] != null
          ? (json['demographics'] as List<dynamic>)
              .map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'url': url,
      'images': images?.toJson(),
      'trailer': trailer?.toJson(),
      'approved': approved,
      'titles': titles?.map((e) => e.toJson()).toList(),
      'title': title,
      'title_english': titleEnglish,
      'title_japanese': titleJapanese,
      'title_synonyms': titleSynonyms,
      'type': type,
      'source': source,
      'episodes': episodes,
      'status': status,
      'airing': airing,
      'aired': aired?.toJson(),
      'duration': duration,
      'rating': rating,
      'score': score,
      'scored_by': scoredBy,
      'rank': rank,
      'popularity': popularity,
      'members': members,
      'favorites': favorites,
      'synopsis': synopsis,
      'background': background,
      'season': season,
      'year': year,
      'broadcast': broadcast?.toJson(),
      'producers': producers?.map((e) => e.toJson()).toList(),
      'licensors': licensors?.map((e) => e.toJson()).toList(),
      'studios': studios?.map((e) => e.toJson()).toList(),
      'genres': genres?.map((e) => e.toJson()).toList(),
      'explicit_genres': explicitGenres?.map((e) => e.toJson()).toList(),
      'themes': themes?.map((e) => e.toJson()).toList(),
      'demographics': demographics?.map((e) => e.toJson()).toList(),
    };
  }
}

