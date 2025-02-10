import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/services/json_services.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  List<Post>? _allPosts;
  List<Comment>? comments;
  User? profileUser;

  List<User>? _allUsers;
  User? selectedUser;
  Post? selectedPost;
  List<User>? get allUsers => _allUsers;
  List<Post>? get allPosts => _allPosts;

  Future<void> getAllPosts() async {
    Map<String, dynamic> data = await JsonService.loadJsonData();
    _allPosts =
        (data['posts'] as List).map((post) => Post.fromJson(post)).toList();

    notifyListeners();
  }

  Future<void> getAllUsers() async {
    Map<String, dynamic> data = await JsonService.loadJsonData();
    _allUsers =
        (data['users'] as List).map((users) => User.fromJson(users)).toList();

    notifyListeners();
  }

  void setSelectedPost(Post post) {
    selectedPost = post;
    selectedUser = _allUsers?.firstWhere((users) => users.id == post.userId);
    notifyListeners();
  }

  void toggleLike(String postId, String userId) {
    Post? post = _allPosts?.firstWhere(
      (p) => p.id == postId,
    );
    if (post != null) {
      if (post.likes.contains(userId)) {
        post.likes.remove(userId);
      } else {
        post.likes.add(userId);
      }
      notifyListeners();
    }
  }

  Future<void> getComments() async {
    Map<String, dynamic> data = await JsonService.loadJsonData();
    comments = (data['comments'] as List)
        .map((comment) => Comment.fromJson(comment))
        .toList();
  }

  List<Comment>? getCommentById(String postId) {
    return comments
        ?.where((comment) => comment.parentPostId == postId)
        .toList();
  }

  void addComment(String postId, String userId, String text) {
    Comment newComment = Comment(
      id: 'newComment',
      text: text,
      parentPostId: postId,
      userId: userId,
    );
    comments!.add(newComment);
    notifyListeners();
  }

  User? getUserById(String id) {
    return _allUsers!.firstWhere((users) => users.id == id);
  }

  void getProfileUser(String id) {
    profileUser = _allUsers!.firstWhere((users) => users.id == id);
    print('${profileUser!.name} Name');
  }

  void addNewPost(Post post) {
    _allPosts!.add(post);

    notifyListeners();
  }
}
