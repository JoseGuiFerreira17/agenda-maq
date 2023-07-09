import 'package:flutter/material.dart';

class Locality with ChangeNotifier {
  final String id;
  final String name;
  final String latitude;
  final String longitude;

  Locality({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}
