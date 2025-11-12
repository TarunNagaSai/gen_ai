import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_coin.dart';

class CryptoService {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<CryptoCoin>> getTopCoins({
    List<String>? coinIds,
    int perPage = 10,
  }) async {
    try {
      final ids =
          coinIds?.join(',') ??
          'bitcoin,ethereum,cardano,binancecoin,solana,ripple,polkadot,dogecoin,avalanche-2,chainlink';

      final response = await http.get(
        Uri.parse(
          '$baseUrl/coins/markets?vs_currency=usd&ids=$ids&order=market_cap_desc&per_page=$perPage&page=1&sparkline=true&price_change_percentage=24h',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CryptoCoin.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load crypto data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch crypto data: $e');
    }
  }

  Future<CryptoCoin> getCoinDetails(String coinId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/coins/markets?vs_currency=usd&ids=$coinId&sparkline=true',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return CryptoCoin.fromJson(data[0]);
        } else {
          throw Exception('Coin not found');
        }
      } else {
        throw Exception('Failed to load coin details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch coin details: $e');
    }
  }
}
