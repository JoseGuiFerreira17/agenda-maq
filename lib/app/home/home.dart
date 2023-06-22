import 'package:agendamaq/app/locality/locality_page.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    LocalityPage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AgendaColors.setGrey,
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text('AgendaMaq'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_outlined,
              color: Colors.black,
            ),
            label: 'Localidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.agriculture_outlined,
              color: Colors.black,
            ),
            label: 'Máquinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Colors.black,
            ),
            label: 'Agendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work_history_outlined,
              color: Colors.black,
            ),
            label: 'Serviços',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AgendaColors.setGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}
