import 'package:agendamaq/controller/locality_controller.dart';
import 'package:agendamaq/models/locality.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalityPage extends StatefulWidget {
  const LocalityPage({super.key});

  @override
  State<LocalityPage> createState() => _LocalityPageState();
}

class _LocalityPageState extends State<LocalityPage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<LocalityController>(context, listen: false)
        .loadLocalitys()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalityController>(context).items;
    final List<Locality> loadedLocality = provider;
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
                      itemCount: loadedLocality.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(loadedLocality[index].name),
                            subtitle: Text(
                              '${loadedLocality[index].latitude}, ${loadedLocality[index].longitude}',
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AppRouters.CREATE_LOCALITY,
                                  arguments: loadedLocality[index],
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
                          .pushNamed(AppRouters.CREATE_LOCALITY);
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
