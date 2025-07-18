import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine/controller/chat_controller.dart';
import 'package:lilac_machine/view/chat_screen.dart';
import 'package:lilac_machine/view/style/color.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});

  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    chatController.fetchChatUsers(); // call API when widget builds

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (chatController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Header and Back
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Horizontal list (can skip or adjust if ChatUser includes avatars)
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: chatController.chatUsers.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final user = chatController.chatUsers[index];
                    print(
                      'User: ${user.name}, Photo URL: ${user.profilePhotoUrl}',
                    );
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              (user.profilePhotoUrl != null &&
                                      user.profilePhotoUrl.isNotEmpty)
                                  ? NetworkImage(user.profilePhotoUrl)
                                  : (user.square100ProfilePhotoUrl != null &&
                                      user.square100ProfilePhotoUrl!.isNotEmpty)
                                  ? NetworkImage(user.square100ProfilePhotoUrl!)
                                  : const AssetImage('assets/person_1.png')
                                      as ImageProvider,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.name,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              // Chat List
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Chat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: ListView.separated(
                  itemCount: chatController.chatUsers.length,
                  separatorBuilder:
                      (context, index) =>
                          Divider(height: 1, color: Colors.grey.shade200),
                  itemBuilder: (context, index) {
                    final user = chatController.chatUsers[index];
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                (user.profilePhotoUrl != null &&
                                        user.profilePhotoUrl.isNotEmpty)
                                    ? NetworkImage(user.profilePhotoUrl)
                                    : (user.square100ProfilePhotoUrl != null &&
                                        user
                                            .square100ProfilePhotoUrl!
                                            .isNotEmpty)
                                    ? NetworkImage(
                                      user.square100ProfilePhotoUrl!,
                                    )
                                    : const AssetImage('assets/person_1.png')
                                        as ImageProvider,
                          ),
                          if (user.isOnline == true)
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing:
                          user.lastActiveAt != null &&
                                  user.lastActiveAt!.isNotEmpty
                              ? Text(
                                chatController.formatTime(user.lastActiveAt!),
                              )
                              : null,
                      onTap: () => Get.to(() => ChatPage(user: user)),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
