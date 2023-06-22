import 'package:agendamaq/app/home/home.dart';
import 'package:agendamaq/app/user/login_page.dart';
import 'package:agendamaq/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthSevices auth = Provider.of<AuthSevices>(context);
    if (auth.isLoanding)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return Home();
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
