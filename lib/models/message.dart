enum MessageRole {
  user,
  assistant,
  system,
}

class Message {
  final String id;
  final String content;
  final MessageRole role;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      content: json['content'] as String,
      role: MessageRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => MessageRole.user,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'role': role.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  Message copyWith({
    String? id,
    String? content,
    MessageRole? role,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
