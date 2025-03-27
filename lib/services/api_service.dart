import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/post_model.dart';
import '../utils/common_utilities.dart';

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  static Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => PostModel.fromJson(item)).toList();
    } else {
      commonSnackBar(message: 'Failed to load posts', type: SnackBarType.error);
      throw Exception('Failed to load posts');
    }
  }

  static Future<PostModel> fetchPostDetails(int postId) async {
    final response = await http.get(Uri.parse("$baseUrl/$postId"));

    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      commonSnackBar(
          message: 'Failed to load post details', type: SnackBarType.error);
      throw Exception('Failed to load post details');
    }
  }
}
