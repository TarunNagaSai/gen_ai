class CryptoCoin {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final List<double> sparklineData;

  CryptoCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.sparklineData,
  });

  factory CryptoCoin.fromJson(Map<String, dynamic> json) {
    return CryptoCoin(
      id: json['id'] as String,
      symbol: (json['symbol'] as String).toUpperCase(),
      name: json['name'] as String,
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
      sparklineData: json['sparkline_in_7d'] != null
          ? List<double>.from(
              (json['sparkline_in_7d']['price'] as List).map(
                (e) => (e as num).toDouble(),
              ),
            )
          : [],
    );
  }

  bool get isPriceUp => priceChangePercentage24h >= 0;

  String get formattedPrice {
    if (currentPrice >= 1000) {
      return '\$${currentPrice.toStringAsFixed(0)}';
    } else if (currentPrice >= 1) {
      return '\$${currentPrice.toStringAsFixed(2)}';
    } else {
      return '\$${currentPrice.toStringAsFixed(4)}';
    }
  }

  String get formattedPriceChange {
    final prefix = isPriceUp ? '+' : '';
    return '$prefix${priceChangePercentage24h.toStringAsFixed(2)}%';
  }

  String toAIAnalysisPrompt() {
    final trend = isPriceUp ? 'upward' : 'downward';
    final minPrice = sparklineData.isNotEmpty
        ? sparklineData.reduce((a, b) => a < b ? a : b).toStringAsFixed(2)
        : 'N/A';
    final maxPrice = sparklineData.isNotEmpty
        ? sparklineData.reduce((a, b) => a > b ? a : b).toStringAsFixed(2)
        : 'N/A';

    return '''
Analyze the following cryptocurrency data and provide a brief prediction:

Cryptocurrency: $name ($symbol)
Current Price: $formattedPrice
24h Price Change: $formattedPriceChange ($trend trend)
7-Day Low: \$$minPrice
7-Day High: \$$maxPrice

Based on this data, please provide:
1. A brief market sentiment analysis
2. Short-term price prediction (next 24-48 hours)
3. Key factors to watch
4. Risk assessment (Low/Medium/High)

Keep the response concise and focused on actionable insights.''';
  }
}
