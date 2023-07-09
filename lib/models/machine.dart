import 'package:flutter/material.dart';

class Machine with ChangeNotifier {
  final String id;
  final String name;
  final bool isActive;

  Machine({
    required this.id,
    required this.name,
    this.isActive = true,
  });
}
