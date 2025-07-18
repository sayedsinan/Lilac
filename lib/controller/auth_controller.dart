import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
      final TextEditingController phoneController = TextEditingController();
       final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  var phoneNumber = ''.obs;
  var countryCode = '+91'.obs;
  final countryCodes = ['+91', '+1', '+44', '+61'];


  void setPhoneNumber(String value) => phoneNumber.value = value;
  void setCountryCode(String value) => countryCode.value = value;
}
