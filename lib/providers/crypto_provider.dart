import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crypto_coin.dart';
import '../services/crypto_service.dart';

// Provider for crypto service
final cryptoServiceProvider = Provider<CryptoService>((ref) {
  return CryptoService();
});

// State class for crypto
class CryptoState {
  final List<CryptoCoin> coins;
  final bool isLoading;
  final String? error;
  final CryptoCoin? selectedCoin;

  CryptoState({
    this.coins = const [],
    this.isLoading = false,
    this.error,
    this.selectedCoin,
  });

  CryptoState copyWith({
    List<CryptoCoin>? coins,
    bool? isLoading,
    String? error,
    CryptoCoin? selectedCoin,
  }) {
    return CryptoState(
      coins: coins ?? this.coins,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedCoin: selectedCoin ?? this.selectedCoin,
    );
  }
}

// Crypto notifier
class CryptoNotifier extends StateNotifier<CryptoState> {
  final CryptoService _cryptoService;

  CryptoNotifier(this._cryptoService) : super(CryptoState()) {
    loadCoins();
  }

  Future<void> loadCoins() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final coins = await _cryptoService.getTopCoins();
      state = state.copyWith(coins: coins, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateSelectedCoin(CryptoCoin coin) {
    state = state.copyWith(selectedCoin: coin);
  }

  Future<void> refreshCoins() async {
    await loadCoins();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Crypto provider
final cryptoProvider = StateNotifierProvider<CryptoNotifier, CryptoState>((
  ref,
) {
  final cryptoService = ref.watch(cryptoServiceProvider);
  return CryptoNotifier(cryptoService);
});
