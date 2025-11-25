import 'dart:async';

import '../data/dummy_content.dart';
import '../models/message.dart';

class ChatService {
  final _messages = List<ChatMessage>.from(DummyContent.chatHistory);

  Future<List<ChatMessage>> fetchMessages() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return List.unmodifiable(_messages);
  }

  Future<ChatMessage> sendMessage(String text) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'You',
      text: text,
      timestamp: DateTime.now(),
      isMe: true,
    );
    _messages.add(message);
    return message;
  }
}
