import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/post_model.dart';
import '../services/api_service.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PostModel>(
      future: ApiService.fetchPostDetails(postId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        PostModel post = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text("Post Details")),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Text(post.body, style: TextStyle(fontSize: 18)),
          ),
        );
      },
    );
  }
}
