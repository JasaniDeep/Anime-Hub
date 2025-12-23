class APIString {
  APIString._();

  // Base URL
  static const String baseURL = 'https://api.jikan.moe/v4/';
  static const String topAnimeApi = 'top/anime?type=movie';
  static const String searchAnimeApi = 'anime';
  static const String upcomingAnimeApi = 'anime?type=movie&status=upcoming&order_by=start_date&sort=asc';
}
