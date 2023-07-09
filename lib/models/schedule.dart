import 'package:flutter/material.dart';

class Schedule with ChangeNotifier {
  final String id;
  final String month;
  final int year;
  final int workload;
  final String machine;
  final String locality;

  Schedule({
    required this.id,
    required this.month,
    required this.year,
    required this.workload,
    required this.machine,
    required this.locality,
  });
}
