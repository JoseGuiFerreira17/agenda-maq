import 'package:agendamaq/controller/locality_controller.dart';
import 'package:agendamaq/controller/machine_controller.dart';
import 'package:agendamaq/controller/schedule_controller.dart';
import 'package:agendamaq/models/schedule.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<ScheduleController>(context, listen: false)
        .loadSchedules()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleController>(context).items;
    final List<Schedule> loadedSchedule = provider;
    return Scaffold(
      backgroundColor: AgendaColors.setGrey,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: loadedSchedule.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(
                                '${loadedSchedule[index].month}-${loadedSchedule[index].year}'),
                            subtitle: Text(
                                '${Provider.of<MachineController>(context).getName(loadedSchedule[index].machine)} - ${Provider.of<LocalityController>(context).getName(loadedSchedule[index].locality)}'),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AppRouters.CREATE_SCHEDULE,
                                    arguments: loadedSchedule[index]);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: AgendaColors.setGreen,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouters.CREATE_SCHEDULE);
                    },
                    backgroundColor: AgendaColors.setGreen,
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
    );
  }
}
