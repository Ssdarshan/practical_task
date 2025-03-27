import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controller/post_controller.dart';
import '../model/post_model.dart';
import '../views/post_detail_screen.dart';

class PostItem extends StatelessWidget {
  final PostModel post;
  final int index;
  final PostController controller = Get.find();

  PostItem({required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return VisibilityDetector(
        key: Key(post.id.toString()),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0.5) {
            controller.resumeTimer(index);
          } else {
            controller.pauseTimer(index);
          }
        },
        child: ListTile(
          tileColor: post.isRead.value ? Colors.white : Colors.yellow[100],
          title: Text(post.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer, color: Colors.grey),
              SizedBox(width: 5),
              Text(
                "${post.remainingTime.value}s",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onTap: () {
            controller.pauseTimer(index);
            controller.markAsRead(index);
            Get.to(() => PostDetailScreen(postId: post.id))!.then((_) {
              controller.resumeTimer(index);
            });
          },
        ),
      );
    });
  }
}
