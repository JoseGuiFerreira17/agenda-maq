import 'package:agendamaq/models/schedule.dart';
import 'package:flutter/material.dart';

class Service with ChangeNotifier {
  final String name;
  final Schedule schedule;
  final String status;
  final int time;
  final DateTime date;

  Service({
    required this.name,
    required this.schedule,
    required this.status,
    required this.time,
    required this.date,
  });
}
