# Anime Hub - Implementation Document

## Overview

Anime Hub is a Flutter mobile application built using GetX state management that displays anime movies from the Jikan API. The app features a modern, animated UI with smooth transitions, YouTube video playback, and comprehensive anime information display.

## Architecture

### Tech Stack
- **Framework**: Flutter (SDK ^3.9.2)
- **State Management**: GetX 4.7.3
- **Networking**: Dio 5.9.0
- **Image Caching**: cached_network_image 3.3.1
- **Video Player**: youtube_player_flutter 9.0.2
- **Animations**: animations 2.1.1, shimmer 3.0.0
- **Other**: url_launcher 6.2.5, intl 0.20.2

### Project Structure
```
lib/
├── constants/          # App constants (colors, text styles, API strings)
├── controllers/        # GetX controllers (AnimeController, SearchAnimeController)
├── models/            # Data models (Anime, Pagination, etc.)
├── routes/            # Navigation (routes, pages, bindings)
├── theme/             # App theme configuration
├── utils/             # Utilities (network, animations, YouTube utils)
├── view/              # UI screens
├── widgets/           # Reusable widgets
└── main.dart          # App entry point
```

## Key Features

### 1. Home Screen
- **Random Anime Hero Section**: Displays featured anime with play button
- **Trending Anime**: Horizontal scrolling list of popular anime
- **Upcoming Anime**: Horizontal scrolling list of upcoming releases
- **Pull-to-Refresh**: Refresh content by pulling down
- **Pagination**: Load more functionality for infinite scrolling

### 2. Search Screen
- **Real-time Search**: Debounced search (500ms delay)
- **2-Column Grid Layout**: Displays search results in a grid
- **Shimmer Loading**: Loading placeholders while fetching
- **Empty States**: User-friendly messages when no results found

### 3. New Releases Screen
- **Upcoming Movies List**: Displays upcoming anime movies
- **Detailed Information**: Poster, name, release date, description
- **Pagination Support**: Load more upcoming releases
- **Pull-to-Refresh**: Refresh upcoming content

### 4. Anime Detail Screen
- **Hero Image**: Large background image with overlay
- **Anime Information**: Poster, title, year, rating, genres, studio
- **YouTube Trailer**: In-app video player with full-screen support
- **Synopsis**: Detailed description of the anime
- **Related Anime**: Horizontal list of trending anime

## Data Models

### Core Models

**AnimeResponse**
- Contains pagination data and list of Anime items

**Anime**
- Complete anime information including:
  - Basic info (title, type, episodes, status)
  - Images (JPG and WEBP formats)
  - Trailer information (YouTube ID, embed URL)
  - Metadata (score, rank, popularity, members)
  - Relationships (studios, genres, themes, demographics)

**Pagination**
- Handles pagination metadata:
  - Current page, last visible page
  - Has next page flag
  - Items count and total

All models implement `fromJson()` and `toJson()` for serialization.

## Controllers (GetX)

### AnimeController
**Responsibilities:**
- Fetch top anime movies from API
- Handle pagination (load more)
- Manage loading states (initial, refresh, load more)
- Prevent duplicate API calls
- Provide helper methods (getRandomAnime, getTrendingAnime, getUpcomingAnime)

**Key Methods:**
```dart
fetchAnimeList({bool isRefresh = false})
loadMore()
refresh()
fetchUpcomingAnimeList({bool isRefresh = false})
```

**Reactive Variables:**
- `RxList<Anime> animeList` - Main anime list
- `RxList<Anime> upcomingAnimeList` - Upcoming anime list
- `RxBool isLoading`, `isLoadingMore`, `isLoadingUpcoming`
- `RxInt currentPage`, `upcomingCurrentPage`
- `RxBool hasNextPage`, `hasNextUpcomingPage`

### SearchAnimeController
**Responsibilities:**
- Handle search queries with debouncing
- Search anime from API
- Manage search results and loading states

**Key Features:**
- 500ms debounce delay to prevent excessive API calls
- Automatic cleanup of timers on dispose

## API Integration

### Base Configuration
- **Base URL**: `https://api.jikan.moe/v4/`
- **Network Handler**: Custom `ApiHandler` class using Dio
- **Error Handling**: Comprehensive error handling with user-friendly messages

### Endpoints Used
1. **Top Anime Movies**: `top/anime?type=movie&page={page}`
2. **Upcoming Anime**: `anime?type=movie&status=upcoming&order_by=start_date&sort=asc&page={page}`
3. **Search**: `anime?q={query}&limit=500`

### Response Handling
- All API responses are parsed into strongly-typed models
- Null safety throughout the application
- Graceful handling of missing or null values

## UI Components

### Reusable Widgets

**AnimeCard**
- Grid card widget for 2-column layouts
- Displays poster image, title, and rating
- Hero animation support
- Animated tap feedback

**AnimeHorizontalCard**
- Horizontal scrolling card
- Optimized for list views
- Staggered animation support

**AnimatedCard**
- Wrapper widget for animated interactions
- Scale animation on tap
- Staggered fade-in animations
- Customizable animation duration and curves

**YouTubePlayerDialog**
- In-app YouTube video player
- Full-screen mode support (only video expands)
- Custom styling matching app theme
- Proper lifecycle management

### Animation System

**AnimationUtils**
- Reusable animation builders:
  - `fadeIn()` - Smooth fade animations
  - `slideIn()` - Slide-in from offset
  - `scaleIn()` - Scale animations
  - `staggeredFadeIn()` - Sequential list animations

**Page Transitions**
- Fade transitions for splash/main navigation
- Slide transitions for search/new releases
- Cupertino-style transitions for detail pages

## YouTube Player Implementation

### Full-Screen Mode
- Uses `YoutubePlayerBuilder` for proper full-screen handling
- Only the video player expands to full-screen
- App UI remains in portrait/vertical orientation
- System UI automatically hidden in full-screen mode
- Proper cleanup on exit

### Video ID Extraction
- Supports multiple YouTube URL formats:
  - Direct video IDs
  - Embed URLs (`youtube-nocookie.com/embed/VIDEO_ID`)
  - Watch URLs (`youtube.com/watch?v=VIDEO_ID`)
  - Short URLs (`youtu.be/VIDEO_ID`)

### Configuration
```dart
YoutubePlayerFlags(
  autoPlay: true,
  mute: false,
  enableCaption: true,
  controlsVisibleAtStart: true,
  forceHD: true,
  useHybridComposition: true, // Better full-screen support
)
```

## State Management (GetX)

### Bindings
- **AnimeBinding**: Provides AnimeController
- **SearchBinding**: Provides SearchAnimeController
- **MainNavigationBinding**: Provides controllers for navigation screen

### Navigation
- Route-based navigation using GetX
- Named routes for all screens
- Smooth page transitions
- Argument passing between screens

## UI/UX Features

### Visual Design
- **Dark Theme**: Consistent dark color scheme (#0F0F0F background)
- **Red Accents**: Primary color (#E30E0D) for CTAs and highlights
- **Modern Typography**: Clear hierarchy with bold, semi-bold, regular weights
- **Card Design**: Rounded corners (12px), subtle shadows, gradients

### Micro-Interactions
- Card scale animations on tap
- Staggered list item animations
- Smooth image fade-ins
- Button press feedback
- Hero animations for image transitions

### Loading States
- Shimmer placeholders for images
- Loading indicators for API calls
- Skeleton screens matching content layout

### Error Handling
- User-friendly error messages
- Retry functionality
- Empty state illustrations
- Graceful degradation

## Performance Optimizations

1. **Image Caching**: All network images cached using `cached_network_image`
2. **Lazy Loading**: Controllers initialized only when needed (GetX lazy initialization)
3. **Debouncing**: Search queries debounced to reduce API calls
4. **Pagination**: Load data incrementally instead of all at once
5. **Efficient Animations**: Optimized animation controllers with proper disposal
6. **Hero Animations**: Smooth image transitions without reloading

## Setup Instructions

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher

### Installation Steps

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the Application**
   ```bash
   flutter run
   ```

### Configuration
- No additional configuration required
- API endpoints are pre-configured
- All dependencies are specified in `pubspec.yaml`

## Key Implementation Highlights

### 1. Clean Architecture
- Separation of concerns (models, controllers, views, widgets)
- Reusable components
- Single responsibility principle

### 2. Null Safety
- Full null safety support
- Proper null checking throughout
- Safe navigation operators

### 3. Error Resilience
- Comprehensive error handling
- User-friendly error messages
- Fallback UI states

### 4. User Experience
- Smooth animations and transitions
- Intuitive navigation
- Responsive design
- Loading states and feedback

### 5. Code Quality
- Type-safe code
- Consistent naming conventions
- Well-structured file organization
- Reusable utilities

## Future Enhancements

Potential improvements for future iterations:
- Offline caching with local database
- Favorites/bookmarks functionality
- User authentication
- Watch history tracking
- Recommendations based on viewing history
- Social features (reviews, ratings)
- Dark/light theme toggle
- Internationalization (i18n)

## Conclusion

The Anime Hub application demonstrates modern Flutter development practices with GetX state management, clean architecture, comprehensive error handling, and polished UI/UX. The implementation is production-ready with proper animations, performance optimizations, and user-centric design.

