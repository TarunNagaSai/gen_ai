# Crypto Market Features 📈

Added real-time cryptocurrency market data and charts to the app!

## New Features

### 🏠 Home Screen
- **Live crypto prices** for top coins (Bitcoin, Ethereum, Cardano, etc.)
- **7-day price charts** with smooth line graphs
- **Price change indicators** (24h) with color coding
- **Pull-to-refresh** for latest data
- **Auto-refresh** on app startup

### 📊 Coin Cards
Each crypto coin is displayed in a beautiful card with:
- **Coin symbol and name** (e.g., BTC - Bitcoin)
- **Current price** in USD
- **24h price change** percentage
- **7-day sparkline chart** showing price trends
- **Color indicators** (green for up, red for down)

### 🔄 Navigation
- **Bottom Navigation Bar** to switch between:
  - 🪙 Crypto Market (Home)
  - 💬 AI Chat

## Supported Cryptocurrencies

The app displays the following top cryptocurrencies:
1. **Bitcoin (BTC)**
2. **Ethereum (ETH)**
3. **Cardano (ADA)**
4. **Binance Coin (BNB)**
5. **Solana (SOL)**
6. **Ripple (XRP)**
7. **Polkadot (DOT)**
8. **Dogecoin (DOGE)**
9. **Avalanche (AVAX)**
10. **Chainlink (LINK)**

## Technical Details

### Data Source
- **API**: CoinGecko Public API (no API key required)
- **Update Frequency**: Manual refresh via pull-to-refresh
- **Data**: Real-time prices, 24h changes, 7-day sparkline data

### Architecture

```
lib/
├── models/
│   └── crypto_coin.dart          # Crypto coin data model
├── services/
│   └── crypto_service.dart       # CoinGecko API integration
├── providers/
│   └── crypto_provider.dart      # Riverpod state management
├── screens/
│   ├── home_screen.dart          # Crypto market screen
│   ├── main_screen.dart          # Bottom navigation
│   └── chat_screen.dart          # AI chat screen
└── widgets/
    └── crypto_chart_card.dart    # Individual coin card with chart
```

### New Dependencies
- **fl_chart**: Beautiful charts library for Flutter
- **web_socket_channel**: For future real-time updates

## Usage

### View Crypto Prices
1. Launch the app (defaults to Crypto Market screen)
2. Scroll through the list of crypto coins
3. Each card shows current price and 7-day trend

### Refresh Data
- **Pull down** on the list to refresh all prices
- Or tap the **refresh icon** in the app bar

### Switch to AI Chat
- Tap the **AI Chat** icon in the bottom navigation

## Features in Detail

### Crypto Chart Card
```dart
CryptoChartCard(
  coin: coin,  // CryptoCoin model
)
```

**Displays:**
- Coin avatar (first letter of symbol)
- Symbol and full name
- Current price (formatted)
- 24h price change with arrow indicator
- 7-day line chart with gradient fill
- Green/red color scheme based on price direction

### State Management
```dart
// Watch crypto state
final cryptoState = ref.watch(cryptoProvider);

// Access data
cryptoState.coins        // List of CryptoCoin
cryptoState.isLoading    // Loading state
cryptoState.error        // Error message if any

// Actions
ref.read(cryptoProvider.notifier).refreshCoins()
ref.read(cryptoProvider.notifier).clearError()
```

## Error Handling

The app gracefully handles:
- **Network errors**: Shows error message with retry button
- **API rate limits**: Displays helpful error message
- **No data**: Shows empty state
- **Loading states**: Shows loading indicators

## Future Enhancements

Potential additions:
1. **Real-time updates** via WebSocket
2. **More coins** (configurable list)
3. **Price alerts** (notifications)
4. **Detailed coin view** (tap to see more info)
5. **Multiple timeframes** (1h, 24h, 7d, 30d)
6. **Search coins** functionality
7. **Favorites/Watchlist**
8. **Portfolio tracking**
9. **Price comparisons**
10. **Historical data** charts

## Customization

### Change Default Coins
Edit `lib/services/crypto_service.dart`:
```dart
final ids = coinIds?.join(',') ?? 
  'bitcoin,ethereum,cardano,YOUR_COIN_HERE';
```

### Modify Chart Style
Edit `lib/widgets/crypto_chart_card.dart`:
```dart
// Change chart colors
final chartColor = isPriceUp ? Colors.green : Colors.red;

// Change chart height
SizedBox(height: 100, ...)  // Adjust height
```

### Add More Coins
Pass custom coin IDs when calling the service:
```dart
await cryptoService.getTopCoins(
  coinIds: ['bitcoin', 'ethereum', 'YOUR_COIN'],
);
```

## API Information

### CoinGecko API
- **Base URL**: https://api.coingecko.com/api/v3
- **Rate Limit**: 10-50 calls/minute (free tier)
- **No authentication** required for public endpoints
- **Documentation**: https://www.coingecko.com/api/documentation

### Endpoints Used
1. **Market Data**: `/coins/markets`
   - Gets price, changes, and sparkline data
   - Parameters: vs_currency, ids, sparkline, etc.

## Performance

- **Efficient rendering** with ListView.builder
- **Cached data** until manual refresh
- **Smooth animations** with fl_chart
- **Pull-to-refresh** for user-initiated updates
- **Error boundaries** to prevent crashes

## Testing

To test the crypto features:
```bash
# Run the app
flutter run -d chrome

# Navigate to Home screen (default)
# Pull down to refresh
# Check all coins load correctly
# Verify charts render properly
# Test error handling (disable network)
```

## Troubleshooting

### Charts not showing
- Ensure `fl_chart` is properly installed
- Check that sparkline data is present in API response

### API errors
- Verify internet connection
- Check CoinGecko API status
- Ensure rate limit not exceeded (wait 1 minute)

### No data loading
- Check network permissions
- Verify API endpoint is accessible
- Look for error messages in the UI

## Resources

- **CoinGecko API**: https://www.coingecko.com/api
- **fl_chart Docs**: https://pub.dev/packages/fl_chart
- **Riverpod**: https://riverpod.dev
- **Flutter**: https://flutter.dev
