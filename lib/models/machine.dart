import 'package:flutter/material.dart';

class Machine with ChangeNotifier {
  final String name;
  final bool isAvaliable;

  Machine({
    required this.name,
    this.isAvaliable = true,
  });
}
