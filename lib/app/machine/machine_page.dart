import 'package:agendamaq/controller/machine_controller.dart';
import 'package:agendamaq/models/machine.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachinePage extends StatefulWidget {
  const MachinePage({super.key});

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<MachineController>(context, listen: false)
        .loadMachines()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MachineController>(context).items;
    final List<Machine> loadedMachine = provider;
    return Scaffold(
      backgroundColor: AgendaColors.setGrey,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: loadedMachine.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(loadedMachine[index].name),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AppRouters.CREATE_MACHINE,
                                  arguments: loadedMachine[index],
                                );
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
                          .pushNamed(AppRouters.CREATE_MACHINE);
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
