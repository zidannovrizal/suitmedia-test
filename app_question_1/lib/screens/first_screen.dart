import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'second_screen.dart';
import '../constants/text_constant.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController sentenceController = TextEditingController();
    final RxString initialLetter = ''.obs;

    bool isPalindrome(String text) {
      String cleanText =
          text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
      return cleanText == cleanText.split('').reversed.join('');
    }

    void showPalindromeResult() {
      String sentence = sentenceController.text;
      if (sentence.isEmpty) {
        Get.snackbar(
          'Error',
          'Palindrome cannot be empty',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      bool result = isPalindrome(sentence);
      Get.dialog(
        AlertDialog(
          title: Text(
            result ? 'is a palindrome' : 'is not a palindrome',
            style: TextStyles.poppins18.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'The sentence "$sentence" is ${result ? '' : 'not '}a palindrome.',
            style: TextStyles.poppins18,
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyles.poppins18
                    .copyWith(color: const Color(0xFF2B637B)),
              ),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }

    nameController.addListener(() {
      if (nameController.text.isNotEmpty) {
        initialLetter.value = nameController.text[0].toUpperCase();
      } else {
        initialLetter.value = '';
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CircleAvatar(
                    radius: 64,
                    backgroundColor: initialLetter.value.isEmpty
                        ? Colors.transparent
                        : Colors.white.withOpacity(.4),
                    backgroundImage: initialLetter.value.isEmpty
                        ? const AssetImage('assets/images/ic_photo.png')
                        : null,
                    child: initialLetter.value.isEmpty
                        ? null
                        : Text(
                            initialLetter.value,
                            style: TextStyles.poppins18.copyWith(
                              color: Colors.white,
                              fontSize: 64,
                            ),
                          ),
                  )),
              const SizedBox(height: 64),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyles.poppins18.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sentenceController,
                decoration: InputDecoration(
                  hintText: 'Palindrome',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyles.poppins18.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B637B),
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: showPalindromeResult,
                  child: Text('Check',
                      style: TextStyles.poppins18
                          .copyWith(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B637B),
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Name cannot be empty',
                        snackPosition: SnackPosition.TOP,
                      );
                      return;
                    }
                    Get.to(
                      () => SecondScreen(name: nameController.text),
                    );
                  },
                  child: Text(
                    'Next',
                    style: TextStyles.poppins18
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
