class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String content;
  final String? cryptoSymbol;
  final String? cryptoName;
  final double? cryptoPrice;
  final double? priceChange;
  final DateTime timestamp;
  final int likes;
  final int reposts;
  final List<String> likedBy;
  final String? originalPostId; // For reposts
  final Post? originalPost; // Reference to original post if repost

  // News article fields
  final String? newsTitle;
  final String? newsUrl;
  final String? newsSource;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.content,
    this.cryptoSymbol,
    this.cryptoName,
    this.cryptoPrice,
    this.priceChange,
    required this.timestamp,
    this.likes = 0,
    this.reposts = 0,
    this.likedBy = const [],
    this.originalPostId,
    this.originalPost,
    this.newsTitle,
    this.newsUrl,
    this.newsSource,
  });

  bool get isRepost => originalPostId != null;
  bool get hasNews => newsTitle != null;

  Post copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? content,
    String? cryptoSymbol,
    String? cryptoName,
    double? cryptoPrice,
    double? priceChange,
    DateTime? timestamp,
    int? likes,
    int? reposts,
    List<String>? likedBy,
    String? originalPostId,
    Post? originalPost,
    String? newsTitle,
    String? newsUrl,
    String? newsSource,
  }) {
    return Post(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      content: content ?? this.content,
      cryptoSymbol: cryptoSymbol ?? this.cryptoSymbol,
      cryptoName: cryptoName ?? this.cryptoName,
      cryptoPrice: cryptoPrice ?? this.cryptoPrice,
      priceChange: priceChange ?? this.priceChange,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      reposts: reposts ?? this.reposts,
      likedBy: likedBy ?? this.likedBy,
      originalPostId: originalPostId ?? this.originalPostId,
      originalPost: originalPost ?? this.originalPost,
      newsTitle: newsTitle ?? this.newsTitle,
      newsUrl: newsUrl ?? this.newsUrl,
      newsSource: newsSource ?? this.newsSource,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
      'cryptoSymbol': cryptoSymbol,
      'cryptoName': cryptoName,
      'cryptoPrice': cryptoPrice,
      'priceChange': priceChange,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'reposts': reposts,
      'likedBy': likedBy,
      'originalPostId': originalPostId,
      'newsTitle': newsTitle,
      'newsUrl': newsUrl,
      'newsSource': newsSource,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      content: json['content'] as String,
      cryptoSymbol: json['cryptoSymbol'] as String?,
      cryptoName: json['cryptoName'] as String?,
      cryptoPrice: (json['cryptoPrice'] as num?)?.toDouble(),
      priceChange: (json['priceChange'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      reposts: (json['reposts'] as num?)?.toInt() ?? 0,
      likedBy: (json['likedBy'] as List?)?.cast<String>() ?? [],
      originalPostId: json['originalPostId'] as String?,
      newsTitle: json['newsTitle'] as String?,
      newsUrl: json['newsUrl'] as String?,
      newsSource: json['newsSource'] as String?,
    );
  }
}
