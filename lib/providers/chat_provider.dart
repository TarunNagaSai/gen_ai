import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/message.dart';
import '../services/openai_service.dart';

// Provider for OpenAI service
final openAIServiceProvider = Provider<OpenAIService>((ref) {
  return OpenAIService.fromEnv();
});

// State class for chat
class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Chat notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final OpenAIService _openAIService;
  final Uuid _uuid = const Uuid();

  ChatNotifier(this._openAIService) : super(ChatState());

  void addMessage(String content, MessageRole role) {
    final message = Message(
      id: _uuid.v4(),
      content: content,
      role: role,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, message],
    );
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Add user message
    addMessage(content, MessageRole.user);

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Get AI response
      final response = await _openAIService.sendMessage(
        messages: state.messages,
      );

      // Add assistant message
      addMessage(response, MessageRole.assistant);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> sendMessageWithStream(String content) async {
    if (content.trim().isEmpty) return;

    // Add user message
    addMessage(content, MessageRole.user);

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Create placeholder for streaming message
      final assistantMessageId = _uuid.v4();
      final assistantMessage = Message(
        id: assistantMessageId,
        content: '',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, assistantMessage],
      );

      // Stream AI response
      String accumulatedContent = '';
      await for (var chunk in _openAIService.sendMessageStream(
        messages: state.messages.where((m) => m.id != assistantMessageId).toList(),
      )) {
        accumulatedContent += chunk;
        
        // Update the assistant message with accumulated content
        final updatedMessages = state.messages.map((msg) {
          if (msg.id == assistantMessageId) {
            return msg.copyWith(content: accumulatedContent);
          }
          return msg;
        }).toList();

        state = state.copyWith(messages: updatedMessages);
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearMessages() {
    state = ChatState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Chat provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final openAIService = ref.watch(openAIServiceProvider);
  return ChatNotifier(openAIService);
});
