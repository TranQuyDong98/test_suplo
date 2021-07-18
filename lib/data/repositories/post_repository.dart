import 'dart:convert';

import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/data/network/network.dart';

class PostRepository {
  Future<List<Post>> getPosts(String userId) async {
    String url = ApiConstant.BASE_URL +
        ApiConstant.USERS +
        '/' +
        userId +
        '/' +
        ApiConstant.POSTS;
    try {
      var response = await Network.instance.get(
        url: url,
      );
      var data = response.data;
      if (data == null) {
        return null;
      } else {
        List<Post> posts =
            (data as List).map((json) => Post.fromJson(json)).toList();
        return posts;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Post> createPost({String title, String content, String userId}) async {
    String url = ApiConstant.BASE_URL +
        ApiConstant.USERS +
        '/' +
        userId +
        '/' +
        ApiConstant.POSTS;
    Map<String, dynamic> body = {
      'title': title,
      'content': content,
    };

    try {
      var response =
          await Network.instance.post(url: url, body: jsonEncode(body));
      return Post.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Post> updatePost(
      {String title, String content, String userId, String postId}) async {
    String url = ApiConstant.BASE_URL +
        ApiConstant.USERS +
        '/' +
        userId +
        '/' +
        ApiConstant.POSTS +
        '/' +
        postId + '/';

    Map<String, dynamic> body = {
      'title': title,
      'content': content,
    };

    try {
      var response = await Network.instance.put(
        url: url,
        body: jsonEncode(body),
      );
      return Post.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
  }


  Future<Post> deletePost(
      {String userId, String postId}) async {
    String url = ApiConstant.BASE_URL +
        ApiConstant.USERS +
        '/' +
        userId +
        '/' +
        ApiConstant.POSTS +
        '/' +
        postId + '/';

    try {
      var response = await Network.instance.delete(
        url: url,
      );

      return Post.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
  }
}
