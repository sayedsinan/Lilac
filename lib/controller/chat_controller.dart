import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:lilac_machine/model/chat_user_model.dart';
import 'package:lilac_machine/model/chat_message_model.dart';

class ChatController extends GetxController {
  var chatUsers = <ChatUser>[].obs;
  var isLoading = false.obs;
  final storage = GetStorage();
  var chatMessages = <ChatMessage>[].obs;
  final baseUrl = "https://test.myfliqapp.com/api/v1";

  Future<void> fetchChatUsers() async {
    isLoading.value = true;
    final token = storage.read('access_token');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chat/chat-messages/queries/contact-users'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final japxDecoded = Japx.decode(jsonDecode(response.body));
        final List<dynamic> usersJson = japxDecoded['data'];
        final List<ChatUser> users =
            usersJson.map((userJson) => ChatUser.fromJson(userJson)).toList();

        chatUsers.value = users;
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch users (Status: ${response.statusCode})',
        );
      }

      print(response.body);
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchChatMessages({
    required int userId1,
    required int userId2,
    required int currentUserId,
  }) async {
    final token = storage.read('access_token');
    final url =
        '$baseUrl/chat/chat-messages/queries/chat-between-users/55/81';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final japxDecoded = Japx.decode(jsonDecode(response.body));
        final List<dynamic> messagesJson = japxDecoded['data'];
        chatMessages.value =
            messagesJson
                .map((msgJson) => ChatMessage.fromJson(msgJson, currentUserId))
                .toList();
        print(response.body);
      } else {
        Get.snackbar('Error', 'Failed to fetch chat messages');
        print(response.body);
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
    }
  }

  String formatTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final isAM = hour < 12;
      final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return '$hour12:$minute ${isAM ? 'AM' : 'PM'}';
    } catch (e) {
      return '';
    }
  }
  String formatTimeChat(DateTime dateTime) {
  final hour = dateTime.hour;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final isAM = hour < 12;
  final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  return '$hour12:$minute ${isAM ? 'AM' : 'PM'}';
}
}
