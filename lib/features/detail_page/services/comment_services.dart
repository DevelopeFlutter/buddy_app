import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/services/json_services.dart';

class CommentService {
  List<Comment> _comments = [];

  Future<void> loadComments() async {
    Map<String, dynamic> data = await JsonService.loadJsonData();
    _comments = (data['comments'] as List)
        .map((comment) => Comment.fromJson(comment))
        .toList();
  }

  List<Comment> getCommentsForPost(String postId) {
    return _comments.where((comment) => comment.parentPostId == postId).toList();
  }
   void addComment(Comment comment) {
    _comments.add(comment);
  }
}
