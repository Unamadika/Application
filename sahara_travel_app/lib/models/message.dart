/// Represents a single chat message bubble.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });

  final String id;
  final String sender;
  final String text;
  final DateTime timestamp;
  final bool isMe;
}
