# Crypto News Feature Documentation

## Overview
The crypto news feature adds a dedicated news tab to the application that allows users to:
- Browse the latest cryptocurrency news articles
- Filter news by categories (Bitcoin, Ethereum, DeFi, NFT, Trading, Regulation)
- Share news articles to the social feed with personal commentary
- Open full articles in external browser

## Components

### 1. Models

#### NewsArticle (`lib/models/news_article.dart`)
Represents a news article with the following properties:
- `id`: Unique identifier
- `title`: Article title
- `description`: Article description/summary
- `url`: Link to full article
- `imageUrl`: Optional article image
- `source`: News source name
- `publishedAt`: Publication timestamp
- `tags`: List of category tags

#### Post Model Updates (`lib/models/post.dart`)
Added news-related fields:
- `newsTitle`: Title of shared news article
- `newsUrl`: URL of shared news article
- `newsSource`: Source of shared news article
- `hasNews`: Getter to check if post contains news

### 2. Services

#### NewsService (`lib/services/news_service.dart`)
Handles fetching crypto news from external APIs:
- Primary: CryptoCompare News API (free, no key required)
- Fallback: Mock news data for demo purposes
- Supports category filtering
- Returns list of `NewsArticle` objects

### 3. Providers

#### NewsProvider (`lib/providers/news_provider.dart`)
State management for news feature using Riverpod:
- `NewsState`: Holds articles, loading state, errors, and selected category
- `NewsNotifier`: Manages loading, refreshing, and category filtering
- Automatically loads news on initialization

#### SocialProvider Updates (`lib/providers/social_provider.dart`)
Added `createNewsPost()` method to share news articles to the feed with user commentary.

### 4. Screens

#### NewsScreen (`lib/screens/news_screen.dart`)
Main news interface featuring:
- Category filter chips (All, Bitcoin, Ethereum, DeFi, NFT, Trading, Regulation)
- Scrollable news feed with pull-to-refresh
- Share to feed functionality with thought input dialog
- Open article in browser on tap
- Loading, error, and empty states

### 5. Widgets

#### NewsCard (`lib/widgets/news_card.dart`)
Displays individual news articles with:
- Article image or gradient placeholder
- Category tags
- Title and description (truncated)
- Source and publication time
- Share button to add to social feed

#### PostCard Updates (`lib/widgets/post_card.dart`)
Enhanced to display shared news articles:
- News articles shown in special card with gradient background
- Clickable to open full article in browser
- Shows article title, source, and "Shared Article" indicator
- Uses `url_launcher` package for external links

### 6. Navigation

#### MainScreen Updates (`lib/screens/main_screen.dart`)
- Added "News" tab between "Feed" and "AI Chat"
- Updated navigation icons (newspaper icon)
- Updated index handling for AI analysis navigation

## Dependencies Added

```yaml
url_launcher: ^6.3.0  # For opening news articles in browser
```

## Usage Flow

### Browsing News
1. User taps "News" tab in bottom navigation
2. News articles load automatically from API
3. User can filter by category using chips
4. Pull down to refresh news
5. Tap article card to read full article in browser

### Sharing News to Feed
1. User taps share button on news card
2. Share dialog appears with article preview
3. User adds personal thoughts/commentary
4. User taps "Share to Feed" button
5. Post appears in social feed with news article card
6. Others can click news card in feed to read article

### Viewing Shared News in Feed
1. News posts appear in social feed with special styling
2. Shows user's commentary and news article preview
3. Click news card to open full article
4. Can like, repost, or share like any other post

## API Information

### CryptoCompare News API
- **Endpoint**: `https://min-api.cryptocompare.com/data/v2/news/`
- **Free tier**: No API key required for basic usage
- **Rate limits**: Generally sufficient for app usage
- **Fallback**: Mock data automatically used if API fails

### Mock Data
The app includes 8 sample news articles covering:
- Bitcoin price movements
- Ethereum upgrades
- DeFi protocols
- NFT market
- Banking adoption
- Cardano partnerships
- Regulatory frameworks
- Solana network improvements

## Future Enhancements

Potential improvements for future versions:
1. Bookmark/save articles for later
2. Search functionality for news
3. Multiple news source integration
4. Personalized news recommendations
5. Push notifications for breaking news
6. Comments on shared news articles
7. News article analytics (trending topics)
8. Dark mode optimized news cards
9. Offline reading capability
10. News article sharing to external apps

## Testing

To test the feature:
1. Run the app: `flutter run`
2. Navigate to the "News" tab
3. Try different category filters
4. Test pull-to-refresh
5. Share an article to feed
6. Check the feed to see shared article
7. Tap on shared article to open in browser

## Technical Notes

- News articles are fetched on provider initialization
- Category changes trigger new API calls
- Images may fail to load (handled with placeholder)
- URL launching requires platform-specific setup (iOS/Android)
- Posts with news are identifiable via `hasNews` getter
- News data is not persisted (fetched fresh each time)
