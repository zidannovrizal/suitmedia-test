import 'package:app_question_1/constants/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'third_screen.dart';
import '../controllers/user_controller.dart';

class SecondScreen extends GetView<UserController> {
  final String name;

  const SecondScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/arrow-left.png'),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Second Screen',
          style: TextStyles.poppins18.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome', style: TextStyles.poppins18),
                Text(name,
                    style: TextStyles.poppins18
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(16.0),
                  child: controller.selectedUserName.isEmpty
                      ? Text(
                          'Selected User Name',
                          style: TextStyles.poppins24
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      : Text(
                          '${controller.selectedUserName}',
                          style: TextStyles.poppins24
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B637B),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => Get.to(() => const ThirdScreen()),
                child: Text('Choose a User',
                    style: TextStyles.poppins18.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
