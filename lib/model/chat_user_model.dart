import 'package:japx/japx.dart';
import 'dart:convert';

class ChatUser {
  final int id;
  final String name;
  final String email;
  final String profilePhotoUrl;
  final String phone;
  final String username;
  final int? age;
  final bool? isOnline;
  final bool? isActive;
  final String? customerCode;
  final bool? isPremiumCustomer;
  final String? lastActiveAt;
  final String? dateOfBirth;
  final String? nativeLanguageName;
  final String? square100ProfilePhotoUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhotoUrl,
    required this.phone,
    required this.username,
    this.age,
    this.isOnline,
    this.isActive,
    this.customerCode,
    this.isPremiumCustomer,
    this.lastActiveAt,
    this.dateOfBirth,
    this.nativeLanguageName,
    this.square100ProfilePhotoUrl,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: int.parse(json['id']),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePhotoUrl: json['profile_photo_url'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      age: json['age'],
      isOnline: json['is_online'],
      isActive: json['is_active'],
      customerCode: json['customer_code'],
      isPremiumCustomer: json['is_premium_customer'],
      lastActiveAt: json['last_active_at'],
      dateOfBirth: json['date_of_birth'],
      nativeLanguageName: json['native_language_name'],
      square100ProfilePhotoUrl: json['square100_profile_photo_url'],
    );
  }
}
