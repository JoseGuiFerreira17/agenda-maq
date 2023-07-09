import 'dart:convert';
import 'dart:math';

import 'package:agendamaq/models/locality.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LocalityController with ChangeNotifier {
  final List<Locality> _items = [];
  final _baseUrl = 'http://${dotenv.get('IP')}:8000/api/v1/locality/';
  List<Locality> get items => [..._items];

  Future<void> loadLocalitys() async {
    _items.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');
    Map<String, String> headers = {
      "Authorization": token.toString(),
    };
    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    data.forEach((data) {
      _items.add(Locality(
        id: data['id'].toString(),
        name: data['name'],
        latitude: data['latitude'],
        longitude: data['longitude'],
      ));
    });
    notifyListeners();
  }

  Future<void> createLocality(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newLocality = Locality(
      id: hasId ? data['id'].toString() : Random().nextDouble().toString(),
      name: data['name'].toString(),
      latitude: data['latitude'].toString(),
      longitude: data['longitude'].toString(),
    );
    if (hasId) {
      return updateLocality(newLocality);
    } else {
      return addLocality(newLocality);
    }
  }

  Future<void> addLocality(Locality locality) async {
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
          'name': locality.name,
          'latitude': locality.latitude,
          'longitude': locality.longitude,
        },
      ),
    );
    final idLocality = jsonDecode(response.body)['id'];
    _items.add(Locality(
      id: idLocality.toString(),
      name: locality.name,
      latitude: locality.latitude,
      longitude: locality.longitude,
    ));
    notifyListeners();
  }

  Future<void> updateLocality(Locality locality) async {
    int index = _items.indexWhere((element) => element.id == locality.id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('access').toString();
    if (index >= 0) {
      await http.put(
        Uri.parse('$_baseUrl${locality.id}/'),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            'name': locality.name,
            'latitude': locality.latitude,
            'longitude': locality.longitude,
          },
        ),
      );
      _items[index] = locality;
      notifyListeners();
    }
  }

  String getName(String id) {
    int index = _items.indexWhere((element) => element.id == id);
    return _items[index].name;
  }
}
