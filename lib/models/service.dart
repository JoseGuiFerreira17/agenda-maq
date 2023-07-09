import 'package:flutter/material.dart';

class Service with ChangeNotifier {
  final String id;
  final String name;
  final String schedule;
  final String status;
  final int time;
  final DateTime date;

  Service({
    required this.id,
    required this.name,
    required this.schedule,
    required this.status,
    required this.time,
    required this.date,
  });
}
