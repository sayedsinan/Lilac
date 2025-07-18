import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine/view/style/color.dart';
import 'package:lilac_machine/view/style/text_style.dart';
import 'package:lilac_machine/view/widget/custom_button.dart';
import 'package:lilac_machine/controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

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
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                      splashRadius: 24,
                    ),
                  ),
                  const SizedBox(height: 32),
                   Center(
                    child: Text(
                      'Enter your phone\nnumber',
                      textAlign: TextAlign.center,
                      style: jostTextStyle(fontSize:28,fontWeight: FontWeight.w600,color: Colors.black )
                    ),
                  ),
                  const SizedBox(height: 40),

                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),

                          DropdownButton<String>(
                            value: authController.countryCode.value,
                            underline: const SizedBox(),
                            items:
                                authController.countryCodes.map((code) {
                                  return DropdownMenuItem(
                                    value: code,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/Phone.png',
                                          height: 16,
                                          width: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          code,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                authController.setCountryCode(val);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: authController.phoneController,
                              keyboardType: TextInputType.phone,
                              onChanged: authController.setPhoneNumber,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '974568 1203',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Fliq will send you a text with a verification code.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  text: 'Next',
                  onPressed: () {
                    authController.sendOtp(authController.countryCode+authController.phoneController.text);
                  },
                  height: 56,
                  width: double.infinity,
                  backgroundColor: const Color(0xFFE6446E),
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
