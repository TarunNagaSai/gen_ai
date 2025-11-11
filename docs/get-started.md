# AI Chat App - Getting Started

A modern Flutter chat application with OpenAI integration, built with clean architecture using Riverpod for state management.

## Features

- 🤖 AI-powered chat using OpenAI's GPT models
- 💬 Modern, beautiful UI with Material Design 3
- 🔄 Real-time streaming responses
- 🌓 Dark and light theme support
- 📱 Responsive design
- ⚡ Smooth animations and transitions
- 🎯 Clean architecture with separated business logic

## Architecture

The app follows a clean architecture pattern:

```
lib/
├── models/          # Data models
│   └── message.dart
├── services/        # API services
│   └── openai_service.dart
├── providers/       # Riverpod state management
│   └── chat_provider.dart
├── widgets/         # Reusable UI components
│   ├── message_bubble.dart
│   ├── chat_input.dart
│   └── typing_indicator.dart
├── screens/         # App screens
│   └── chat_screen.dart
└── main.dart        # App entry point
```

## Prerequisites

- Flutter SDK (>=3.9.2)
- Dart SDK (>=3.9.2)
- An OpenAI API key

## Setup

### 1. Clone and Install Dependencies

```bash
cd /Users/tarunkodali/Projects/FlutterApps/gen_ai
flutter pub get
```

### 2. Configure OpenAI API Key

Edit the `.env` file in the project root and add your OpenAI API key:

```env
OPENAI_API_KEY=sk-your-actual-api-key-here
```

**Important**: Never commit your actual API key to version control. The `.env` file is already tracked in this private project.

### 3. Run the App

```bash
flutter run
```

Or for a specific platform:

```bash
flutter run -d chrome    # Web
flutter run -d macos     # macOS
flutter run -d ios       # iOS
```

## Project Structure

### Models

**`message.dart`**: Defines the message data structure with support for different roles (user, assistant, system).

### Services

**`openai_service.dart`**: Handles all OpenAI API interactions:
- Regular message sending
- Streaming responses
- Error handling

### Providers (Riverpod)

**`chat_provider.dart`**: Manages chat state and business logic:
- `ChatState`: Holds messages, loading state, and errors
- `ChatNotifier`: Handles message sending, streaming, and state updates
- `chatProvider`: The main provider for the chat functionality

### Widgets

**`message_bubble.dart`**: Displays individual messages with:
- Different styling for user and AI messages
- Avatar indicators
- Timestamps
- Smooth animations

**`chat_input.dart`**: Input field component with:
- Send button
- Loading state indicator
- Multi-line support
- Submit on enter

**`typing_indicator.dart`**: Animated typing indicator for AI responses

### Screens

**`chat_screen.dart`**: Main chat interface with:
- Message list
- Input field
- Empty state
- Error handling
- Auto-scroll to latest message

## Usage

### Sending Messages

Simply type your message in the input field and press send or hit enter. The AI will respond with a streaming response.

### Clearing Chat

Click the delete icon in the app bar to clear all messages.

### Features

- **Streaming Responses**: AI responses are displayed in real-time as they're generated
- **Auto-scroll**: The chat automatically scrolls to the latest message
- **Error Handling**: Network errors and API errors are displayed with clear messages
- **Suggestion Chips**: Quick start suggestions on the empty state

## Customization

### Changing AI Model

Edit `lib/services/openai_service.dart`:

```dart
String model = 'gpt-4';  // Change from gpt-3.5-turbo to gpt-4
```

### Changing Theme Colors

Edit `lib/main.dart`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,  // Change the seed color
    brightness: Brightness.light,
  ),
  useMaterial3: true,
),
```

### Adding System Prompts

Edit `lib/providers/chat_provider.dart` in the `sendMessageWithStream` method to add a system message:

```dart
// Add system message at the beginning
final messagesWithSystem = [
  Message(
    id: _uuid.v4(),
    content: 'You are a helpful assistant.',
    role: MessageRole.system,
    timestamp: DateTime.now(),
  ),
  ...state.messages,
];
```

## Troubleshooting

### API Key Issues

If you get authentication errors:
1. Check that your API key is correctly set in `.env`
2. Ensure the `.env` file is in the project root
3. Restart the app after changing the `.env` file

### Network Errors

If you experience network issues:
- Check your internet connection
- Verify the OpenAI API status
- Check if you have API credits remaining

### Build Errors

If you encounter build errors:
```bash
flutter clean
flutter pub get
flutter run
```

## Dependencies

- `flutter_riverpod`: State management
- `http`: HTTP client for API calls
- `flutter_dotenv`: Environment variables
- `uuid`: Unique ID generation
- `intl`: Date formatting

## License

This project is private and not published to pub.dev.

## Support

For issues or questions, please contact the development team.
