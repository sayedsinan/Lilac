import 'package:flutter/material.dart';
import 'package:lilac_machine/view/login_page.dart';
import 'package:lilac_machine/view/style/color.dart';
import 'package:lilac_machine/view/style/text_style.dart';
import 'package:lilac_machine/view/widget/custom_button.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/splash_screen_background.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Image.asset('assets/logo.png'),
              Text(
                "Connect. Meet. Love. With \n   Fliq Dating",
                style: poppinsTextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 350),
              CustomButton(
                text: "Sign in with Google",
                onPressed: () {},
                height: 56,
                width: 380,
                logoPath: 'assets/google_logo.png',
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Sign in with FaceBook",
                onPressed: () {},
                height: 56,
                width: 380,
                logoPath: 'assets/facebook_logo.png',
                backgroundColor: facebookColor,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Sign in with Phone number",
                onPressed: () => Get.to(() => LoginPage()),
                height: 56,
                width: 380,
                logoPath: 'assets/phone_logo.png',
                backgroundColor: phoneNumberColor,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "By signing up, you agree to our Terms. See how we use your data in our Privacy Policy.",
                  style: poppinsTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
