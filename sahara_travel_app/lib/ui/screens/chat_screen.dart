import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat_controller.dart';
import '../../models/message.dart';
import '../../ui/widgets/responsive_builder.dart';

/// Simple chat UI mock for conversation with a guide.
class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _ChatLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
      tablet: _ChatLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 24)),
    );
  }
}

class _ChatLayout extends StatelessWidget {
  const _ChatLayout({required this.controller, required this.padding});

  final ChatController controller;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(child: Icon(Icons.person)),
            SizedBox(width: 12),
            Text('Chat • Amine'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: padding,
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller
                      .messages[controller.messages.length - 1 - index];
                  return _MessageBubble(message: message);
                },
              );
            }),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding.left, 12, padding.right, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.inputCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Send a message…',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: controller.sendMessage,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color =
        message.isMe ? Theme.of(context).colorScheme.primary : Colors.white;
    final textColor =
        message.isMe ? Colors.white : Theme.of(context).colorScheme.onSurface;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(message.isMe ? 20 : 6),
            bottomRight: Radius.circular(message.isMe ? 6 : 20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: message.isMe ? 4 : 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Text(message.text,
            style: TextStyle(color: textColor, fontSize: 16)),
      ),
    );
  }
}
