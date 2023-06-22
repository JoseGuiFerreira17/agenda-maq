import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String name;
  final String email;
  final String password;
  final String phone;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
}
