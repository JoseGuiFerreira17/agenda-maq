import 'package:agendamaq/app/home/home.dart';
import 'package:agendamaq/app/initial/initial.dart';
import 'package:agendamaq/app/user/create_user.dart';
import 'package:agendamaq/app/user/login_page.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:flutter/material.dart';

class AgendaMacApp extends StatelessWidget {
  const AgendaMacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda Mac',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      routes: {
        AppRouters.INITIAL: (context) => InitialPage(),
        AppRouters.CREATEUSER: (context) => CreateUser(),
        AppRouters.LOGIN_PAGE: (context) => LoginPage(),
      },
    );
  }
}
