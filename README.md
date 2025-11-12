# AI Chat & Crypto App 🤖📈

A modern, production-ready Flutter application featuring AI chat with OpenAI integration and real-time cryptocurrency market data. Built with clean architecture and Riverpod state management.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.9.2+-blue.svg)
![Riverpod](https://img.shields.io/badge/Riverpod-2.6.1-purple.svg)

## ✨ Features

### 💬 AI Chat
- Real-time AI chat with OpenAI GPT models
- Streaming responses for instant feedback
- Modern chat UI with message bubbles
- Typing indicators and animations

### 📈 Crypto Market
- Live cryptocurrency prices (BTC, ETH, ADA, etc.)
- 7-day price charts with smooth graphs
- 24h price change indicators
- Pull-to-refresh for latest data
- Beautiful card-based layout

### 🎨 Design
- Modern Material Design 3 UI
- Dark and light theme support
- Smooth animations and transitions
- Bottom navigation between features

### 🏗️ Architecture
- Clean architecture with separated business logic
- Riverpod for type-safe state management
- Modular and testable code

## 🚀 Quick Start

1. **Add your OpenAI API key** to `.env`:
   ```env
   OPENAI_API_KEY=sk-your-key-here
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run -d chrome
   ```

For detailed instructions, see [QUICKSTART.md](QUICKSTART.md)

## 📚 Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - Get started in 3 steps
- **[docs/get-started.md](docs/get-started.md)** - Comprehensive setup guide
- **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** - Architecture and features
- **[CRYPTO_FEATURES.md](CRYPTO_FEATURES.md)** - Crypto market features guide

## 🏗️ Architecture

```
lib/
├── models/          # Data models (Message, CryptoCoin)
├── services/        # API integrations (OpenAI, CoinGecko)
├── providers/       # Riverpod state management
├── widgets/         # Reusable UI components
├── screens/         # App screens (Home, Chat, Navigation)
└── main.dart        # App entry point
```

## 🛠️ Tech Stack

- **Flutter** - UI framework
- **Riverpod** - State management
- **OpenAI API** - AI chat backend
- **CoinGecko API** - Crypto market data
- **fl_chart** - Beautiful charts
- **Material Design 3** - Design system
- **HTTP** - API calls

## 📱 Features Overview

### Crypto Market Screen
- Live prices for top 10 cryptocurrencies
- 7-day sparkline charts with trend indicators
- Green/red color coding for price movements
- Pull-to-refresh and auto-refresh
- Card-based layout with smooth scrolling

### AI Chat Screen
- Clean chat interface with gradient message bubbles
- Animated typing indicators
- Auto-scrolling messages
- Empty state with suggestion chips
- Error handling with user feedback

### Navigation
- Bottom navigation bar to switch between features
- Smooth transitions between screens
- Persistent state across navigation

## 🤝 Contributing

This is a private project. For questions or issues, contact the development team.

## 📄 License

Private project - not published to pub.dev.
