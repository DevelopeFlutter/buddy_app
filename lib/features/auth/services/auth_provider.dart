import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/services/json_services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  List<User> _users = [];
  String? _loggedInUser;
  String? get loggeInUsers => _loggedInUser;
  List get users => _users;
  bool loginLoading = false;

  Future<void> loadUsers() async {
    Map<String, dynamic> data = await JsonService.loadJsonData();
    _users =
        (data['users'] as List).map((user) => User.fromJson(user)).toList();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      loginLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 3));

      var user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );

      _loggedInUser = user.id;
    } catch (e) {
      _loggedInUser = null;
    } finally {
      loginLoading = false;
      notifyListeners();
    }
  }

// Future<void> login(String email, String password) async {
  //   try {
  //     loginLoading = true;
  //     notifyListeners();
  //
  //     await Future.delayed(const Duration(seconds: 3));
  //     loginLoading = false;
  //     notifyListeners();
  //
  //     var user = _users.firstWhere(
  //       (user) => user.email == email && user.password == password,
  //     );
  //
  //     _loggedInUser = user.id;
  //
  //     notifyListeners();
  //
  //     // return user;
  //   } catch (e) {}
  // }
}
