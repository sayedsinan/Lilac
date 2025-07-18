import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lilac_machine/controller/auth_controller.dart';
import 'package:lilac_machine/controller/chat_controller.dart';
import 'package:lilac_machine/view/splash_screen.dart';

void main() async{
    await GetStorage.init();

  runApp(MyApp());
  Get.put(ChatController());
  Get.put(AuthController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
