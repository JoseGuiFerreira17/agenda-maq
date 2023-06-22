import 'package:agendamaq/agenda_maq.dart';
import 'package:agendamaq/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  //await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthSevices()),
      ],
      child: AgendaMacApp(),
    ),
  );
}
