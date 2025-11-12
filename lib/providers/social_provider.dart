import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/post.dart';
import '../models/crypto_coin.dart';
import '../models/news_article.dart';

// State class for social feed
class SocialState {
  final List<Post> posts;
  final bool isLoading;
  final String? error;

  SocialState({this.posts = const [], this.isLoading = false, this.error});

  SocialState copyWith({List<Post>? posts, bool? isLoading, String? error}) {
    return SocialState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Social feed notifier
class SocialNotifier extends StateNotifier<SocialState> {
  final Uuid _uuid = const Uuid();
  final String _currentUserId = 'user_1'; // In real app, get from auth
  final String _currentUserName = 'You'; // In real app, get from auth

  SocialNotifier() : super(SocialState()) {
    _loadSamplePosts();
  }

  void _loadSamplePosts() {
    // Load some sample posts for demo
    final samplePosts = [
      Post(
        id: _uuid.v4(),
        authorId: 'user_2',
        authorName: 'Crypto Trader',
        content:
            'Bitcoin is showing strong support at \$40k. Bullish momentum building! 🚀',
        cryptoSymbol: 'BTC',
        cryptoName: 'Bitcoin',
        cryptoPrice: 40234.56,
        priceChange: 3.45,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        likes: 24,
        reposts: 5,
      ),
      Post(
        id: _uuid.v4(),
        authorId: 'user_3',
        authorName: 'Market Analyst',
        content: 'Ethereum gas fees dropping. Good time for DeFi transactions!',
        cryptoSymbol: 'ETH',
        cryptoName: 'Ethereum',
        cryptoPrice: 2234.89,
        priceChange: 1.23,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        likes: 18,
        reposts: 3,
      ),
    ];

    state = state.copyWith(posts: samplePosts);
  }

  void createPost({required String content, CryptoCoin? coin}) {
    final newPost = Post(
      id: _uuid.v4(),
      authorId: _currentUserId,
      authorName: _currentUserName,
      content: content,
      cryptoSymbol: coin?.symbol,
      cryptoName: coin?.name,
      cryptoPrice: coin?.currentPrice,
      priceChange: coin?.priceChangePercentage24h,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(posts: [newPost, ...state.posts]);
  }

  void createNewsPost({required String content, required NewsArticle article}) {
    final newPost = Post(
      id: _uuid.v4(),
      authorId: _currentUserId,
      authorName: _currentUserName,
      content: content,
      timestamp: DateTime.now(),
      newsTitle: article.title,
      newsUrl: article.url,
      newsSource: article.source,
    );

    state = state.copyWith(posts: [newPost, ...state.posts]);
  }

  void repost(Post originalPost) {
    final repost = Post(
      id: _uuid.v4(),
      authorId: _currentUserId,
      authorName: _currentUserName,
      content: '', // Reposts don't have additional content
      timestamp: DateTime.now(),
      originalPostId: originalPost.id,
      originalPost: originalPost,
    );

    // Update original post repost count
    final updatedPosts = state.posts.map((post) {
      if (post.id == originalPost.id) {
        return post.copyWith(reposts: post.reposts + 1);
      }
      return post;
    }).toList();

    state = state.copyWith(posts: [repost, ...updatedPosts]);
  }

  void toggleLike(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        final isLiked = post.likedBy.contains(_currentUserId);
        final newLikedBy = isLiked
            ? post.likedBy.where((id) => id != _currentUserId).toList()
            : [...post.likedBy, _currentUserId];

        return post.copyWith(
          likes: isLiked ? post.likes - 1 : post.likes + 1,
          likedBy: newLikedBy,
        );
      }
      return post;
    }).toList();

    state = state.copyWith(posts: updatedPosts);
  }

  void deletePost(String postId) {
    final updatedPosts = state.posts
        .where((post) => post.id != postId)
        .toList();
    state = state.copyWith(posts: updatedPosts);
  }

  bool isLikedByCurrentUser(Post post) {
    return post.likedBy.contains(_currentUserId);
  }

  bool isOwnPost(Post post) {
    return post.authorId == _currentUserId;
  }
}

// Social provider
final socialProvider = StateNotifierProvider<SocialNotifier, SocialState>((
  ref,
) {
  return SocialNotifier();
});
