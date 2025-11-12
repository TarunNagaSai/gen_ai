import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsState {
  final List<NewsArticle> articles;
  final bool isLoading;
  final String? error;
  final String selectedCategory;

  NewsState({
    this.articles = const [],
    this.isLoading = false,
    this.error,
    this.selectedCategory = 'All',
  });

  NewsState copyWith({
    List<NewsArticle>? articles,
    bool? isLoading,
    String? error,
    String? selectedCategory,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class NewsNotifier extends StateNotifier<NewsState> {
  final NewsService _newsService = NewsService();

  NewsNotifier() : super(NewsState()) {
    loadNews();
  }

  Future<void> loadNews({String? category}) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedCategory: category,
    );

    try {
      final articles = await _newsService.fetchNews(
        category: category ?? state.selectedCategory,
        limit: 50,
      );

      state = state.copyWith(articles: articles, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refreshNews() async {
    await loadNews(category: state.selectedCategory);
  }

  void selectCategory(String category) {
    if (category != state.selectedCategory) {
      loadNews(category: category);
    }
  }
}

final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  return NewsNotifier();
});
