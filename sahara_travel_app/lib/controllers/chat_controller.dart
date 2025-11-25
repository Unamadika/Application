import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/message.dart';
import '../services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _service = ChatService();

  final messages = <ChatMessage>[].obs;
  final isLoading = true.obs;
  final inputCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  Future<void> loadMessages() async {
    final data = await _service.fetchMessages();
    messages.assignAll(data);
    isLoading.value = false;
  }

  Future<void> sendMessage() async {
    final text = inputCtrl.text.trim();
    if (text.isEmpty) return;
    inputCtrl.clear();
    messages.add(
      ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        sender: 'You',
        text: text,
        timestamp: DateTime.now(),
        isMe: true,
      ),
    );
    await _service.sendMessage(text);
  }

  @override
  void onClose() {
    inputCtrl.dispose();
    super.onClose();
  }
}
