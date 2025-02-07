import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/services/json_services.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  List<Post>? _allPosts;

  List<User>? _allUsers;
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
}
