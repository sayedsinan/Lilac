import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine/view/login_page.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home:LoginPage()
    );
  }
}