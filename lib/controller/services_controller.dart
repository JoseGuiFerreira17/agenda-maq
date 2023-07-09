import 'dart:convert';
import 'dart:math';

import 'package:agendamaq/models/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServicesController with ChangeNotifier {
  final List<Service> _items = [];
  final _baseUrl = 'http://${dotenv.get('IP')}:8000/api/v1/service/';
  List<Service> get items => [..._items];

  Future<void> loadServices() async {
    _items.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');
    Map<String, String> headers = {
      "Authorization": token.toString(),
    };
    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    data.forEach((data) {
      _items.add(Service(
        id: data['id'].toString(),
        name: data['name'].toString(),
        schedule: data['schedule'].toString(),
        status: data['status'].toString(),
        time: int.parse(data['time'].toString()),
        date: DateTime.parse(data['date'].toString()),
      ));
    });
    notifyListeners();
  }

  Future<void> createServices(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newServices = Service(
      id: hasId ? data['id'].toString() : Random().nextDouble().toString(),
      name: data['name'].toString(),
      schedule: data['schedule'].toString(),
      status: data['status'].toString(),
      time: int.parse(data['time'].toString()),
      date: DateTime.parse(data['date'].toString()),
    );
    if (hasId) {
      return updateServices(newServices);
    } else {
      return addServices(newServices);
    }
  }

  Future<void> addServices(Service services) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('access').toString();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization": token,
      },
      body: {
        'name': services.name.toString(),
        'schedule': services.schedule.toString(),
        'status': services.status.toString(),
        'time': services.time.toString(),
        'date': services.date.toString(),
      },
    );
    final idServices = jsonDecode(response.body)['id'];
    _items.add(Service(
      id: idServices.toString(),
      name: services.name,
      schedule: services.schedule,
      status: services.status,
      time: services.time,
      date: services.date,
    ));
    notifyListeners();
  }

  Future<void> updateServices(Service services) async {
    int index = _items.indexWhere((element) => element.id == services.id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('access').toString();
    if (index >= 0) {
      await http.put(
        Uri.parse('$_baseUrl${services.id}/'),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: {
          'name': services.name,
          'schedule': services.schedule,
          'status': services.status,
          'time': services.time as int,
          'date': services.date.toString(),
        },
      );
      _items[index] = services;
      notifyListeners();
    }
  }
}
