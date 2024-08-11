import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var selectedUserName = ''.obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1;
  final int perPage = 10;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers({bool refresh = false}) async {
    if (isLoading.value) return;
    if (!refresh && !hasMore.value) return;

    isLoading(true);

    if (refresh) {
      page = 1;
      users.clear();
      hasMore(true);
    }

    try {
      final response = await http.get(Uri.parse(
          'https://reqres.in/api/users?page=$page&per_page=$perPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<User> newUsers =
            (data['data'] as List).map((json) => User.fromJson(json)).toList();

        users.addAll(newUsers);
        page++;
        hasMore(newUsers.isNotEmpty && page <= data['total_pages']);
      } else {
        hasMore(false);
      }
    } catch (e) {
      hasMore(false);
    } finally {
      isLoading(false);
    }
  }

  void setSelectedUser(String name) {
    selectedUserName(name);
  }

  void loadMoreUsers() {
    if (!isLoading.value && hasMore.value) {
      loadUsers();
    }
  }
}
