import 'dart:math';

import 'package:get/get.dart';

class PostModel {
  final int id;
  final String title;
  final String body;
  var isRead = false.obs;
  RxInt remainingTime;
  RxBool isTimerRunning = false.obs;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.remainingTime,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final List<int> possibleTimes = [10, 20, 25];
    final int randomTime =
        possibleTimes[Random().nextInt(possibleTimes.length)];

    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      remainingTime: randomTime.obs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead.value,
    };
  }
}
