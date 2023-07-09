import 'package:agendamaq/app/components/text_form.dart';
import 'package:agendamaq/controller/machine_controller.dart';
import 'package:agendamaq/models/machine.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMachine extends StatefulWidget {
  const CreateMachine({super.key});

  @override
  State<CreateMachine> createState() => _CreateMachineState();
}

class _CreateMachineState extends State<CreateMachine> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final Map<String, Object> _formData = {};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<MachineController>(context, listen: false)
          .createMachine(_formData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Ma´quina cadastrada com sucesso')),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      print('Não Validado');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final locality = ModalRoute.of(context)!.settings.arguments as Machine?;
      if (locality != null) {
        _formData['id'] = locality.id;
        _formData['name'] = locality.name;
        _nameController.text = locality.name;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text('Cadastrar Máquina'),
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
              TextFormFieldAdd(_nameController, 'Nome', 'name', _formData),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
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
