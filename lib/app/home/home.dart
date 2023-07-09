import 'package:agendamaq/app/locality/locality_page.dart';
import 'package:agendamaq/app/machine/machine_page.dart';
import 'package:agendamaq/app/schedule/schedule_page.dart';
import 'package:agendamaq/app/service/service_page.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    LocalityPage(),
    MachinePage(),
    SchedulePage(),
    ServicePage(),
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Deseja sair?'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove("access");
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRouters.INITIAL);
                              },
                              child: Text('SIM'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text('NÃO'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
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
