import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine/view/chat_screen.dart';
import 'package:lilac_machine/view/style/color.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});

  final List<Map<String, String>> users = [
    {'name': 'Christina', 'avatar': 'assets/person_1.png'},
    {'name': 'Patricia', 'avatar': 'assets/person_2.png'},
    {'name': 'Celestine', 'avatar': 'assets/person_3.png'},
    {'name': 'Celestine', 'avatar': 'assets/person_4.png'},
    {'name': 'Elizabeth', 'avatar': 'assets/person_5.png'},
  ];

  final List<Map<String, String>> chats = [
    {'name': 'Regina Bearden', 'avatar': 'assets/person_1.png', 'time': ''},
    {
      'name': 'Rhonda Rivera',
      'avatar': 'assets/person_2.png',
      'time': '10:00 AM',
    },
    {
      'name': 'Mary Gratton',
      'avatar': 'assets/person_3.png',
      'time': '10:00 AM',
    },
    {
      'name': 'Annie Medved',
      'avatar': 'assets/person_4.png',
      'time': '10:00 AM',
    },
    {
      'name': 'Regina Bearden',
      'avatar': 'assets/person_1.png',
      'time': '10:00 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                      splashRadius: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Horizontal user avatars
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: users.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage(user['avatar']!),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['name']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1.2),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey.shade600),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Chat label
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.separated(
                itemCount: chats.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => ChatScreen()),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(chat['avatar']!),
                      ),
                      title: Text(
                        chat['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      trailing:
                          chat['time']!.isNotEmpty
                              ? Text(
                                chat['time']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              )
                              : null,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
