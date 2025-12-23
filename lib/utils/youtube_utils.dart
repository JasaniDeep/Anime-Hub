class YouTubeUtils {
  /// Extract YouTube video ID from various YouTube URL formats
  static String? extractVideoId(String? url) {
    if (url == null || url.isEmpty) return null;

    // Direct video ID (if already extracted)
    if (!url.contains('http') && !url.contains('www')) {
      return url;
    }

    // Extract from embed URL: https://www.youtube-nocookie.com/embed/VIDEO_ID
    final embedMatch = RegExp(r'(?:embed/|v=)([a-zA-Z0-9_-]{11})').firstMatch(url);
    if (embedMatch != null && embedMatch.groupCount >= 1) {
      return embedMatch.group(1);
    }

    // Extract from watch URL: https://www.youtube.com/watch?v=VIDEO_ID
    final watchMatch = RegExp(r'(?:watch\?v=|youtu\.be/)([a-zA-Z0-9_-]{11})').firstMatch(url);
    if (watchMatch != null && watchMatch.groupCount >= 1) {
      return watchMatch.group(1);
    }

    // Extract from short URL: https://youtu.be/VIDEO_ID
    final shortMatch = RegExp(r'youtu\.be/([a-zA-Z0-9_-]{11})').firstMatch(url);
    if (shortMatch != null && shortMatch.groupCount >= 1) {
      return shortMatch.group(1);
    }

    return null;
  }

  /// Check if a URL is a YouTube URL
  static bool isYouTubeUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return url.contains('youtube.com') || 
           url.contains('youtu.be') || 
           url.contains('youtube-nocookie.com');
  }

  /// Get YouTube watch URL from video ID
  static String getWatchUrl(String videoId) {
    return 'https://www.youtube.com/watch?v=$videoId';
  }

  /// Get YouTube embed URL from video ID
  static String getEmbedUrl(String videoId) {
    return 'https://www.youtube.com/embed/$videoId?enablejsapi=1';
  }
}

