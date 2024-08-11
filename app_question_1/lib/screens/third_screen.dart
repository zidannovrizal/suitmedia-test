import 'package:app_question_1/constants/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class ThirdScreen extends GetView<UserController> {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/arrow-left.png'),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'User List',
          style: TextStyles.poppins18.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadUsers(refresh: true),
        child: Obx(() {
          if (controller.users.isEmpty && !controller.isLoading.value) {
            return const Center(child: Text('No users found'));
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification &&
                  scrollInfo.metrics.extentAfter == 0 &&
                  controller.hasMore.value &&
                  !controller.isLoading.value) {
                controller.loadMoreUsers();
              }
              return false;
            },
            child: Container(
              margin: const EdgeInsets.all(18.0),
              child: ListView.builder(
                itemCount: controller.users.length +
                    (controller.hasMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.users.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = controller.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 39,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyles.poppins18
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(user.email.toUpperCase(),
                        style: TextStyles.poppins18.copyWith(fontSize: 10)),
                    onTap: () {
                      controller.setSelectedUser(
                          '${user.firstName} ${user.lastName}');
                      Get.back();
                    },
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
