import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/data/network/network.dart';

class CommentRepository {
  Future<List<Comment>> getComments(String userId, String postId) async {
    String url = ApiConstant.BASE_URL + ApiConstant.USERS + '/' + userId +
        '/' + ApiConstant.POSTS + '/' + postId + '/' + ApiConstant.COMMENTS;
    try {
      var response = await Network.instance.get(
        url: url,
      );
      var data = response.data;
      if (data == null) {
        return null;
      } else {
        List<Comment> comments = (data as List)
            .map((json) => Comment.fromJson(json))
            .toList();
        return comments;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}