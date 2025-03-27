import 'dart:async';

import 'package:get/get.dart';
import '../model/post_model.dart';
import '../services/api_service.dart';
import '../utils/common_utilities.dart';
import '../utils/local_storage.dart';

class PostController extends GetxController {
  var posts = <PostModel>[].obs;
  var isLoading = true.obs;
  final Map<int, Timer?> _timers = {}; // Track timers per item

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    List<PostModel> localPosts = await LocalStorage.loadPosts();

    if (localPosts.isNotEmpty) {
      posts.assignAll(localPosts);
    }

    try {
      List<PostModel> apiPosts = await ApiService.fetchPosts();
      posts.assignAll(apiPosts);
      await LocalStorage.savePosts(apiPosts);
    } catch (e) {
      print("Error fetching posts: $e");
      commonSnackBar(
          message: 'Error fetching posts: $e', type: SnackBarType.error);
    } finally {
      isLoading.value = false;
    }
    print("${posts.length}");
    update();
  }

  void markAsRead(int index) {
    posts[index].isRead.value = true;
    LocalStorage.savePosts(posts);
    posts.refresh();
  }

  void startTimer(int index) {
    if (_timers[index] != null || posts[index].isTimerRunning.value) return;

    posts[index].isTimerRunning.value = true;
    _timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
      if (posts[index].remainingTime.value > 0) {
        posts[index].remainingTime.value--;
      } else {
        timer.cancel();
        posts[index].isTimerRunning.value = false;
      }
    });
  }

  void pauseTimer(int index) {
    _timers[index]?.cancel();
    _timers[index] = null;
    posts[index].isTimerRunning.value = false;
  }

  void resumeTimer(int index) {
    if (!posts[index].isTimerRunning.value &&
        posts[index].remainingTime.value > 0) {
      startTimer(index);
    }
  }
}
