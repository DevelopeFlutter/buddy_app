import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/services/json_services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  List<User> _users = [];
  String? _loggedInUser;
  String? get loggeInUsers => _loggedInUser;
  List get users => _users;

  Future<void> loadUsers() async {
    Map<String, dynamic> data = await JsonService.loadJsonData();
    _users =
        (data['users'] as List).map((user) => User.fromJson(user)).toList();
    notifyListeners();
  }

  User? login(String email, String password) {
    try {
      var user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      _loggedInUser = user.id;
      return user;
    } catch (e) {
      return null;
    }
  }

  // List<User> getAllUsers() {
  //   return _users;
  // }

  // Future<void> loadPosts() async {
  //   Map<String, dynamic> data = await JsonService.loadJsonData();
  //   _posts =
  //       (data['posts'] as List).map((post) => Post.fromJson(post)).toList();
  //   _allPosts = _posts;
  //   // notifyListeners();
  // }

  // List<Post> getUserPosts(String userId) {
  //   print('Fetching posts for user: $userId');
  //   print('${_posts.length} Posts loaded');

  //   return _posts.where((post) => post.userId == userId).toList();
  // }

  // List<Post> getAllPosts() {
  //   return _allPosts;
  // }
}
