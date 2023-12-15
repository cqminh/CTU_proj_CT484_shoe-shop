import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../models/user.dart';

class UsersManager with ChangeNotifier {
  final List<User> _users = [
    User(
      id: 'u1',
      uname: 'cqminh',
      fullname: 'Châu Quang Minh',
      password: '123456abc',
      avatarUrl:
          'https://kiemtientuweb.com/ckfinder/userfiles/images/avatar-fb/avatar-fb-1.jpg',
    ),
  ];

  List<User> get users {
    return [..._users];
  }

  User? findById(String id) {
    try {
      return _users.firstWhere((users) => users.id == id);
    } catch (error) {
      return null;
    }
  }

  void editUser(User user) {
    final index = _users.indexWhere((item) => item.id == user.id);
    if (index >= 0) {
      _users[index] = user;
      notifyListeners();
    }
  }
}
