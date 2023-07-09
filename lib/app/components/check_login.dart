import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('access');
  if (token == null) {
    return false;
  } else {
    return true;
  }
}
