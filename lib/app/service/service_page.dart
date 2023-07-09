import 'package:agendamaq/controller/services_controller.dart';
import 'package:agendamaq/models/service.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<ServicesController>(context, listen: false)
        .loadServices()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServicesController>(context).items;
    final List<Service> loadedService = provider;
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
                      itemCount: loadedService.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(
                                '${loadedService[index].name}-${DateFormat('dd/MM/yyyy').format(loadedService[index].date)}'),
                            subtitle: Text(
                              loadedService[index].status,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AppRouters.CREATE_SERVICE,
                                    arguments: loadedService[index]);
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
                          .pushNamed(AppRouters.CREATE_SERVICE);
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
