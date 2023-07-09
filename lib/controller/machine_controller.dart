import 'dart:convert';
import 'dart:math';

import 'package:agendamaq/models/machine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MachineController with ChangeNotifier {
  final List<Machine> _items = [];
  final _baseUrl = 'http://${dotenv.get('IP')}:8000/api/v1/machine/';
  List<Machine> get items => [..._items];

  Future<void> loadMachines() async {
    _items.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');
    Map<String, String> headers = {
      "Authorization": token.toString(),
    };
    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    data.forEach((data) {
      _items.add(Machine(
        id: data['id'].toString(),
        name: data['name'],
      ));
    });
    notifyListeners();
  }

  Future<void> createMachine(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newMachine = Machine(
      id: hasId ? data['id'].toString() : Random().nextDouble().toString(),
      name: data['name'].toString(),
    );
    if (hasId) {
      return updateMachine(newMachine);
    } else {
      return addMachine(newMachine);
    }
  }

  Future<void> addMachine(Machine machine) async {
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
          'name': machine.name,
        },
      ),
    );
    final idMachine = jsonDecode(response.body)['id'];
    _items.add(Machine(
      id: idMachine.toString(),
      name: machine.name,
    ));
    notifyListeners();
  }

  Future<void> updateMachine(Machine machine) async {
    int index = _items.indexWhere((element) => element.id == machine.id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('access').toString();
    if (index >= 0) {
      await http.put(
        Uri.parse('$_baseUrl${machine.id}/'),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            'name': machine.name,
          },
        ),
      );
      _items[index] = machine;
      notifyListeners();
    }
  }

  String getName(String id) {
    int index = _items.indexWhere((element) => element.id == id);
    return _items[index].name;
  }
}
