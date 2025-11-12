import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  // Using CryptoCompare News API (free, no API key needed for basic usage)
  static const String _baseUrl = 'https://min-api.cryptocompare.com/data/v2/news/';
  static const String _spaceflightNewsUrl =
      'https://api.spaceflightnewsapi.net/v4/articles';

  Future<List<NewsArticle>> fetchNews({
    String? category,
    int limit = 50,
  }) async {
    try {
      final url = category != null && category != 'All'
          ? '$_baseUrl?categories=${category.toUpperCase()}&limit=$limit'
          : '$_baseUrl?limit=$limit';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> newsData = data['Data'] ?? [];

        return newsData
            .map((article) => _parseCryptoCompareArticle(article))
            .toList();
      } else {
        // Fallback to mock data
        return _getMockNews(category);
      }
    } catch (e) {
      // Return mock data on error
      return _getMockNews(category);
    }
  }

  NewsArticle _parseCryptoCompareArticle(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['imageurl'],
      source: json['source'] ?? 'CryptoCompare',
      publishedAt: DateTime.fromMillisecondsSinceEpoch(
        (json['published_on'] ?? 0) * 1000,
      ),
      tags: (json['tags']?.split('|') ?? []).cast<String>(),
    );
  }

  List<NewsArticle> _getMockNews(String? category) {
    final now = DateTime.now();

    final allNews = [
      NewsArticle(
        id: '1',
        title: 'Bitcoin Surges Past \$45,000 as Institutional Investment Grows',
        description:
            'Bitcoin has broken through the \$45,000 resistance level as major institutions continue to add cryptocurrency to their portfolios. Analysts suggest this could be the start of a new bull run.',
        url: 'https://example.com/news/1',
        imageUrl: null,
        source: 'CryptoNews',
        publishedAt: now.subtract(const Duration(hours: 2)),
        tags: ['Bitcoin', 'BTC', 'Market'],
      ),
      NewsArticle(
        id: '2',
        title:
            'Ethereum 2.0 Upgrade Shows Promising Results in Network Efficiency',
        description:
            'The Ethereum network has seen significant improvements in transaction speed and reduced gas fees following recent upgrades. Developers report increased scalability.',
        url: 'https://example.com/news/2',
        imageUrl: null,
        source: 'EthNews',
        publishedAt: now.subtract(const Duration(hours: 5)),
        tags: ['Ethereum', 'ETH', 'Technology'],
      ),
      NewsArticle(
        id: '3',
        title: 'DeFi Protocol Launches Revolutionary Lending Platform',
        description:
            'A new decentralized finance protocol has launched, offering competitive lending rates and innovative collateral options for cryptocurrency holders.',
        url: 'https://example.com/news/3',
        imageUrl: null,
        source: 'DeFi Daily',
        publishedAt: now.subtract(const Duration(hours: 8)),
        tags: ['DeFi', 'Lending'],
      ),
      NewsArticle(
        id: '4',
        title: 'Major Bank Announces Cryptocurrency Trading Services',
        description:
            'A leading international bank has announced it will offer cryptocurrency trading services to its customers, marking a significant shift in traditional banking.',
        url: 'https://example.com/news/4',
        imageUrl: null,
        source: 'Financial Times',
        publishedAt: now.subtract(const Duration(hours: 12)),
        tags: ['Bitcoin', 'Banking', 'Adoption'],
      ),
      NewsArticle(
        id: '5',
        title: 'NFT Market Sees Resurgence with New Gaming Projects',
        description:
            'The NFT market is experiencing renewed interest as major gaming companies announce blockchain-based gaming initiatives.',
        url: 'https://example.com/news/5',
        imageUrl: null,
        source: 'NFT Insider',
        publishedAt: now.subtract(const Duration(days: 1)),
        tags: ['NFT', 'Gaming'],
      ),
      NewsArticle(
        id: '6',
        title: 'Cardano Announces Strategic Partnership with Tech Giant',
        description:
            'Cardano has formed a strategic partnership with a major technology company to develop blockchain solutions for supply chain management.',
        url: 'https://example.com/news/6',
        imageUrl: null,
        source: 'Blockchain News',
        publishedAt: now.subtract(const Duration(days: 1, hours: 3)),
        tags: ['Cardano', 'ADA', 'Partnership'],
      ),
      NewsArticle(
        id: '7',
        title: 'Regulatory Framework for Crypto Assets Gains Momentum',
        description:
            'Several countries are working together to establish a comprehensive regulatory framework for cryptocurrency assets, aiming to protect investors while fostering innovation.',
        url: 'https://example.com/news/7',
        imageUrl: null,
        source: 'Regulatory Watch',
        publishedAt: now.subtract(const Duration(days: 2)),
        tags: ['Regulation', 'Policy'],
      ),
      NewsArticle(
        id: '8',
        title: 'Solana Network Upgrade Improves Transaction Throughput',
        description:
            'Solana has successfully implemented a network upgrade that significantly increases transaction throughput while maintaining low fees.',
        url: 'https://example.com/news/8',
        imageUrl: null,
        source: 'Solana News',
        publishedAt: now.subtract(const Duration(days: 2, hours: 6)),
        tags: ['Solana', 'SOL', 'Technology'],
      ),
    ];

    if (category == null || category == 'All') {
      return allNews;
    }

    return allNews.where((article) {
      return article.tags.any(
            (tag) => tag.toLowerCase().contains(category.toLowerCase()),
          ) ||
          article.title.toLowerCase().contains(category.toLowerCase());
    }).toList();
  }

  Future<List<String>> getCategories() async {
    return [
      'All',
      'Bitcoin',
      'Ethereum',
      'DeFi',
      'NFT',
      'Trading',
      'Regulation',
    ];
  }
}
