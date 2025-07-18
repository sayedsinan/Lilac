import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine/model/chat_user_model.dart';
import 'package:lilac_machine/controller/chat_controller.dart';
import 'package:lilac_machine/view/style/color.dart';
import 'package:lilac_machine/view/widget/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  final ChatUser user;
  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();
    final int currentUserId =
        chatController.storage.read('current_user_id') ?? 55;
    chatController.fetchChatMessages(
      userId1: 55,
      userId2: 81,
      currentUserId: currentUserId,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 24, top: 32, right: 24),
              color: const Color(0xFFF7F7F7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF2D0C23),
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        (user.profilePhotoUrl.isNotEmpty)
                            ? NetworkImage(user.profilePhotoUrl)
                            : const AssetImage('assets/person_1.png')
                                as ImageProvider,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D0C23),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            (user.isOnline ?? false) ? 'Online' : 'Offline',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color:
                                  (user.isOnline ?? false)
                                      ? Colors.green
                                      : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Chat body
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Message list
                    Expanded(
                      child: Obx(() {
                        if (chatController.chatMessages.isEmpty) {
                          return const Center(child: Text('No messages'));
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
                          itemCount: chatController.chatMessages.length,
                          itemBuilder: (context, index) {
                            final msg = chatController.chatMessages[index];
                            return ChatBubble(
                              message: msg.message,
                              time: chatController.formatTimeChat(msg.sentAt),
                              isMe: msg.isMe,
                            );
                          },
                        );
                      }),
                    ),
                    // Input bar
                    SafeArea(
                      top: false,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type a message',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFE6446E),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
