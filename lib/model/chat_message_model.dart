class ChatMessage {
  final int id;
  final String message;
  final int senderId;
  final int receiverId;
  final DateTime sentAt;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.sentAt,
    required this.isMe,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json, int currentUserId) {
    return ChatMessage(
      id: int.parse(json['id']),
      message: json['message'] ?? '',
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      sentAt: DateTime.parse(json['sent_at']),
      isMe: json['sender_id'] == currentUserId,
    );
  }
}
