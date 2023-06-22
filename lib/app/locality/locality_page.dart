import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class LocalityPage extends StatelessWidget {
  const LocalityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AgendaColors.setGrey,
        body: Center(
          child: Text('Localidades'),
        ));
  }
}
