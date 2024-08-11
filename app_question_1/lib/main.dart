import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/first_screen.dart';
import 'controllers/user_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palindrome Checker App',
      initialBinding: BindingsBuilder(() {
        Get.put(UserController());
      }),
      home: const FirstScreen(),
    );
  }
}
