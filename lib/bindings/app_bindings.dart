import 'package:get/get.dart';
import 'package:practical_task/controller/post_controller.dart';

class AppBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => PostController(), fenix: true);
  }
}
