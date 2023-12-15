import 'package:flutter/material.dart';

class User {
  final String? id;
  final String uname;
  final String fullname;
  final String password;
  final String avatarUrl;

  User({
    this.id,
    required this.uname,
    required this.fullname,
    required this.password,
    required this.avatarUrl,
  });

  User copyWith({
    String? id,
    String? uname,
    String? fullname,
    String? password,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      uname: uname ?? this.uname,
      fullname: fullname ?? this.fullname,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
