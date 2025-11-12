# Quick Start Guide

Get your AI chat app running in 3 simple steps!

## Step 1: Add Your OpenAI API Key

Edit the `.env` file in the project root:

```bash
# Open .env and replace with your actual key
OPENAI_API_KEY=sk-your-actual-api-key-here
```

**Don't have an API key?**
1. Go to https://platform.openai.com/api-keys
2. Sign in or create an account
3. Click "Create new secret key"
4. Copy and paste it into `.env`

## Step 2: Install Dependencies

```bash
flutter pub get
```

## Step 3: Run the App

```bash
# For Chrome (fastest for testing)
flutter run -d chrome

# Or for macOS
flutter run -d macos

# Or let Flutter choose
flutter run
```

## That's It! 🎉

You should now see the chat interface. Try:
- "Tell me a joke"
- "Explain quantum computing"
- "Write a poem about coding"

## Project Files Overview

```
📁 lib/
  ├── 📄 main.dart                    # App entry (Riverpod setup)
  ├── 📁 models/
  │   └── 📄 message.dart             # Message data model
  ├── 📁 services/
  │   └── 📄 openai_service.dart      # OpenAI API calls
  ├── 📁 providers/
  │   └── 📄 chat_provider.dart       # Business logic (Riverpod)
  ├── 📁 screens/
  │   └── 📄 chat_screen.dart         # Main chat UI
  └── 📁 widgets/
      ├── 📄 message_bubble.dart      # Individual message
      ├── 📄 chat_input.dart          # Input field
      └── 📄 typing_indicator.dart    # Animated typing dots
```

## Key Riverpod Providers

- **`chatProvider`**: Main chat state and logic
- **`openAIServiceProvider`**: OpenAI service instance

## Common Commands

```bash
# Run the app
flutter run

# Run with hot reload
flutter run -d chrome

# Analyze code
flutter analyze

# Clean and rebuild
flutter clean && flutter pub get && flutter run

# Format code
dart format lib/
```

## Troubleshooting

### ❌ "OPENAI_API_KEY not found"
→ Make sure `.env` file exists and contains your API key

### ❌ "Invalid API key"
→ Verify your key is correct and has credits

### ❌ Build errors
→ Run `flutter clean && flutter pub get`

## Next Steps

- Read `docs/get-started.md` for detailed documentation
- Check `PROJECT_SUMMARY.md` for architecture details
- Modify `lib/services/openai_service.dart` to change AI model
- Customize colors in `lib/main.dart`

## Need Help?

- OpenAI docs: https://platform.openai.com/docs
- Flutter docs: https://docs.flutter.dev
- Riverpod docs: https://riverpod.dev

Happy coding! 🚀
