import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/post_model.dart';

class LocalStorage {
  static Future<void> savePosts(List<PostModel> posts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> postList =
        posts.map((post) => jsonEncode(post.toJson())).toList();
    await prefs.setStringList('posts', postList);
  }

  static Future<List<PostModel>> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? postList = prefs.getStringList('posts');

    if (postList == null) return [];

    return postList
        .map((post) => PostModel.fromJson(jsonDecode(post)))
        .toList();
  }
}
