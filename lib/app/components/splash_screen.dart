import 'package:agendamaq/app/components/check_login.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, AppRouters.HOME);
      } else {
        Navigator.pushReplacementNamed(context, AppRouters.LOGIN_PAGE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
