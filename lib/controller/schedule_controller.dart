import 'dart:convert';
import 'dart:math';

import 'package:agendamaq/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ScheduleController with ChangeNotifier {
  final List<Schedule> _items = [];
  final _baseUrl = 'http://${dotenv.get('IP')}:8000/api/v1/schedule/';
  List<Schedule> get items => [..._items];

  Future<void> loadSchedules() async {
    _items.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');
    Map<String, String> headers = {
      "Authorization": token.toString(),
    };
    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    data.forEach((data) {
      _items.add(Schedule(
        id: data['id'].toString(),
        month: data['month'],
        year: int.parse(data['year'].toString()),
        workload: int.parse(data['workload'].toString()),
        machine: data['machine'],
        locality: data['locality'],
      ));
    });
    notifyListeners();
  }

  Future<void> createSchedule(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newSchedule = Schedule(
      id: hasId ? data['id'].toString() : Random().nextDouble().toString(),
      month: data['month'].toString(),
      year: int.parse(data['year'].toString()),
      workload: int.parse(data['workload'].toString()),
      machine: data['machine'].toString(),
      locality: data['locality'].toString(),
    );
    if (hasId) {
      return updateSchedule(newSchedule);
    } else {
      return addSchedule(newSchedule);
    }
  }

  Future<void> addSchedule(Schedule schedule) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('access').toString();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'month': schedule.month,
          'year': schedule.year,
          'workload': schedule.workload,
          'machine': schedule.machine,
          'locality': schedule.locality,
        },
      ),
    );
    final idSchedule = jsonDecode(response.body)['id'];
    _items.add(Schedule(
        id: idSchedule.toString(),
        month: schedule.month,
        year: schedule.year,
        workload: schedule.workload,
        machine: schedule.machine,
        locality: schedule.locality));
    notifyListeners();
  }

  Future<void> updateSchedule(Schedule schedule) async {
    int index = _items.indexWhere((element) => element.id == schedule.id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('access').toString();
    if (index >= 0) {
      await http.put(
        Uri.parse('$_baseUrl${schedule.id}/'),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            'month': schedule.month,
            'year': schedule.year,
            'workload': schedule.workload,
            'machine': schedule.machine,
            'locality': schedule.locality,
          },
        ),
      );
      _items[index] = schedule;
      notifyListeners();
    }
  }
}
