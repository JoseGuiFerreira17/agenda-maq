// ignore_for_file: unnecessary_null_comparison

import 'package:agendamaq/app/components/text_form.dart';
import 'package:agendamaq/controller/schedule_controller.dart';
import 'package:agendamaq/controller/services_controller.dart';
import 'package:agendamaq/models/service.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateService extends StatefulWidget {
  const CreateService({super.key});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  final Map<String, Object> _formData = {};
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _statusController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    _formData['date'] = _selectedDate;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<ServicesController>(context, listen: false)
          .createServices(_formData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Localidade cadastrada com sucesso')),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      print('Não Validado');
    }
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    ).then((value) => {
          if (value != null)
            {
              setState(() {
                _selectedDate = value;
              })
            }
        });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final service = ModalRoute.of(context)!.settings.arguments as Service?;
      if (service != null) {
        _formData['id'] = service.id;
        _formData['name'] = service.name;
        _formData['status'] = service.status;
        _formData['date'] = service.date;
        _formData['time'] = service.time;

        _nameController.text = service.name;
        _statusController.text = service.status;
        _timeController.text = service.time as String;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final schedules = Provider.of<ScheduleController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text('Cadastrar Localidade'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldAdd(_nameController, 'Nome', 'name', _formData),
                const SizedBox(height: 20),
                TextFormFieldAdd(
                    _statusController, 'Status', 'status', _formData),
                const SizedBox(height: 20),
                TextFormFieldAdd(
                    _timeController, 'Quantidade de horas', 'time', _formData),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Agenda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: _formData['schedule'] ?? null,
                  items: schedules.items.map((schedule) {
                    return DropdownMenuItem(
                      value: schedule.id,
                      child: Text('${schedule.month} - ${schedule.year}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _formData['schedule'] = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma agenda';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'Nenhuma data selecionada'
                              : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                AgendaColors.setGreen)),
                        onPressed: _showDatePicker,
                        child: const Text(
                          'Selecionar data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
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
      ),
    );
  }
}
