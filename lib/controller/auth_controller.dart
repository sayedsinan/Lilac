import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:lilac_machine/model/send_otp_model.dart';
import 'package:lilac_machine/model/verify_otp_model.dart';
import 'package:lilac_machine/view/messages_page.dart';
import 'package:lilac_machine/view/otp_verification_page.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController(text: "8087808780");
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final storage = GetStorage();
  var phoneNumber = ''.obs;
  var countryCode = '+91'.obs;
  final countryCodes = ['+91', '+1', '+44', '+61'];
  void setPhoneNumber(String value) => phoneNumber.value = value;
  void setCountryCode(String value) => countryCode.value = value;
  late String otpText;

  @override
  void onInit() {
    super.onInit();
    otpText = getOtp();
    print('onInit: OTP initialized as: $otpText');
  }

  String getOtp() {
    final otp = otpControllers.map((controller) => controller.text).join();
    print('getOtp: Assembled OTP: $otp');
    return otp;
  }

  final baseUrl = "https://test.myfliqapp.com/api/v1";

  var isLoading = false.obs;

  Future<void> sendOtp(String phone) async {
    isLoading.value = true;
    print('sendOtp: Sending OTP to phone: $phone');

    final requestModel = SendOtpRequest(
      data: SendOtpData(attributes: SendOtpAttributes(phone: phone)),
    );

    final jsonBody = jsonEncode(requestModel.toJson());
    print('sendOtp: Request JSON body => $jsonBody');

    final response = await http.post(
      Uri.parse("$baseUrl/auth/registration-otp-codes/actions/phone/send-otp"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/vnd.api+json",
      },
      body: jsonBody,
    );

    print('sendOtp: Response Code => ${response.statusCode}');
    print('sendOtp: Response Body => ${response.body}');

    if (response.statusCode == 200) {
      print(
        'sendOtp: OTP sent successfully, navigating to OTPVerificationPage.',
      );
      Get.offAll(OtpVerificationPage());
    } else {
      print('sendOtp: Failed to send OTP.');
    }

    isLoading.value = false;
  }

  Future<void> verifyOtp() async {
    final url = Uri.parse(
      '$baseUrl/auth/registration-otp-codes/actions/phone/verify-otp',
    );

    final Map<String, dynamic> requestBody = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": "+918087808780",
          "otp": 111111,
          "device_meta": {
            "type": "web",
            "device-name": "HP Pavilion 14-EP0068TU",
            "device-os-version": "Windows 10",
            "browser": "Chrome",
            "browser_version": "123.0.0.0",
            "user-agent": "LilacMachineTest/1.0",
            "screen_resolution": "1920x1080",
            "language": "en-US",
          },
        },
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/vnd.api+json",
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        if (responseJson.containsKey('data')) {
          final japxDecoded = Japx.decode(responseJson);
          final data = japxDecoded['data'];
          final authStatus = data['auth_status'];

          if (authStatus != null && authStatus['access_token'] != null) {
            final accessToken = authStatus['access_token'];
            print("Access Token: $accessToken");
            storage.write('access_token', accessToken);
          }
          Get.offAll(MessagesPage());
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
