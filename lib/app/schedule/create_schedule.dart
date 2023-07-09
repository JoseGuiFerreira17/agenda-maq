import 'package:agendamaq/app/components/text_form.dart';
import 'package:agendamaq/controller/locality_controller.dart';
import 'package:agendamaq/controller/machine_controller.dart';
import 'package:agendamaq/controller/schedule_controller.dart';
import 'package:agendamaq/models/schedule.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  final Map<String, Object> _formData = {};
  final _formKey = GlobalKey<FormState>();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _workloadController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<ScheduleController>(context, listen: false)
          .createSchedule(_formData);
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

  @override
  void dispose() {
    _monthController.dispose();
    _workloadController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final schedule = ModalRoute.of(context)!.settings.arguments as Schedule?;
      if (schedule != null) {
        _formData['id'] = schedule.id;
        _formData['month'] = schedule.month;
        _formData['year'] = schedule.year;
        _formData['workload'] = schedule.workload;
        _formData['machine'] = schedule.machine;
        _formData['locality'] = schedule.locality;

        _monthController.text = schedule.month;
        _yearController.text = schedule.year.toString();
        _workloadController.text = schedule.workload.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final machines = Provider.of<MachineController>(context);
    final locality = Provider.of<LocalityController>(context);
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
                TextFormFieldAdd(_monthController, 'Mês', 'month', _formData),
                const SizedBox(height: 20),
                TextFormFieldAdd(_yearController, 'Ano', 'year', _formData),
                const SizedBox(height: 20),
                TextFormFieldAdd(_workloadController, 'Carga horária',
                    'workload', _formData),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Máquina',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: _formData['machine'] ?? null,
                  items: machines.items.map((machine) {
                    return DropdownMenuItem(
                      value: machine.id,
                      child: Text(machine.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _formData['machine'] = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma máquina';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Localidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: _formData['locality'] ?? null,
                  items: locality.items.map((locality) {
                    return DropdownMenuItem(
                      value: locality.id,
                      child: Text(locality.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _formData['locality'] = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma localidade';
                    }
                    return null;
                  },
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
