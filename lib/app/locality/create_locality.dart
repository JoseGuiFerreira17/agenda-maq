import 'package:agendamaq/app/components/text_form.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class CreateLocality extends StatefulWidget {
  const CreateLocality({super.key});

  @override
  State<CreateLocality> createState() => _CreateLocalityState();
}

class _CreateLocalityState extends State<CreateLocality> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text('Cadastrar Localidade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TextFormFieldAdd(_nameController, 'Nome'),
              const SizedBox(height: 20),
              TextFormFieldAdd(_latitudeController, 'Email'),
              const SizedBox(height: 20),
              TextFormFieldAdd(_longitudeController, 'Telefone'),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AgendaColors.setGreen),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
