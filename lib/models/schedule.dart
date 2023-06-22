import 'package:agendamaq/models/locality.dart';
import 'package:agendamaq/models/machine.dart';
import 'package:flutter/material.dart';

class Schedule with ChangeNotifier {
  final String mes;
  final int year;
  final int workload;
  final Machine machine;
  final Locality locality;

  Schedule({
    required this.mes,
    required this.year,
    required this.workload,
    required this.machine,
    required this.locality,
  });
}
